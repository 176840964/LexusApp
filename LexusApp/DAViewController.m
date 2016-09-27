//
//  DAViewController.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/23.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAViewController.h"

@interface DAViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;

@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation DAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLab.text = @"经销商活动";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.scrollView.contentOffset = CGPointZero;
    [self setupLeftArrowBtnAndRightArrowBtnEnable];
    
    if (_dataArr) {
        return;
    }
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.dataArr.count, CGRectGetHeight(self.view.frame) - 64 - 168);
    
    for (NSInteger index = 0; index < self.dataArr.count; index ++) {
        NSString *str = [self.dataArr objectAtIndex:index];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:str]];
        imgView.frame = CGRectMake(165 / 2.0 + index * CGRectGetWidth(self.scrollView.frame), 30, CGRectGetWidth(self.scrollView.frame) - 165 , CGRectGetHeight(self.scrollView.frame) - 30);
        [self.scrollView addSubview:imgView];
    }
}

#pragma mark -
- (NSMutableArray*)dataArr {
    if (nil == _dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
        for (NSInteger index = 0; index < 5; index ++) {
            NSString *str = [NSString stringWithFormat:@"testDA%zd", index + 1];
            [_dataArr addObject:str];
        }
    }
    
    return _dataArr;
}

- (void)setupLeftArrowBtnAndRightArrowBtnEnable {
    if (0 == self.scrollView.contentOffset.x) {
        self.leftArrowBtn.enabled = NO;
        self.rightArrowBtn.enabled = YES;
    } else if ((self.dataArr.count - 1) * self.view.width == self.scrollView.contentOffset.x) {
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
