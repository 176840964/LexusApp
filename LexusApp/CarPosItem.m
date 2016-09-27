//
//  CarPosItem.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/27.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CarPosItem.h"

@interface CarPosItem ()
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@end

@implementation CarPosItem

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        NSNumber *x = [dic objectForKey:@"x"];
        NSNumber *y = [dic objectForKey:@"y"];
        NSNumber *width = [dic objectForKey:@"width"];
        NSNumber *height = [dic objectForKey:@"height"];
        
        self.x = x.floatValue / 2.0;
        self.y = y.floatValue / 2.0;
        self.width = width.floatValue / 2.0;
        self.height = height.floatValue / 2.0;
        self.offset = [[dic objectForKey:@"offset"] integerValue];
    }
    
    return self;
}

- (CGRect)realRectByFatherViewWidth:(CGFloat)fWidth height:(CGFloat)fHeight {
    CGFloat oriWidth = 1927 / 2.0;
    CGFloat oriHeight = 322 / 2.0;
    
    CGFloat x = self.x / oriWidth * fWidth;
    CGFloat y = self.y / oriHeight * fHeight;
    CGFloat width = self.width / oriWidth * fWidth;
    CGFloat height = self.height / oriHeight * fHeight;
    
    return CGRectMake(x, y, width, height);
}

@end
