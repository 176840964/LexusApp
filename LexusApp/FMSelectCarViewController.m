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
@end

@implementation FMSelectCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
//    pan.view.transform = CGAffineTransformMakeTranslation(tx, 0);
    
    if (limit < fabs(tx)) {
        pan.view.alpha = (limit - (fabs(tx) - limit)) / limit;
        self.nextCarItemView.alpha = (fabs(tx) - limit) / limit;
    }
    
    if (UIGestureRecognizerStateEnded == pan.state) {
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
