//
//  CustomTabbarViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/9/2.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLoginCtrl.h"

@interface CustomTabbarViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *tabbarView;
@property (copy, nonatomic) NSArray* viewControllersArr;

@property (weak, nonatomic) IBOutlet CustomLoginCtrl *loginCtrl;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;

- (void)showTabbarView:(BOOL)isAnimated;
- (void)dismissTabbarView:(BOOL)isAnimated;

- (void)setSelectedIndex:(NSInteger)selectedIndex isAnimated:(BOOL)isAnimated;

@end

@interface UIViewController (CustomTabbarControllerItem)

@property(readonly, nonatomic) CustomTabbarViewController *customTabbarController;

@end
