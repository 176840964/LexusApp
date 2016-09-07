//
//  StudyViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyViewController.h"
#import "GestureUnlockView.h"

@interface StudyViewController () <GestureUnlockViewDelegate>
@property (strong, nonatomic) GestureUnlockView *gestureUnlockView;
@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GestureModel * gestureModel = [[GestureModel alloc] init];
    gestureModel.gesturePasswordStr = @"56985";
    
    _gestureUnlockView = [[GestureUnlockView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds) - 302) / 2.0, 394 + 64, 302, 223)];
    _gestureUnlockView.gestureModel = gestureModel;
    _gestureUnlockView.delegate = self;
    [self.view addSubview:_gestureUnlockView];
}

#pragma mark - <GestureUnlockViewDelegate>
- (void)gestureViewUnlockSuccess:(GestureUnlockView *)gestureView {
    [self performSegueWithIdentifier:@"showStudyDetailViewController" sender:self];
}

@end
