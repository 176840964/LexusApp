//
//  FMSelectKmViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectKmViewController.h"
#import "FMDetailViewController.h"
#import "../Pods/YLGIFImage/YLGIFImage/YLImageView.h"
#import "../Pods/YLGIFImage/YLGIFImage/YLGIFImage.h"

@interface FMSelectKmViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;
@property (weak, nonatomic) IBOutlet YLImageView *gitImgView;
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
    for (UIButton *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.enabled = NO;
        }
    }
    
    NSString *imgStr = [self carImageName];
    self.gitImgView.transform = CGAffineTransformMakeTranslation(-self.view.center.x - self.gitImgView.width, 0);
    self.gitImgView.image = [YLGIFImage imageNamed:[NSString stringWithFormat:@"%@.gif", imgStr]];
    self.carImgView.image = [UIImage imageNamed:imgStr];
    [UIView animateWithDuration:1 animations:^{
        self.gitImgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.carImgView.hidden = NO;
        self.gitImgView.hidden = YES;
        
        for (UIButton *btn in self.view.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.enabled = YES;
            }
        }
    }];
}

- (void)dismissAnimation {
    for (UIButton *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.enabled = NO;
        }
    }
    self.gitImgView.hidden = NO;
    self.carImgView.hidden = YES;
    [UIView animateWithDuration:1 animations:^{
        self.gitImgView.transform = CGAffineTransformMakeTranslation(self.view.center.x + self.carImgView.width / 2.0, 0);
    } completion:^(BOOL finished) {
        [self performSegueWithIdentifier:@"showFMDetailViewController" sender:self];
    }];
}

- (NSString *)carImageName {
    if ([self.carName isEqualToString:@"GS"]) {
        if ([self.carModel isEqualToString:@"350h"] || [self.carModel isEqualToString:@"450h"]) {
            return @"GS450h-300h";
        } else {
            return @"GS-200t-250-350-350(AWD)";
        }
    } else if ([self.carName isEqualToString:@"LS"]) {
        if ([self.carModel isEqualToString:@"600hL"]) {
            return @"LS600hl";
        } else {
            return @"LS460(4wd)";
        }
    } else if ([self.carName isEqualToString:@"NX"]) {
        if ([self.carModel isEqualToString:@"300h(4wd)"]) {
            return @"NX300h";
        } else {
            return @"NX200t、200（4WD)";
        }
    } else if ([self.carName isEqualToString:@"RX"]) {
        if ([self.carModel isEqualToString:@"450h"]) {
            return @"RX450h";
        } else {
            return @"RX200t、RX270、350";
        }
    } else {
        return [NSString stringWithFormat:@"%@KM", self.carName];
    }
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
        vc.carName = self.carName;
        vc.carModel = self.carModel;
        vc.carKM = [NSString stringWithFormat:@"%zd万", self.selectedKM];
    }
}

@end
