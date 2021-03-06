//
//  UserModel.h
//  LexusApp
//
//  Created by Dragonet on 16/9/6.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel <NSCoding>
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *iconStr;
@property (strong, nonatomic) NSNumber *uid;

@end
