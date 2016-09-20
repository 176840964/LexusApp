//
//  CarCategoreManager.m
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CarCategoreManager.h"

@interface CarCategoreManager ()
@property (strong, nonatomic) NSArray *carsInfoArr;
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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"CarCategore.plist" ofType:nil];
        self.carsInfoArr = [NSArray arrayWithContentsOfFile:path];
    }
    
    return self;
}

- (NSInteger)carsCount {
    return self.carsInfoArr.count;
}

- (NSDictionary*)getCarInfoDicByIndex:(NSInteger)index {
    return [self.carsInfoArr objectAtIndex:index];
}

- (NSArray*)getCarModelsByCarName:(NSString *)carName {
    return [self getInfoArrByCarName:carName carModel:nil];
}

- (NSArray*)getCarKMByCarName:(NSString *)carName carModel:(NSString *)carModel {
    return [self getInfoArrByCarName:carName carModel:carModel];
}

#pragma mark - 
- (NSArray*)getInfoArrByCarName:(NSString*)carName carModel:(NSString *)carModel {
    for (NSDictionary *dic in self.carsInfoArr) {
        NSString *name = [dic objectForKey:@"name"];
        if ([name isEqualToString:carName]) {
            NSDictionary *modelsDic = [dic objectForKey:@"models"];
            if ([carModel isValid]) {
                return [modelsDic objectForKey:carModel];
            } else {
                return [modelsDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                    return (obj1.integerValue < obj2.integerValue) ? NSOrderedAscending : (obj1.integerValue > obj2.integerValue) ? NSOrderedDescending : NSOrderedSame;
                }];
            }
        }
    }
    
    return nil;
}

@end
