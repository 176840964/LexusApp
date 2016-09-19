//
//  BaseViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/8/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "BaseViewController.h"
#import "AccelerometerManager.h"

#define BgImageFrameDistance 10

@interface BaseViewController () <UIAccelerometerDelegate>
@property (strong, nonatomic) UIImageView *markImgView;
@property (strong, nonatomic) UIButton *logoBtn;
@property (strong, nonatomic) UIButton *homeBtn;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *optionBtn;
@property (strong, nonatomic) UIView *optionView;
@property (strong, nonatomic) UIButton *backBtn;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupSubviews];
    
    self.isBgCanShake = NO;
    self.isLogoBtnEnable = NO;
    self.isShowHomeBtn = YES;
    self.isShowBackBtn = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setIsBgCanShake:(BOOL)isBgCanShake {
    _isBgCanShake = isBgCanShake;
    if (_isBgCanShake) {
        [[AccelerometerManager shareAccelerometerManager] addOberser:self];
    } else {
        [[AccelerometerManager shareAccelerometerManager] removeObserver];
    }
}

- (void)setIsLogoBtnEnable:(BOOL)isLogoBtnEnable {
    _isLogoBtnEnable = isLogoBtnEnable;
    _logoBtn.enabled = isLogoBtnEnable;
}

- (void)setIsShowHomeBtn:(BOOL)isShowHomeBtn {
    _isShowHomeBtn = isShowHomeBtn;
    _homeBtn.hidden = !isShowHomeBtn;
}

- (void)setIsShowBackBtn:(BOOL)isShowBackBtn {
    _isShowBackBtn = isShowBackBtn;
    _backBtn.hidden = !isShowBackBtn;
}

#pragma mark - 
- (void)setupSubviews {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-BgImageFrameDistance, -BgImageFrameDistance, CGRectGetWidth(self.view.bounds) + BgImageFrameDistance * 2, CGRectGetHeight(self.view.bounds) + BgImageFrameDistance * 2)];
    [self.view addSubview:_bgImgView];
    [self.view sendSubviewToBack:_bgImgView];
    
    _markImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgMark"]];
    _markImgView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
    [self.view addSubview:_markImgView];
    
    _logoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logoBtn.frame = CGRectMake(10, 20, 136, 25);
    [_logoBtn setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
    [_logoBtn addTarget:self action:@selector(onTapLogoBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_logoBtn];
    
    _optionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _optionBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 19 - 28, 18, 28, 28);
    [_optionBtn setImage:[UIImage imageNamed:@"option_btn_normal"] forState:UIControlStateNormal];
    [_optionBtn setImage:[UIImage imageNamed:@"option_btn_highlight"] forState:UIControlStateHighlighted];
    [_optionBtn addTarget:self action:@selector(onTapOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_optionBtn];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(CGRectGetMinX(_optionBtn.frame) - 10 - 200, 18, 200, 28);
    _loginBtn.backgroundColor = [UIColor redColor];
    [_loginBtn addTarget:self action:@selector(onTapLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    _homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _homeBtn.frame = CGRectMake(CGRectGetMinX(_loginBtn.frame) - 28 - 10, 18, 28, 28);
    [_homeBtn setImage:[UIImage imageNamed:@"home_btn_normal"] forState:UIControlStateNormal];
    [_homeBtn setImage:[UIImage imageNamed:@"home_btn_highlight"] forState:UIControlStateHighlighted];
    [_homeBtn addTarget:self action:@selector(onTapHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeBtn];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.view.bounds), 50)];
    _titleLab.textColor = [UIColor redColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLab];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 135, 81, 58);
    _backBtn.backgroundColor = [UIColor grayColor];
    [_backBtn addTarget:self action:@selector(onTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
}

- (void)onTapLogoBtn:(UIButton *)btn {
    [self.customTabbarController showStudyViewController];
}

- (void)onTapOptionBtn:(UIButton *)btn {
    if (self.customTabbarController.tabbarView.hidden) {
        [self.customTabbarController showTabbarView:YES];
    } else {
        [self.customTabbarController dismissTabbarView:YES];
    }
}

- (void)onTapLoginBtn:(UIButton *)btn {
    [self.customTabbarController showLoginViewController];
}

- (void)onTapHomeBtn:(UIButton *)btn {
    [self.customTabbarController setSelectedIndex:0 isAnimated:NO];
    UINavigationController *homeController = [self.customTabbarController.viewControllersArr firstObject];
    [homeController popToRootViewControllerAnimated:NO];
    [self.customTabbarController dismissTabbarView:NO];
}

- (void)onTapBackBtn:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIAccelerometerDelegate
- (void)accelerometerManager:(AccelerometerManager *)accelerometerManager withX:(NSNumber*)x withY:(NSNumber*)y withZ:(NSNumber*)z withTimeInterval:(NSTimeInterval)timeInterval {
    
    //DeviceOrientationIsLandscape，设备方式水平方向，x和y互换
    NSNumber *accelerometer_x = y;
    NSNumber *accelerometer_y = x;
    
    CGFloat deceleration = 0.4f;
    CGFloat sensitivity  = 6.0f;
    CGFloat maxVelocity  = 100.0f;
    
    CGPoint velocity = CGPointZero;
    
    velocity.x = velocity.x * deceleration + [accelerometer_x doubleValue] * sensitivity;
    velocity.y = velocity.y * deceleration + [accelerometer_y doubleValue] * sensitivity;
    
    if(velocity.x > maxVelocity){
        velocity.x = maxVelocity;
    }else if(velocity.x < -maxVelocity){
        velocity.x = -maxVelocity;
    }
    
    if(velocity.y > maxVelocity){
        velocity.y = maxVelocity;
    }else if(velocity.y < -maxVelocity){
        velocity.y = -maxVelocity;
    }
    
    CGPoint pos = self.bgImgView.center;
    pos.x += velocity.x;
    pos.y -= velocity.y;
    
    float imageWidthHalved =  CGRectGetWidth(self.bgImgView.frame) * 0.5f;
    float leftBorderLimit  = 0.0f;
    float rightBorderLimit = 0.0f;
    if (imageWidthHalved>self.view.frame.size.width/2.0f) {
        leftBorderLimit  =   self.view.frame.size.width - imageWidthHalved;
        rightBorderLimit =  imageWidthHalved;
    }
    else
    {
        leftBorderLimit  =   imageWidthHalved ;
        rightBorderLimit =  self.view.frame.size.width - imageWidthHalved;
    }
    
    
    
    float imageHeightHalved = CGRectGetHeight(self.bgImgView.frame) * 0.5f;
    float topBorderLimit    = 0.0f;
    float bottomBorderLimit = 0.0f;
    if (imageHeightHalved>self.view.frame.size.height/2.0f) {
        topBorderLimit    = self.view.frame.size.height - imageHeightHalved;
        bottomBorderLimit =  imageHeightHalved ;
    }
    else
    {
        topBorderLimit    = imageHeightHalved ;
        bottomBorderLimit = self.view.frame.size.height - imageHeightHalved  ;
    }
    
    
    if(pos.x < leftBorderLimit){
        pos.x = leftBorderLimit;
        velocity = CGPointZero;
    }else if(pos.x > rightBorderLimit){
        pos.x = rightBorderLimit;
        velocity = CGPointZero;
    }
    
    if(pos.y < topBorderLimit){
        pos.y = topBorderLimit;
        velocity = CGPointZero;
    }else if(pos.y > bottomBorderLimit){
        pos.y = bottomBorderLimit;
        velocity = CGPointZero;
    }
    
    self.bgImgView.center = pos;
}

@end
