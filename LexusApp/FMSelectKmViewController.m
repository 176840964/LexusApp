//
//  FMSelectKmViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMSelectKmViewController.h"

@interface FMSelectKmViewController ()

@end

@implementation FMSelectKmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isShowHomeBtn = YES;
    self.isShowBackBtn = YES;
    
    self.titleLab.text = self.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapSelectedKmBtn:(id)sender {
    [self performSegueWithIdentifier:@"showFMDetailViewController" sender:self];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
