//
//  BaseViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/8/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "BaseViewController.h"
#import "AccelerometerManager.h"
#import "CustomLoginCtrl.h"

#define BgImageFrameDistance 10

@interface BaseViewController () <UIAccelerometerDelegate>
@property (strong, nonatomic) UIButton *backBtn;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupSubviews];
    
    self.isBgCanShake = NO;
    self.isShowBackBtn = NO;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (void)setIsShowBackBtn:(BOOL)isShowBackBtn {
    _isShowBackBtn = isShowBackBtn;
    _backBtn.hidden = !isShowBackBtn;
}

#pragma mark - 
- (void)setupSubviews {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(-BgImageFrameDistance, -BgImageFrameDistance, CGRectGetWidth(self.view.bounds) + BgImageFrameDistance * 2, CGRectGetHeight(self.view.bounds) + BgImageFrameDistance * 2)];
    _bgImgView.contentMode = UIViewContentModeScaleAspectFill;
    _bgImgView.image = [UIImage imageNamed:@"bg1"];
    [self.view addSubview:_bgImgView];
    [self.view sendSubviewToBack:_bgImgView];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 19, CGRectGetWidth(self.view.bounds), 28)];
    _titleLab.textColor = [UIColor colorWithHexString:@"7c7c7c"];
    _titleLab.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:20];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLab];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - 135, 81, 58);
    _backBtn.backgroundColor = [UIColor clearColor];
    [_backBtn setImage:[UIImage imageNamed:@"backBtn_normal"] forState:UIControlStateNormal];
    [_backBtn setImage:[UIImage imageNamed:@"backBtn_highlight"] forState:UIControlStateHighlighted];
    [_backBtn addTarget:self action:@selector(onTapBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
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
