//
//  AccelerometerManager.m
//  testAccelerometer
//
//  Created by Dragonet on 16/8/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "AccelerometerManager.h"
#import <UIKit/UIKit.h>

@interface AccelerometerManager () <UIAccelerometerDelegate>
@property (strong, nonatomic) UIAccelerometer *accelerometer;
@property (strong, nonatomic) CMMotionManager *motionManager;
@end

@implementation AccelerometerManager

+ (instancetype)shareAccelerometerManager {
    static AccelerometerManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[AccelerometerManager alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
#ifdef __IPHONE_5_0
        _motionManager = [[CMMotionManager alloc] init];
        if (_motionManager.accelerometerAvailable) {
            [_motionManager setAccelerometerUpdateInterval:1 / 60.0f];
            NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
            [_motionManager startAccelerometerUpdatesToQueue:operationQueue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
                if (nil != _delegate && [_delegate respondsToSelector:@selector(accelerometerManager:withX:withY:withZ:withTimeInterval:)]) {
                    NSNumber *x  = [NSNumber numberWithDouble:accelerometerData.acceleration.x];
                    NSNumber *y  = [NSNumber numberWithDouble:accelerometerData.acceleration.y];
                    NSNumber *z  = [NSNumber numberWithDouble:accelerometerData.acceleration.z];
                    [_delegate accelerometerManager:self withX:x withY:y withZ:z withTimeInterval:accelerometerData.timestamp];
                }
            }];
        }
#else
#ifdef __IPHONE_4_0
        _accelerometer = [UIAccelerometer sharedAccelerometer];
        [_accelerometer setUpdateInterval:(1/60.0f)];
        _accelerometer.delegate = self;
        
#endif  
#endif
        
    }
    return self;
}

- (void)addOberser:(id)oberserer
{
    _delegate = oberserer;
}

- (void)removeObserver
{
    _delegate = nil;
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(accelerometerManager:withX:withY:withZ:withTimeInterval:)])
    {
        NSNumber *x  = [NSNumber numberWithDouble:acceleration.x];
        NSNumber *y  = [NSNumber numberWithDouble:acceleration.y];
        NSNumber *z  = [NSNumber numberWithDouble:acceleration.z];
        [_delegate accelerometerManager:self withX:x withY:y withZ:z withTimeInterval:acceleration.timestamp];
    }
    
}

@end
