//
//  CarCategoreManager.h
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarCategoreManager : NSObject

@property (assign, nonatomic) NSInteger carsCount;

+ (instancetype)shareManager;

- (NSDictionary*)getCarInfoDicByIndex:(NSInteger)index;
- (NSArray*)getCarModelsByCarName:(NSString *)carName;
- (NSArray*)getCarKMByCarName:(NSString *)carName carModel:(NSString *)carModel;

@end
