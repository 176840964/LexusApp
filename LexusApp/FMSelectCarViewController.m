//
//  FMSelectCarViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/1.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectCarViewController.h"
#import "CarSelectedItemView.h"

@interface FMSelectCarViewController ()
@property (strong, nonatomic) CarSelectedItemView *curCarItemView;
@property (strong, nonatomic) CarSelectedItemView *nextCarItemView;
@property (strong, nonatomic) NSArray *carsNameArr;
@property (assign, nonatomic) NSInteger curSelectedIndex;
@property (strong, nonatomic) NSMutableArray *carModelBtnArr;
@end

@implementation FMSelectCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.carsNameArr = [[CarCategoreManager shareManager] getAllCarsName];
    
//    self.bgImgView.image = [UIImage imageNamed:@"test"];
    self.isBgCanShake = YES;
    self.isShowHomeBtn = YES;
    
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
    
    self.curCarItemView.carNameLab.text = [self.carsNameArr firstObject];
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
    NSLog(@"tx:%f", tx);
    
    NSInteger nextIndex;
    if (tx >= 0) {
        nextIndex = self.curSelectedIndex + 1;
        if (nextIndex == self.carsNameArr.count) {
            nextIndex = nextIndex % self.carsNameArr.count;
        }
        
    } else {
        nextIndex = self.curSelectedIndex - 1;
        if (nextIndex < 0) {
            nextIndex = self.carsNameArr.count + nextIndex;
        }
    }
    self.nextCarItemView.carNameLab.text = [self.carsNameArr objectAtIndex:nextIndex];
    
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
    
    NSString *carName = [self.carsNameArr objectAtIndex:curSelectedIndex];
    NSArray *carModelsArr = [[CarCategoreManager shareManager] getAllCarModelsByCarName:carName];
    
    NSInteger x = (CGRectGetWidth(self.view.bounds) - (70 * carModelsArr.count + 35 * (carModelsArr.count - 1))) / 2.0;
    for (NSInteger index = 0; index < carModelsArr.count; index ++) {
        NSString *carModel = [carModelsArr objectAtIndex:index];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x + (70 + 35) * index, 400, 70, 70);
        [btn setTitle:carModel forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#89939c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#383838"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_highlight"] forState:UIControlStateHighlighted];
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

#pragma makr - IBAction
- (IBAction)onTapSelectedCar:(id)sender {
    [self performSegueWithIdentifier:@"showFMSelectKmViewController" sender:self];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showFMSelectKmViewController"]) {
        UIViewController *vc = segue.destinationViewController;
        vc.title = @"NX200";
    }
}

@end
