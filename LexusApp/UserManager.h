//
//  UserManager.h
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
@property (assign, nonatomic) BOOL isLoginStudy;
@property (assign, nonatomic) BOOL isShowVideo;

+ (UserManager *) shareUserManager;

@end
