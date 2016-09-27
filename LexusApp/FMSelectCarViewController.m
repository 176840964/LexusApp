//
//  FMSelectCarViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/1.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectCarViewController.h"
#import "CarSelectedItemView.h"
#import "FMSelectKmViewController.h"

@interface FMSelectCarViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;

@property (strong, nonatomic) CarSelectedItemView *curCarItemView;
@property (strong, nonatomic) CarSelectedItemView *nextCarItemView;
@property (assign, nonatomic) NSInteger curSelectedIndex;
@property (strong, nonatomic) NSMutableArray *carModelBtnArr;
@property (copy, nonatomic) NSString *selectedCarNameStr;
@property (strong, nonatomic) NSArray *carModelsArr;
@property (copy, nonatomic) NSString *selectedCarModelStr;
@end

@implementation FMSelectCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.customTabbarController.homeBtn.hidden = NO;
    
    self.bgImgView.image = [UIImage imageNamed:@"bg2"];
    self.isBgCanShake = YES;
    
    __weak typeof(self) weakSelf = self;
    
    self.nextCarItemView = [CarSelectedItemView newAutoLayoutView];
    self.nextCarItemView.alpha = 0.0;
    [self.view addSubview:self.nextCarItemView];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:30];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:30];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:90];
    [self.nextCarItemView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.nextCarItemView withMultiplier:977 / 163.0];
    self.nextCarItemView.touchHotRangeHandle = ^(NSInteger offset) {
        [weakSelf showSpecifiedCarItemByOffset:offset];
    };
    [self setGestureRecognizerOnCarSelectedItemView:self.nextCarItemView];
    
    self.curCarItemView = [CarSelectedItemView newAutoLayoutView];
    self.curCarItemView.alpha = 1.0;
    [self.view addSubview:self.curCarItemView];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:30];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:30];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:90];
    [self.curCarItemView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.curCarItemView withMultiplier:977 / 163.0];
    self.curCarItemView.touchHotRangeHandle = ^(NSInteger offset) {
        [weakSelf showSpecifiedCarItemByOffset:offset];
    };
    [self setGestureRecognizerOnCarSelectedItemView:self.curCarItemView];
    
    self.curSelectedIndex = 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"width:%f, height:%f", self.curCarItemView.width, self.curCarItemView.height);
//    NSArray *arr = [CarPositionManager shareInstance].carPosArr;
//    for (CarPosItem *item in arr) {
//        CGRect rect = [item realRectByFatherViewWidth:self.curCarItemView.width height:self.curCarItemView.height];
//        NSLog(@"rect:%@", NSStringFromCGRect(rect));
//        UIView *view = [[UIView alloc] initWithFrame:rect];
//        view.backgroundColor = [UIColor redColor];
//        [self.curCarItemView addSubview:view];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setGestureRecognizerOnCarSelectedItemView:(CarSelectedItemView *)itemView {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCarSelectedItemView:)];
    [itemView addGestureRecognizer:pan];
}

#pragma mark - 
- (void)showSpecifiedCarItemByOffset:(NSInteger)offset {
    NSInteger count = [CarCategoreManager shareManager].carsCount;
    NSInteger nextIndex = self.curSelectedIndex + offset;
    if (nextIndex >= count) {
        nextIndex = nextIndex % count;
    } else if (nextIndex < 0) {
        nextIndex = count + nextIndex;
    }
    self.nextCarItemView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"car%zd", nextIndex]];
    
    self.curSelectedIndex = nextIndex;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.nextCarItemView.alpha = 1.0;
    } completion:^(BOOL finished) {
        CarSelectedItemView *tmp = [CarSelectedItemView new];
        tmp = weakSelf.curCarItemView;
        weakSelf.curCarItemView = weakSelf.nextCarItemView;
        weakSelf.nextCarItemView = tmp;
        
        [weakSelf.view bringSubviewToFront:weakSelf.curCarItemView];
    }];
}

- (void)panCarSelectedItemView:(UIPanGestureRecognizer *)pan {
    CGFloat limit = 30;
    CGPoint point = [pan translationInView:pan.view];
    CGFloat tx = point.x / 10.0;
    
    NSInteger count = [CarCategoreManager shareManager].carsCount;
    NSInteger nextIndex;
    if (tx <= 0) {
        nextIndex = self.curSelectedIndex + 1;
        if (nextIndex == count) {
            nextIndex = nextIndex % count;
        }
    } else {
        nextIndex = self.curSelectedIndex - 1;
        if (nextIndex < 0) {
            nextIndex = count + nextIndex;
        }
    }
    self.nextCarItemView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"car%zd", nextIndex]];
    
    if (limit < fabs(tx)) {
        pan.view.alpha = (limit - (fabs(tx) - limit)) / limit;
        self.nextCarItemView.alpha = (fabs(tx) - limit) / limit;
    }
    
    if (UIGestureRecognizerStateEnded == pan.state) {
        self.curSelectedIndex = nextIndex;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 * pan.view.alpha animations:^{
            pan.view.alpha = 0.0;
            weakSelf.nextCarItemView.alpha = 1.0;
        } completion:^(BOOL finished) {
            CarSelectedItemView *tmp = [CarSelectedItemView new];
            tmp = weakSelf.curCarItemView;
            weakSelf.curCarItemView = weakSelf.nextCarItemView;
            weakSelf.nextCarItemView = tmp;
            
            [weakSelf.view bringSubviewToFront:weakSelf.curCarItemView];
        }];
    }
}

- (void)setCurSelectedIndex:(NSInteger)curSelectedIndex {
    _curSelectedIndex = curSelectedIndex;
    
    for (UIButton *btn in self.carModelBtnArr) {
        [btn removeFromSuperview];
    }
    [self.carModelBtnArr removeAllObjects];
    
    NSDictionary *carInfo = [[CarCategoreManager shareManager] getCarInfoDicByIndex:_curSelectedIndex];
    self.selectedCarNameStr = [carInfo objectForKey:@"name"];
    self.titleLab.text = self.selectedCarNameStr;
    self.carModelsArr = [[CarCategoreManager shareManager] getCarModelsByCarName:self.selectedCarNameStr];
    self.carImgView.image = [UIImage imageNamed:self.selectedCarNameStr];
    self.curCarItemView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"car%zd", _curSelectedIndex]];
    
    NSInteger x = (CGRectGetWidth(self.view.bounds) - (100 * self.carModelsArr.count + 35 * (self.carModelsArr.count - 1))) / 2.0;
    for (NSInteger index = 0; index < self.carModelsArr.count; index ++) {
        NSString *carModel = [self.carModelsArr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(x + (100 + 35) * index, self.view.center.y + 102 + 5, 100, 38);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:12];
        [btn setTitle:[NSString stringWithFormat:@"%@%@", self.selectedCarNameStr, carModel] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#89939c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#373737"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_highlight"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(onTapSelectedCar:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [self.carModelBtnArr addObject:btn];
    }
}

- (NSMutableArray *)carModelBtnArr {
    if (nil == _carModelBtnArr) {
        _carModelBtnArr = [[NSMutableArray alloc] init];
    }
    return _carModelBtnArr;
}

- (void)onTapSelectedCar:(UIButton *)btn {
    NSArray *arr = @[@"RX", @"ES"];
    if ([arr containsObject:self.selectedCarNameStr]) {
        self.selectedCarModelStr = [self.carModelsArr objectAtIndex:btn.tag];
        [self performSegueWithIdentifier:@"showFMSelectKmViewController" sender:self];
    } else {
        [[CustomHintViewController getInstance] presentMessage:@"暂无此车数据信息，敬请期待" parentController:self isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:^{
            
        }];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFMSelectKmViewController"]) {
        FMSelectKmViewController *vc = segue.destinationViewController;
        vc.title = [NSString stringWithFormat:@"%@%@", self.selectedCarNameStr, self.selectedCarModelStr];
        vc.kmArr = [[CarCategoreManager shareManager] getCarKMByCarName:self.selectedCarNameStr carModel:self.selectedCarModelStr];
        vc.carName = self.selectedCarNameStr;
    }
}

@end
