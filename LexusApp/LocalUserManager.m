//
//  LocalUserManager.m
//  LexusApp
//
//  Created by Dragonet on 16/9/18.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "LocalUserManager.h"

@implementation LocalUserManager

+ (NSString *)pathOfDataFile {
    static NSString * s_pathOfDataFile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_pathOfDataFile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"LocalUserManager.data"];
    });
    
    return s_pathOfDataFile;
}

+ (instancetype) shareManager {
    static LocalUserManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            s_instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathOfDataFile]];
        } @catch (NSException *exception) {
            [[NSFileManager defaultManager] removeItemAtPath:[self pathOfDataFile] error:nil];
        } @finally {
            if (nil == s_instance) {
                s_instance = [[LocalUserManager alloc] init];
            }
        }
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.localUsersArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (void)AddLocalUser:(UserModel *)model {
    if (![self isContainsUserModel:model]) {
        if (7 == self.localUsersArr.count) {
            [self.localUsersArr removeObjectAtIndex:0];
        }
        
        [self.localUsersArr addObject:model];
        [self synchronize];
    }
}

- (void)removeLocalUser:(UserModel *)model {
    [self.localUsersArr removeObject:model];
    [self synchronize];
}

#pragma mark -
- (void)synchronize {
    [NSKeyedArchiver archiveRootObject:self toFile:[self.class pathOfDataFile]];
}

- (BOOL)isContainsUserModel:(UserModel *)userModel {
    for (UserModel *model in self.localUsersArr) {
        if ([model.uid isEqualToNumber:userModel.uid]) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.localUsersArr forKey:@"localUsersArr"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.localUsersArr = [aDecoder decodeObjectForKey:@"localUsersArr"];
    }
    
    return self;
}

@end
