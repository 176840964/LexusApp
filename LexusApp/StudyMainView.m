//
//  StudyMainView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/8.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyMainView.h"
#import <AVFoundation/AVFoundation.h>

#define kRecordAudioFile @"myRecord.caf"


typedef NS_ENUM(NSInteger, StudyMainViewRecorderType) {
    StudyMainViewRecorderTypeDefault,
    StudyMainViewRecorderTypeRecording,
    StudyMainViewRecorderTypePause,
    StudyMainViewRecorderTypeComplete,
    StudyMainViewRecorderTypeListening
};

@interface StudyMainView () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UILabel *recordTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
@property (weak, nonatomic) IBOutlet UIButton *tryListenBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;

@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (assign, nonatomic) StudyMainViewRecorderType recordType;
@property (assign, nonatomic) CGFloat recordTime;
@end

@implementation StudyMainView

- (void)sutupSubviews {
    [self setAudioSession];
    self.recordType = StudyMainViewRecorderTypeDefault;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -
- (void)setRecordType:(StudyMainViewRecorderType)recordType {
    _recordType = recordType;
    switch (recordType) {
        case StudyMainViewRecorderTypeDefault:
            self.recordBtn.enabled = YES;
            [self.recordBtn setTitle:@"record" forState:UIControlStateNormal];
            
            self.completeBtn.enabled = NO;
            self.tryListenBtn.enabled = NO;
            [self.tryListenBtn setTitle:@"try" forState:UIControlStateNormal];
            self.delBtn.enabled = NO;
            self.uploadBtn.enabled = NO;
            
            self.recordTime = 0;
            self.recordTimeLab.text = @"时长：00:00";
            
            break;
        case StudyMainViewRecorderTypeRecording:
            self.recordBtn.enabled = YES;
            [self.recordBtn setTitle:@"pause" forState:UIControlStateNormal];
            
            self.completeBtn.enabled = YES;
            self.tryListenBtn.enabled = NO;
            [self.tryListenBtn setTitle:@"try" forState:UIControlStateNormal];
            self.delBtn.enabled = NO;
            self.uploadBtn.enabled = NO;
            
            break;
        case StudyMainViewRecorderTypePause:
            self.recordBtn.enabled = YES;
            [self.recordBtn setTitle:@"record" forState:UIControlStateNormal];
            
            self.completeBtn.enabled = YES;
            self.tryListenBtn.enabled = NO;
            [self.tryListenBtn setTitle:@"try" forState:UIControlStateNormal];
            self.delBtn.enabled = NO;
            self.uploadBtn.enabled = NO;
            break;
        case StudyMainViewRecorderTypeComplete:
            self.recordBtn.enabled = NO;
            [self.recordBtn setTitle:@"record" forState:UIControlStateNormal];
            
            self.completeBtn.enabled = NO;
            self.tryListenBtn.enabled = YES;
            [self.tryListenBtn setTitle:@"try" forState:UIControlStateNormal];
            self.delBtn.enabled = YES;
            self.uploadBtn.enabled = YES;
            break;
        case StudyMainViewRecorderTypeListening:
            self.recordBtn.enabled = NO;
            self.completeBtn.enabled = NO;
            self.tryListenBtn.enabled = NO;
            [self.tryListenBtn setTitle:@"listening" forState:UIControlStateNormal];
            self.delBtn.enabled = YES;
            self.uploadBtn.enabled = YES;
            break;
            
        default:
            break;
    }
}

-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}


-(NSURL *)getSavePath{
    NSString *urlStr=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr=[urlStr stringByAppendingPathComponent:kRecordAudioFile];
    NSLog(@"file path:%@",urlStr);
    NSURL *url=[NSURL fileURLWithPath:urlStr];
    return url;
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[self getSavePath];
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        _audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _audioRecorder.delegate=self;
        _audioRecorder.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecorder;
}

/**
 *  创建播放器
 *
 *  @return 播放器
 */
-(AVAudioPlayer *)audioPlayer{
    if (!_audioPlayer) {
        NSURL *url=[self getSavePath];
        NSError *error=nil;
        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        _audioPlayer.delegate = self;
        _audioPlayer.numberOfLoops=0;
        [_audioPlayer prepareToPlay];
        if (error) {
            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioPlayer;
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(audioPowerChange) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
//    [self.audioRecorder updateMeters];//更新测量值
//    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
//    CGFloat progress=(1.0/160.0)*(power+160.0);
    self.recordTime += self.timer.timeInterval;
    CGFloat min = (NSInteger)self.recordTime / 60;
    CGFloat second = (NSInteger)self.recordTime % 60;
    self.recordTimeLab.text = [NSString stringWithFormat:@"时长：%02.0f:%02.0f", min, second];
    
    if (self.recordTime >= 30.0) {
        [self onTapRecordCompleteBtn:nil];
    }
}

#pragma mark - IBAction
- (IBAction)onTapRecordBtn:(id)sender {
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate = [NSDate distantPast];
        self.recordType = StudyMainViewRecorderTypeRecording;
    } else {
        [self.audioRecorder pause];
        self.timer.fireDate = [NSDate distantFuture];
        self.recordType = StudyMainViewRecorderTypePause;
    }
}

- (IBAction)onTapRecordCompleteBtn:(id)sender {
    [self.audioRecorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    self.recordType = StudyMainViewRecorderTypeComplete;
}

- (IBAction)onTapTryListenBtn:(id)sender {
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        self.recordType = StudyMainViewRecorderTypeListening;
    }
}

- (IBAction)onTapDelRecordBtn:(id)sender {
    if ([self.audioRecorder deleteRecording]) {
        self.recordType = StudyMainViewRecorderTypeDefault;
        self.audioPlayer = nil;
    }
}

- (IBAction)onTapUploadRecordBtn:(id)sender {
    
}

#pragma mark - AVAudioRecorderDelegate
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        self.recordType = StudyMainViewRecorderTypeListening;
    }
    NSLog(@"录音完成!");
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.recordType = StudyMainViewRecorderTypeComplete;
}

@end
