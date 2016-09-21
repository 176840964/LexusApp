//
//  BaseViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/8/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(strong, nonatomic) UILabel *titleLab;
@property(strong, nonatomic) UIImageView *bgImgView;
@property(assign, nonatomic) BOOL isBgCanShake;//背景图片是否可晃动，默认是NO

@property(assign, nonatomic) BOOL isShowBackBtn;

@end
