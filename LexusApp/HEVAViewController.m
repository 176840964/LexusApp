//
//  HEVAViewController.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/23.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "HEVAViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HEVAViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewWidth;
@property (weak, nonatomic) IBOutlet CustomZoomScaleImageView *zoomScaleView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

@property (strong, nonatomic) AVPlayerViewController *playerController;
@end

@implementation HEVAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLab.text = @"HEV优势";
    [self.zoomScaleView layoutCustomZoomScaleImageView];
    self.zoomScaleView.image = [UIImage imageNamed:@"HEV1"];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.mainViewWidth.constant = CGRectGetWidth(self.view.bounds) * 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.scrollView.contentOffset = CGPointZero;
    [self setupLeftArrowBtnAndRightArrowBtnEnable];
    
    [self createPlayerControllerWithResource:@"testVideo.mp4"];
}

#pragma mark -
- (void)setupLeftArrowBtnAndRightArrowBtnEnable {
    if (0 == self.scrollView.contentOffset.x) {
        self.leftArrowBtn.enabled = NO;
        self.rightArrowBtn.enabled = YES;
    } else if (1 * self.view.width == self.scrollView.contentOffset.x) {
        self.rightArrowBtn.enabled = NO;
        self.leftArrowBtn.enabled = YES;
    } else {
        self.rightArrowBtn.enabled = YES;
        self.leftArrowBtn.enabled = YES;
    }
}

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
    [self.videoView addSubview:_playerController.view];
    _playerController.view.frame = self.videoView.bounds;
}

#pragma mark - IBAction
- (IBAction)onTapLeftArrowBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake((self.pageCtrl.currentPage - 1) * self.view.width, 0) animated:YES];
}

- (IBAction)onTapRightArrowBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake((self.pageCtrl.currentPage + 1) * self.view.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.playerController.player pause];
    self.pageCtrl.currentPage = scrollView.contentOffset.x / self.view.width;
    [self setupLeftArrowBtnAndRightArrowBtnEnable];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
