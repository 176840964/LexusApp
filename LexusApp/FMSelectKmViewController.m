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
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;
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
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(x + index * (50 + 12), CGRectGetHeight(self.view.bounds) - 132, 50, 50);
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:17];
        [btn setTitleColor:[UIColor colorWithHexString:@"#5f5f5f"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#050608"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"kmBtn_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"kmBtn_highlight"] forState:UIControlStateHighlighted];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapSelectedKmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        if (index != self.kmArr.count - 1) {
            UIImageView *pointImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kmSpacingDian"]];
            pointImgView.frame = CGRectMake(0, 0, 4.5, 4.5);
            pointImgView.center = CGPointMake(btn.center.x + btn.width / 2.0 + 6, btn.center.y);
            [self.view addSubview:pointImgView];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)showAnimation {
    self.carImgView.transform = CGAffineTransformMakeTranslation(-self.view.center.x - self.carImgView.width, 0);
    self.carImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@KM", self.carName]];
    [UIView animateWithDuration:.5 animations:^{
        self.carImgView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismissAnimation {
    [UIView animateWithDuration:.5 animations:^{
        self.carImgView.transform = CGAffineTransformMakeTranslation(self.view.center.x + self.carImgView.width / 2.0, 0);
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"showFMDetailViewController" sender:self];
    }];
}

- (void)onTapSelectedKmBtn:(UIButton *)sender {
    UIButton *btn = (UIButton*)sender;
    self.selectedKM = btn.tag + 1;
    [self dismissAnimation];
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
