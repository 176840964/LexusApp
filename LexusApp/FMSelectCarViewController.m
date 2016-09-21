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
    
//    self.bgImgView.image = [UIImage imageNamed:@"test"];
    self.isBgCanShake = YES;
    
    self.nextCarItemView = [CarSelectedItemView newAutoLayoutView];
    self.nextCarItemView.alpha = 0.0;
    [self.view addSubview:self.nextCarItemView];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.nextCarItemView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.nextCarItemView autoSetDimension:ALDimensionHeight toSize:200];
    [self autoChangeBgColor:self.nextCarItemView];
    [self setPanGestureRecognizerOnCarSelectedItemView:self.nextCarItemView];
    
    self.curCarItemView = [CarSelectedItemView newAutoLayoutView];
    self.curCarItemView.alpha = 1.0;
    [self.view addSubview:self.curCarItemView];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [self.curCarItemView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [self.curCarItemView autoSetDimension:ALDimensionHeight toSize:200];
    [self autoChangeBgColor:self.curCarItemView];
    [self setPanGestureRecognizerOnCarSelectedItemView:self.curCarItemView];
    
    self.curSelectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)autoChangeBgColor:(CarSelectedItemView *)itemView {
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    itemView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (void)setPanGestureRecognizerOnCarSelectedItemView:(CarSelectedItemView *)itemView {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCarSelectedItemView:)];
    [itemView addGestureRecognizer:pan];
}

#pragma mark - 
- (void)panCarSelectedItemView:(UIPanGestureRecognizer *)pan {
    CGFloat limit = 30;
    CGPoint point = [pan translationInView:pan.view];
    CGFloat tx = point.x / 10.0;
    
    NSInteger count = [CarCategoreManager shareManager].carsCount;
    NSInteger nextIndex;
    if (tx >= 0) {
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
    self.nextCarItemView.carNameLab.text = [[[CarCategoreManager shareManager] getCarInfoDicByIndex:nextIndex] objectForKey:@"name"];
    
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
    self.carModelsArr = [[CarCategoreManager shareManager] getCarModelsByCarName:self.selectedCarNameStr];
    self.curCarItemView.carNameLab.text = self.selectedCarNameStr;
    
    NSInteger x = (CGRectGetWidth(self.view.bounds) - (70 * self.carModelsArr.count + 35 * (self.carModelsArr.count - 1))) / 2.0;
    for (NSInteger index = 0; index < self.carModelsArr.count; index ++) {
        NSString *carModel = [self.carModelsArr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(x + (70 + 35) * index, CGRectGetHeight(self.view.bounds) - 400, 70, 70);
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:[NSString stringWithFormat:@"%@\n%@", self.selectedCarNameStr, carModel] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#89939c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateHighlighted];
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
    self.selectedCarModelStr = [self.carModelsArr objectAtIndex:btn.tag];
    [self performSegueWithIdentifier:@"showFMSelectKmViewController" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFMSelectKmViewController"]) {
        FMSelectKmViewController *vc = segue.destinationViewController;
        vc.title = [NSString stringWithFormat:@"%@%@", self.selectedCarNameStr, self.selectedCarModelStr];
        vc.kmArr = [[CarCategoreManager shareManager] getCarKMByCarName:self.selectedCarNameStr carModel:self.selectedCarModelStr];
    }
}

@end
