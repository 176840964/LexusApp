//
//  FMSelectKmViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectKmViewController.h"
#import "FMDetailViewController.h"

@interface FMSelectKmViewController ()
@property (assign, nonatomic) NSInteger selectedKM;
@end

@implementation FMSelectKmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isShowBackBtn = YES;
    
    self.titleLab.text = self.title;
    
    CGFloat x = ((CGRectGetWidth(self.view.bounds) - 80) - (50 * self.kmArr.count + 12 * (self.kmArr.count - 1))) / 2.0 + 80;
    for (NSInteger index = 0; index < self.kmArr.count; index++) {
        NSString *str = [NSString stringWithFormat:@"%zd万", index + 1];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(x + index * (50 + 12), CGRectGetHeight(self.view.bounds) - 132, 50, 50);
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:17];
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
    UIButton *btn = (UIButton*)sender;
    self.selectedKM = btn.tag + 1;
    [self performSegueWithIdentifier:@"showFMDetailViewController" sender:self];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showFMDetailViewController"]) {
        FMDetailViewController *vc = segue.destinationViewController;
        vc.detailDic = [self.kmArr objectAtIndex:self.selectedKM - 1];
    }
}

@end
