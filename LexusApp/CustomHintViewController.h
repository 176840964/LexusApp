//
//  CustomHintViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHintViewController : UIViewController

+ (instancetype)getInstance;
- (void)presentMessage:(NSString *)message parentController:(UIViewController*)parentController isAutoDismiss:(BOOL)isAuto dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^)(void))dismissBlock;
- (void)dismissMessage;

//过程
- (void)startLoadingMessage:(NSString *)startMessage parentController:(UIViewController*)parentController;
- (void)endLoadingMessage:(NSString *)endMessage dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^) (void))dismissBlock;

//无文字
- (void)showSimpleLoading:(UIViewController *)parentController;
- (void)endSimpleLoading;

@end
