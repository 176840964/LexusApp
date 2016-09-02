//
//  AccelerometerManager.h
//  testAccelerometer
//
//  Created by Dragonet on 16/8/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol AccelerometerManagerDelegate;

@interface AccelerometerManager : NSObject
@property (weak, nonatomic) id<AccelerometerManagerDelegate> delegate;

+ (instancetype)shareAccelerometerManager;
- (void)addOberser:(id)oberserer;
- (void)removeObserver;
@end

@protocol AccelerometerManagerDelegate <NSObject>

- (void)accelerometerManager:(AccelerometerManager *)accelerometerManager withX:(NSNumber*)x withY:(NSNumber*)y withZ:(NSNumber*)z withTimeInterval:(NSTimeInterval)timeInterval;

@end
