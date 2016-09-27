//
//  CarPosItem.h
//  LexusApp
//
//  Created by Dragonet on 2016/9/27.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarPosItem : NSObject
@property (assign, nonatomic) NSInteger offset;

- (instancetype)initWithDic:(NSDictionary *)dic;

- (CGRect)realRectByFatherViewWidth:(CGFloat)fWidth height:(CGFloat)fHeight;

@end
