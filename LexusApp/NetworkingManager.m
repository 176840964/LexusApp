//
//  NetworkingManager.m
//  LexusApp
//
//  Created by Dragonet on 16/9/15.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "NetworkingManager.h"

#define BaseURLString @"http://114.55.235.176/lkss/v1/"

@implementation NetworkingManager

+ (NetworkingManager *)shareManager {
    static NetworkingManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[NetworkingManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
    });
    
    return s_instance;
}


- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
                                               params:(NSDictionary *)parames
                                              success:(void (^)(id responseObject))success {
    return [self GET:path parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[HintView getInstance] presentMessage:@"无网络连接" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

@end
