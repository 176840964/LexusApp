//
//  StudyViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyUnlockViewController.h"
#import "GestureUnlockView.h"

@interface StudyUnlockViewController () <GestureUnlockViewDelegate>
@property (strong, nonatomic) GestureUnlockView *gestureUnlockView;
@end

@implementation StudyUnlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GestureModel * gestureModel = [[GestureModel alloc] init];
    gestureModel.gesturePasswordStr = @"123";
//    gestureModel.gesturePasswordStr = @"56985";
    
    _gestureUnlockView = [[GestureUnlockView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds) - 302) / 2.0, 394 + 64, 302, 223)];
    _gestureUnlockView.gestureModel = gestureModel;
    _gestureUnlockView.delegate = self;
    [self.view addSubview:_gestureUnlockView];
}

#pragma mark - IBAction
- (IBAction)onTapHomeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - <GestureUnlockViewDelegate>
- (void)gestureViewUnlockSuccess:(GestureUnlockView *)gestureView {
    [UserManager shareUserManager].isLoginStudy = YES;
    [self dismissViewControllerAnimated:YES completion:^{
        [[NetworkingManager shareManager] networkingNotAnalysisWithGetMethodPath:@"learn/addLearnLogin" params:@{@"userid": [LocalUserManager shareManager].curLoginUserModel.uid} success:^(id responseObject) {
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dic:%@", dic);
            dispatch_async(dispatch_get_main_queue(), ^{
            });
        }];
    }];
}

@end
