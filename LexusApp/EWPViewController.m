//
//  EWPViewController.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/23.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "EWPViewController.h"

@interface EWPViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(CustomZoomScaleImageView) NSArray* zoomScaleViewsArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainViewWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;
@end

@implementation EWPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"延保政策";
    
    self.zoomScaleViewsArr = [self.zoomScaleViewsArr sortByUIViewOriginX];
    
    NSInteger index = 0;
    for (CustomZoomScaleImageView *view in self.zoomScaleViewsArr) {
        [view layoutCustomZoomScaleImageView];
        view.image = [UIImage imageNamed:[NSString stringWithFormat:@"EWP%zd", index + 1]];
        index ++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.mainViewWidth.constant = CGRectGetWidth(self.view.bounds) * self.zoomScaleViewsArr.count;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.scrollView.contentOffset = CGPointZero;
    [self setupLeftArrowBtnAndRightArrowBtnEnable];
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

#pragma mark - IBAction
- (IBAction)onTapLeftArrowBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake((self.pageCtrl.currentPage - 1) * self.view.width, 0) animated:YES];
}

- (IBAction)onTapRightArrowBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake((self.pageCtrl.currentPage + 1) * self.view.width, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
