//
//  StudyDetailViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyDetailViewController.h"
#import "StudyListTableViewCell.h"
#import "StudyUpdateListTableViewCell.h"
#import "StudyMainView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "StudySelectCarView.h"
#import "StudySelectKMView.h"
#import "../Pods/MJRefresh/MJRefresh/MJRefresh.h"

#define limit 10

@interface StudyDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainScrollViewWidth1;
@property (weak, nonatomic) IBOutlet StudySelectCarView* studySelectCarView;
@property (weak, nonatomic) IBOutlet StudySelectKMView* studySelectKMView;
@property (weak, nonatomic) IBOutlet StudyMainView *studyMainView;

@property (weak, nonatomic) IBOutlet UIScrollView *listScrollView;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLab;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (assign, nonatomic) BOOL isShowBestList;
@property (assign, nonatomic) NSInteger page;

@property (strong, nonatomic) NSMutableArray *listDataArr;
@property (strong, nonatomic) AVPlayerViewController *playerController;
@property (strong, nonatomic) AVPlayer *songPlayer;
@property (assign, nonatomic) NSInteger listeningIndex;

@end

@implementation StudyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listeningIndex = -1;
    
    [self.studyMainView sutupSubviews];
    self.titleLab.text = @"学习平台";
    
    self.page = 0;
    self.listDataArr = [[NSMutableArray alloc] init];
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self getNetworkData];
    }];
    
    self.listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getNetworkData];
    }];
    
    [self createPlayerControllerWithResource:@"testVideo.mp4"];
    
    
    __weak typeof(self) weakSelf = self;
    self.studySelectCarView.selectedCarHandle = ^(NSString *carName, NSString *carModel) {
        [weakSelf.studySelectKMView setupSubviewsByCarName:carName carModel:carModel];
        [weakSelf.mainScrollView setContentOffset:CGPointMake(weakSelf.studySelectCarView.width, 0) animated:YES];
    };
    self.studySelectKMView.tapBackBtnHandle = ^() {
        [weakSelf.mainScrollView setContentOffset:CGPointZero animated:YES];
    };
    self.studySelectKMView.selectedKMHandle = ^(NSString *km, NSString *carAllName) {
        [weakSelf.mainScrollView setContentOffset:CGPointMake(CGRectGetMaxX(weakSelf.studySelectKMView.frame), 0) animated:YES];
        [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"learn/addLearnPlatUse" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"car_type" : carAllName, @"car_oper" : km} success:^(id responseObject) {
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic:%@", dic);
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UserManager shareUserManager].isLoginStudy = NO;
    
    [self.studySelectCarView setupSubviews];
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
    self.songPlayer = nil;
    [self endListeningRecordByIndex:self.listeningIndex];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - Networking
- (void)getNetworkData {
    NSString *path = self.isShowBestList ? @"song/getSongNumByPage?" : @"song/getSongUpdateByPage?";
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:path params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"page": @(self.page), @"limit": @(limit)} success:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = [dic objectForKey:@"listSong"];
        
        
        NSMutableArray *dataArr = [NSMutableArray new];
        for (NSDictionary *songDic in arr) {
            StudyListModel *model = [[StudyListModel alloc] initWithDic:songDic];
            [dataArr addObject:model];
        }
        
        if (0 == self.page) {
            [self.listDataArr removeAllObjects];
            [self.listTableView.mj_header endRefreshing];
        }
        
        [self.listDataArr addObjectsFromArray:dataArr];
        [self.listTableView.mj_footer endRefreshing];
        
        if (dataArr.count < limit) {
            [self.listTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
            [self.listTableView reloadData];
        });
    }];
}

- (void)updateSongByCsid:(NSNumber *)csid {//点赞
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"song/updateSongNum" params:@{@"csid": csid} success:^(id responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"点赞 dic:%@", dic);
        dispatch_async(dispatch_get_main_queue(), ^{
        }); 
    }];
}

- (void)endListeningRecordByIndex:(NSInteger)index {//声音播放完打点
    StudyListModel *model = [self.listDataArr objectAtIndex:index];
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"song/addSongUse" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"learnid" : model.csid} success:^(id responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"声音播放完打点 dic:%@", dic);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.listeningIndex = -1;
        });
    }];
}

#pragma mark - IBAction
- (IBAction)onTapSelectedCarModelBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds), 0) animated:YES];
}

- (IBAction)onTapSelectedKmBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds)) * 2, 0) animated:YES];
}

- (IBAction)onTapBestListCtrl:(id)sender {
    self.isShowBestList = YES;
    [self.listTableView registerNib:[UINib nibWithNibName:@"StudyListTableViewCell" bundle:nil] forCellReuseIdentifier:@"StudyListTableViewCell"];
    self.listTitleLab.text = @"优 秀 榜";
    [self getNetworkData];
}

- (IBAction)onTapUpdateListCtrl:(id)sender {
    self.isShowBestList = NO;
    [self.listTableView registerNib:[UINib nibWithNibName:@"StudyUpdateListTableViewCell" bundle:nil] forCellReuseIdentifier:@"StudyUpdateListTableViewCell"];
    self.listTitleLab.text = @"更 新 榜";
    
    [self getNetworkData];
}

- (IBAction)onTapListBackBtn:(id)sender {
    self.page = 0;
    [self.listDataArr removeAllObjects];
    [self.listScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudyListModel *model = [self.listDataArr objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    
    if (self.isShowBestList) {
        StudyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyListTableViewCell"];
        [cell layoutSubViewsByStudyListModel:model index:indexPath.row listeningIndex:self.listeningIndex];
        cell.tapListenBtnHandle = ^(StudyListModel *model) {
            weakSelf.listeningIndex = indexPath.row;
            NSString *urlStr = [NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.song_url];
            [weakSelf createSondPlayerWithResource:urlStr];
        };
        
        return cell;
    } else {
        StudyUpdateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyUpdateListTableViewCell"];
        [cell layoutSubViewsByStudyListModel:model index:indexPath.row];
        
        cell.tapListenBtnHandle = ^(StudyListModel *model) {
            weakSelf.listeningIndex = indexPath.row;
            NSString *urlStr = [NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.song_url];
            [weakSelf createSondPlayerWithResource:urlStr];
        };
        
        cell.tapGoodBtnHandle = ^(StudyListModel *model) {
            [weakSelf updateSongByCsid:model.csid];
        };
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
