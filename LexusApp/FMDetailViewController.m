//
//  FMDetailViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailViewController.h"
#import "FMDetailCheckView.h"
#import "FMDetailChangeView.h"

@interface FMDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *checkProjectBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeProjectBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet FMDetailCheckView *checkView;
@property (weak, nonatomic) IBOutlet FMDetailChangeView *changeView;

@end

@implementation FMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isShowBackBtn = YES;
    [self.changeView setupSubviews];
    
    self.checkProjectBtn.backgroundColor = [UIColor whiteColor];
    self.changeProjectBtn.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentWidth.constant = CGRectGetWidth(self.view.bounds) * 2;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *checkArr = [self.detailDic objectForKey:@"check"];
    [self.checkView setupSubviewsByCheckArr:checkArr];
}

#pragma mark - IBAction
- (IBAction)onTapCheckProjectBtn:(id)sender {
    self.checkProjectBtn.backgroundColor = [UIColor whiteColor];
    self.changeProjectBtn.backgroundColor = [UIColor clearColor];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (IBAction)onTapChangeProjectBtn:(id)sender {
    self.checkProjectBtn.backgroundColor = [UIColor clearColor];
    self.changeProjectBtn.backgroundColor = [UIColor whiteColor];
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0) animated:NO];
}

- (IBAction)rightScreenEdgePanGestureRecognizer:(id)sender {
    [self.customTabbarController setSelectedIndex:1 isAnimated:YES];
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
