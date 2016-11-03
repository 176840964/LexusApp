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
    NSArray *arr = [self.detailDic objectForKey:@"change"];
    
    self.isShowBackBtn = YES;
    self.changeView.carNameStr = self.carName;
    [self.changeView setupSubviewsWithDataArr:arr];
    
    self.checkProjectBtn.backgroundColor = [UIColor whiteColor];
    self.changeProjectBtn.backgroundColor = [UIColor clearColor];
    
    [self getPriceDetail];
    [self watchFMViewController];
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
    
    
    NSString *string = self.carName;
    if ([self.carName isEqualToString:@"LS"]) {
        string = [string stringByAppendingString:self.carModel];
    }
    
    self.checkView.carStr = string;
    
    NSArray *checkArr = [self.detailDic objectForKey:@"check"];
    [self.checkView setupSubviewsByCheckArr:checkArr];
}

#pragma mark - NetWorking
- (void)getPriceDetail {
    NSString *carAllName = [NSString stringWithFormat:@"%@%@", self.carName, self.carModel];
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"user/getChangeData" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"car_type" : carAllName, @"car_distance" : self.carKM} success:^(id responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic:%@", dic);
        NSDictionary *changeVO = [dic objectForKey:@"changeVO"];
        NSString *distince = [changeVO objectForKey:@"car_distince"];
        NSString *project = [changeVO objectForKey:@"change_project"];
        NSString *component = [changeVO objectForKey:@"change_component"];
        NSString *money = [changeVO objectForKey:@"change_component_money"];
        NSString *hour = [changeVO objectForKey:@"change_hour_money"];
        NSString *sum = [changeVO objectForKey:@"change_sum_money"];
        NSString *string = [NSString stringWithFormat:@"%@公里保养，共检查%@个项目，更换%@种零件！建议零件费：%@元 建议工时费：%@元 合计：%@元", distince, project, component, money, hour, sum];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.changeView.descriptionPriceLab.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:20];
            [self.changeView.descriptionPriceLab setAttributedNumberStringInContentString:string attributesDic:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#31aaff"], NSFontAttributeName:[UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:30]}];
        });
    }];
}

- (void)watchFMViewController {//3.免费保养打点
    NSString *carFullName = [NSString stringWithFormat:@"%@%@", self.carName, self.carModel];
    [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"fm/addRepareUse" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid, @"car_type": carFullName,@"car_oper": self.carKM} success:^(id responseObject) {
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"免费保养打点 dic:%@", dic);
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
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
