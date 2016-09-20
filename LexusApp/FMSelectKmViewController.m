//
//  FMSelectKmViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectKmViewController.h"

@interface FMSelectKmViewController ()
@property (strong, nonatomic) NSArray *kmArr;
@end

@implementation FMSelectKmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isShowHomeBtn = YES;
    self.isShowBackBtn = YES;
    
    self.titleLab.text = self.title;
    
    NSArray *arr = [[CarCategoreManager shareManager] getAllCarKmByCarName:self.carNameStr carModel:self.carModelStr];
    self.kmArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : (obj1.integerValue > obj2.integerValue) ? NSOrderedDescending : NSOrderedSame;
    }];
    
    CGFloat x = ((CGRectGetWidth(self.view.bounds) - 80) - (50 * self.kmArr.count + 12 * (self.kmArr.count - 1))) / 2.0 + 80;
    for (NSInteger index = 0; index < self.kmArr.count; index++) {
        NSString *str = [NSString stringWithFormat:@"%@万", [self.kmArr objectAtIndex:index]];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(x + index * (50 + 12), CGRectGetHeight(self.view.bounds) - 132, 50, 50);
        [btn setTitleColor:[UIColor colorWithHexString:@"#5f5f5f"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#050608"] forState:UIControlStateHighlighted];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapSelectedKmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTapSelectedKmBtn:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showFMDetailViewController" sender:self];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
