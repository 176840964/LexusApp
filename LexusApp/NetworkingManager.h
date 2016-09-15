//
//  NetworkingManager.h
//  LexusApp
//
//  Created by Dragonet on 16/9/15.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface NetworkingManager : AFHTTPSessionManager

+ (NetworkingManager *)shareManager;

- (NSURLSessionDataTask *)networkingWithGetMethodPath:(NSString *)path
                                               params:(NSDictionary *)parames
                                              success:(void (^)(id responseObject))success;

@end
