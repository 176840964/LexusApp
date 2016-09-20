//
//  CarCategoreManager.h
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarCategoreManager : NSObject

+ (instancetype)shareManager;
- (NSArray*)getAllCarsName;
- (NSArray*)getAllCarModelsByCarName:(NSString *)carName;
- (NSArray*)getAllCarKmByCarName:(NSString *)carName carModel:(NSString *)carModel;

@end
