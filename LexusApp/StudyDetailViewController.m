//
//  StudyDetailViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyDetailViewController.h"
#import "StudyListTableViewCell.h"
#import "StudyMainView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StudyDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainScrollViewWidth1;
@property (weak, nonatomic) IBOutlet StudyMainView *studyMainView;

@property (weak, nonatomic) IBOutlet UIScrollView *listScrollView;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLab;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) NSMutableArray *listDataArr;
@property (strong, nonatomic) AVPlayerViewController *playerController;
@property (strong, nonatomic) AVPlayer *songPlayer;
@end

@implementation StudyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.studyMainView sutupSubviews];
    
    self.titleLab.text = @"学习平台";
    
    self.listDataArr = [[NSMutableArray alloc] init];
    
    [self.listTableView registerNib:[UINib nibWithNibName:@"StudyListTableViewCell" bundle:nil] forCellReuseIdentifier:@"StudyListTableViewCell"];
    
    [self createPlayerControllerWithResource:@"testVideo.mp4"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UserManager shareUserManager].isLoginStudy = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mainScrollView setContentOffset:CGPointZero animated:NO];
    [self.listScrollView setContentOffset:CGPointZero animated:NO];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.mainScrollViewWidth1.constant = (CGRectGetWidth(self.view.bounds) - 335) * 3;
}

#pragma mark -
- (void)createPlayerControllerWithResource:(NSString *)resUrlStr {
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:resUrlStr ofType:nil];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:urlStr]];
    _playerController = [[AVPlayerViewController alloc] init];
    _playerController.player = player;
    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerController.allowsPictureInPicturePlayback = YES;    //画中画，iPad可用
    _playerController.showsPlaybackControls = YES;
    
    [self addChildViewController:_playerController];
    [self.studyMainView.videoView addSubview:_playerController.view];
    _playerController.view.frame = self.studyMainView.videoView.bounds;
}

- (void)createSondPlayerWithResource:(NSString *)resUrlStr {
    _songPlayer = [[AVPlayer alloc] initWithPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:resUrlStr]]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationForPlayeDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [_songPlayer play];
}

- (void)notificationForPlayeDidEnd:(NSNotification*)notify {
    NSLog(@"play did end");
    self.songPlayer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - IBAction
- (IBAction)onTapSelectedCarModelBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds), 0) animated:YES];
}

- (IBAction)onTapSelectedKmBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds)) * 2, 0) animated:YES];
}

- (IBAction)onTapBestListCtrl:(id)sender {
    [[NetworkingManager shareManager] testNetworkingWithGetMethodPath:@"song/getSongNumByPage?" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"page": @(0), @"limit": @(10)} success:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = [dic objectForKey:@"listSong"];
        
        for (NSDictionary *songDic in arr) {
            StudyListModel *model = [[StudyListModel alloc] initWithDic:songDic];
            [self.listDataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.listTitleLab.text = @"优 秀 榜";
            [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
            [self.listTableView reloadData];
        });
    }];
    
}

- (IBAction)onTapUpdateListCtrl:(id)sender {
    
    [[NetworkingManager shareManager] testNetworkingWithGetMethodPath:@"song/getSongUpdateByPage?" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"page": @(0), @"limit": @(10)} success:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = [dic objectForKey:@"listSong"];
        
        for (NSDictionary *songDic in arr) {
            StudyListModel *model = [[StudyListModel alloc] initWithDic:songDic];
            [self.listDataArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.listTitleLab.text = @"更 新 榜";
            [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
            [self.listTableView reloadData];
        });
    }];
    
    self.listTitleLab.text = @"更 新 榜";
    [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
}

- (IBAction)onTapListBackBtn:(id)sender {
    [self.listDataArr removeAllObjects];
    [self.listScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyListTableViewCell"];
    StudyListModel *model = [self.listDataArr objectAtIndex:indexPath.row];
    
    [cell layoutSubViewsByStudyListModel:model andIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    StudyListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *urlStr = [NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", cell.studyModel.song_url];
//    [self createSondPlayerWithResource:urlStr];
    [self createSondPlayerWithResource:@"http://127.0.0.1/myRecord.mp3"];
}
@end
