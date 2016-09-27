//
//  CarPositionManager.h
//  LexusApp
//
//  Created by Dragonet on 2016/9/27.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarPosItem.h"

@interface CarPositionManager : NSObject
@property (strong, nonatomic) NSArray *carPosArr;

+ (instancetype)shareInstance;
@end
