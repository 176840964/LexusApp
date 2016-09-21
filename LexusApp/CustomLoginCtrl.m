//
//  CustomLoginCtrl.m
//  LexusApp
//
//  Created by Dragonet on 16/9/21.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CustomLoginCtrl.h"


@interface CustomLoginCtrl ()
@end

@implementation CustomLoginCtrl
@synthesize isLogin = _isLogin;

- (BOOL)isLogin {
    return [self.titleLab.text isEqualToString:@"退出"];
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (_isLogin) {
        self.titleLab.text = @"退出";
        self.imgView.image = [UIImage imageNamed:[LocalUserManager shareManager].curLoginUserModel.iconStr];
    } else {
        self.titleLab.text = @"登录";
        self.imgView.image = [UIImage imageNamed:@"login_btn_normal"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
