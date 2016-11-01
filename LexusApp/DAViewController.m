//
//  DAViewController.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/23.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAViewController.h"
#import "DAType1View.h"
#import "DAType2View.h"
#import "DAType3View.h"
#import "DAType4View.h"
#import "DAType5View.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DAViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UIButton *leftArrowBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightArrowBtn;

@property (strong, nonatomic) NSMutableArray *viewsArr;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (UIView *view in self.viewsArr) {
        [view removeFromSuperview];
    }
    [self.viewsArr removeAllObjects];
    
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"activity/getAcivityShowData" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid} success:^(id responseObject) {
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = [dic objectForKey:@"listCarActivity"];
        for (NSDictionary *dataDic in arr) {
            UIView *view = [self selectSubviewByType:[[dataDic objectForKey:@"type"] integerValue] dataDic:dataDic];
            [self.viewsArr addObject:view];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) * arr.count, CGRectGetHeight(self.view.frame) - 64 - 168);
            self.pageCtrl.numberOfPages = self.viewsArr.count;
            
            [self setupLeftArrowBtnAndRightArrowBtnEnable];
            
            for (NSInteger index = 0; index < self.viewsArr.count; index++) {
                UIView *view = [self.viewsArr objectAtIndex:index];
                view.frame = CGRectMake(165 / 2.0 + index * CGRectGetWidth(self.scrollView.frame), 30, CGRectGetWidth(self.scrollView.frame) - 165 , CGRectGetHeight(self.scrollView.frame) - 30);
                [self.scrollView addSubview:view];
            }
        });
    }];
}

- (NSMutableArray *)viewsArr {
    if (nil == _viewsArr) {
        _viewsArr = [NSMutableArray new];
    }
    
    return _viewsArr;
}

#pragma mark -
- (void)setupLeftArrowBtnAndRightArrowBtnEnable {
    if (0 == self.scrollView.contentOffset.x) {
        self.leftArrowBtn.enabled = NO;
        self.rightArrowBtn.enabled = YES;
    } else if ((self.viewsArr.count - 1) * self.view.width == self.scrollView.contentOffset.x) {
        self.rightArrowBtn.enabled = NO;
        self.leftArrowBtn.enabled = YES;
    } else {
        self.rightArrowBtn.enabled = YES;
        self.leftArrowBtn.enabled = YES;
    }
}

- (UIView *)selectSubviewByType:(NSInteger)type dataDic:(NSDictionary *)dic {
    UIView *view = nil;
    switch (type) {
            case 1:{
                DAType1Model *model = [[DAType1Model alloc] initWithDic:dic];
                DAType1View *type1View = [[DAType1View alloc] init];
                [type1View setupSubviewsByType1Model:model];
                view = type1View;
            }
            break;
            
            case 2:{
                DAType2Model *model = [[DAType2Model alloc] initWithDic:dic];
                DAType2View *type2View = [[DAType2View alloc] init];
                [type2View setupSubviewsByType1Model:model];
                view = type2View;
            }
            break;
            
            case 3:{
                DAType3Model *model = [[DAType3Model alloc] initWithDic:dic];
                DAType3View *type3View = [[DAType3View alloc] init];
                [type3View setupSubviewsByType1Model:model];
                view = type3View;
            }
            break;
            
            case 4:{
                DAType4Model *model = [[DAType4Model alloc] initWithDic:dic];
                DAType4View *type4View = [[DAType4View alloc] init];
                type4View.playVideo = ^(NSString *str) {
                    [self playVideo:str];
                };
                [type4View setupSubviewsByType1Model:model];
                view = type4View;
            }
            break;
            
        default:{
            DAType5Model *model = [[DAType5Model alloc] initWithDic:dic];
            DAType5View *type5View = [[DAType5View alloc] init];
            type5View.playVideo = ^(NSString *str) {
                [self playVideo:str];
            };
            [type5View setupSubviewsByType1Model:model];
            view = type5View;
        }
            break;
    }
    
    return view;
}

- (void)playVideo:(NSString *)urlStr {
    [UserManager shareUserManager].isShowVideo = YES;
    NSURL *videoUrl = [NSURL URLWithString:urlStr];
    MPMoviePlayerViewController *movieVc=[[MPMoviePlayerViewController alloc]initWithContentURL:videoUrl];
    [self presentMoviePlayerViewControllerAnimated:movieVc];
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
