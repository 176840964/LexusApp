//
//  CustomTabbarViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/9/2.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabbarViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *tabbarView;
@property (copy, nonatomic) NSArray* viewControllersArr;

- (void)showTabbarView:(BOOL)isAnimated;
- (void)dismissTabbarView:(BOOL)isAnimated;

- (void)showLoginViewController;
- (void)showStudyViewController;

- (void)setSelectedIndex:(NSInteger)selectedIndex isAnimated:(BOOL)isAnimated;

@end

@interface UIViewController (CustomTabbarControllerItem)

@property(readonly, nonatomic) CustomTabbarViewController *customTabbarController;

@end
