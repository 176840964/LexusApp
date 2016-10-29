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
        [NSURLCache setSharedURLCache:[[NSURLCache alloc] initWithMemoryCapacity:8 * 1024 * 1024 diskCapacity:40 * 1024 * 1024 diskPath:nil]];
        
        s_instance = [[NetworkingManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        s_instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
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
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[CustomHintViewController getInstance] presentMessage:@"无网络连接" parentController:weakSelf.viewController isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

- (NSURLSessionDataTask *)networkingNotAnalysisWithGetMethodPath:(NSString *)path
                                                   params:(NSDictionary *)parames
                                                  success:(void (^)(id responseObject))success {
    
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [self GET:path parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[CustomHintViewController getInstance] presentMessage:@"无网络连接" parentController:weakSelf.viewController isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

- (NSURLSessionDataTask*)networkingWithPostMethodPath:(NSString*)path
                                            paramsDic:(NSDictionary *)paramsDic
                                            soundDate:(NSData *)soundDate
                                              success:(void (^)(id responseObject))success {
    self.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [self POST:path parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:soundDate name:@"song"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"error:%@", error);
            [[CustomHintViewController getInstance] presentMessage:@"无网络连接" parentController:weakSelf.viewController isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:nil];
        });
    }];
}

@end
