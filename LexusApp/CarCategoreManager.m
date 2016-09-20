//
//  CarCategoreManager.m
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CarCategoreManager.h"

@interface CarCategoreManager ()
@property (strong, nonatomic) NSDictionary *carsInfoDic;
@end

@implementation CarCategoreManager

+ (instancetype)shareManager {
    static CarCategoreManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[CarCategoreManager alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CarCategoreRes.plist" ofType:nil];
        self.carsInfoDic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return self;
}

- (NSArray*)getAllCarsName {
    return self.carsInfoDic.allKeys;
}

- (NSArray*)getAllCarModelsByCarName:(NSString *)carName {
    NSDictionary* carModelsDic = [self.carsInfoDic objectForKey:carName];
    return carModelsDic.allKeys;
}

- (NSArray*)getAllCarKmByCarName:(NSString *)carName carModel:(NSString *)carModel {
    NSDictionary * carKmDic = [[self.carsInfoDic objectForKey:carName] objectForKey:carModel];
    return carKmDic.allKeys;
}

@end
