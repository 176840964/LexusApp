//
//  ViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/8/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bgImgView.image = [UIImage imageNamed:@"bg1"];
    self.isBgCanShake = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.customTabbarController.homeBtn.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapFMBtn:(id)sender {
    if ([LocalUserManager shareManager].isLogin) {
        [self performSegueWithIdentifier:@"showSelectCarViewController" sender:self];
    } else {
        [self.customTabbarController.loginCtrl sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
