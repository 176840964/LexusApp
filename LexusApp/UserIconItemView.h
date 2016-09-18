//
//  UserIconItemView.h
//  LexusApp
//
//  Created by Dragonet on 16/9/6.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserIconItemView : UIView
@property (strong, nonatomic) UIButton *iconBtn;
@property (strong, nonatomic) UILabel *nameLab;

@property (strong, nonatomic) UserModel *userModel;
@property (copy, nonatomic) void(^tapUserIconHandler)(UserModel*);
@property (copy, nonatomic) void(^longPressHandler)();
@property (copy, nonatomic) void(^tapUserIconDelHandler)(UserIconItemView*);

@property (assign, nonatomic) BOOL isShake;

- (void)setupUserIconItemByUserModel:(UserModel *)model;
@end
