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
@end

@implementation StudyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.studyMainView sutupSubviews];
    
    self.titleLab.text = @"学习平台";
    
    self.listDataArr = [[NSMutableArray alloc] init];
    
    [self.listTableView registerNib:[UINib nibWithNibName:@"StudyListTableViewCell" bundle:nil] forCellReuseIdentifier:@"StudyListTableViewCell"];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"testVideo.mp4" ofType:nil];
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:urlStr]];
    _playerController = [[AVPlayerViewController alloc] init];
    _playerController.player = player;
    _playerController.videoGravity = AVLayerVideoGravityResizeAspect;
    _playerController.allowsPictureInPicturePlayback = YES;    //画中画，iPad可用
    _playerController.showsPlaybackControls = YES;
    
    [self addChildViewController:_playerController];
    [self.studyMainView.videoView addSubview:_playerController.view];
    _playerController.view.frame = self.studyMainView.videoView.bounds;
//    [_playerController.player play];
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

#pragma mark - IBAction
- (IBAction)onTapSelectedCarModelBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds), 0) animated:YES];
}

- (IBAction)onTapSelectedKmBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds)) * 2, 0) animated:YES];
}

- (IBAction)onTapBestListCtrl:(id)sender {
    [[NetworkingManager shareManager] testNetworkingWithGetMethodPath:@"song/getSongNumByPage?" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"page": @(0), @"limit": @(10)} success:^(id responseObject) {
        NSArray *arr = responseObject;
        NSLog(@"%@", arr);
    }];
    
//    self.listTitleLab.text = @"优 秀 榜";
//    [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
}

- (IBAction)onTapUpdateListCtrl:(id)sender {
    self.listTitleLab.text = @"更 新 榜";
    [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
}

- (IBAction)onTapListBackBtn:(id)sender {
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

@end
