//
//  BaseModel.m
//  LexusApp
//
//  Created by Dragonet on 16/9/15.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        for (NSString* key in dic.allKeys) {
            object_setInstanceVariable(self, [NSString stringWithFormat:@"_%@", key].UTF8String, [dic objectForKey:key]);
        }
    }
    return self;
}

@end
