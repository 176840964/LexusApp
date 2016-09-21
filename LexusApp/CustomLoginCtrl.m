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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cornerRadius = 4.0;
        self.borderWidth = 1;
        self.borderColor = [UIColor colorWithHexString:@"#565656"];
        
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 20, 16)];
        [self addSubview:self.imgView];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imgView.frame), 0, CGRectGetWidth(frame) - CGRectGetMaxY(self.imgView.frame), CGRectGetHeight(frame))];
        self.titleLab.font = [UIFont systemFontOfSize:13];
        self.titleLab.textColor = [UIColor colorWithHexString:@"#565656"];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
        
        
    }
    return self;
}

- (BOOL)isLogin {
    return [self.titleLab.text isEqualToString:@"退出"];
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (_isLogin) {
        self.titleLab.text = @"退出";
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
