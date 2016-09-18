//
//  UserModel.m
//  LexusApp
//
//  Created by Dragonet on 16/9/6.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    if (self) {
        self.iconStr = @"manIcon";
    }
    return self;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.iconStr forKey:@"iconStr"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.iconStr = [aDecoder decodeObjectForKey:@"iconStr"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
    }
    
    return self;
}

@end
