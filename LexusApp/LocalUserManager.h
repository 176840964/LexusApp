//
//  LocalUserManager.h
//  LexusApp
//
//  Created by Dragonet on 16/9/18.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface LocalUserManager : NSObject <NSCoding>

@property (strong, nonatomic) NSMutableArray *localUsersArr;
@property (strong, nonatomic) UserModel *curLoginUserModel;
@property (assign, nonatomic) BOOL isLogin;

+ (instancetype)shareManager;

- (void)AddLocalUser:(UserModel *)model;
- (void)removeLocalUser:(UserModel *)model;
- (void)logout;

@end
