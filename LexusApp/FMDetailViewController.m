//
//  FMDetailViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailViewController.h"

@interface FMDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *checkProjectBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeProjectBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;

@end

@implementation FMDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.contentWidth.constant = CGRectGetWidth(self.view.bounds) * 2;
}

#pragma mark - IBAction
- (IBAction)onTapCheckProjectBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (IBAction)onTapChangeProjectBtn:(id)sender {
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0) animated:NO];
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
