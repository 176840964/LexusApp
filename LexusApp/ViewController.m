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
    
    self.bgImgView.image = [UIImage imageNamed:@"test"];
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

@end
