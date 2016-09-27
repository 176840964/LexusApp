//
//  CarPositionManager.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/27.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CarPositionManager.h"

@interface CarPositionManager ()
@end

@implementation CarPositionManager

+ (instancetype)shareInstance {
    static CarPositionManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[CarPositionManager alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSMutableArray *dataArr = [NSMutableArray new];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CarPosition.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in arr) {
            CarPosItem *item = [[CarPosItem alloc] initWithDic:dic];
            [dataArr addObject:item];
        }
        
        self.carPosArr = [NSArray arrayWithArray:dataArr];
    }
    
    return self;
}

@end
