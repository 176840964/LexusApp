//
//  UserManager.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (UserManager *)shareUserManager {
    static UserManager * s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[UserManager alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isLoginStudy = NO;
    }
    
    return self;
}

@end
