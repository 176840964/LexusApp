//
//  CustomTabbarViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/9/2.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabbarViewController : UIViewController

@property (copy, nonatomic) NSArray* viewControllersArr;
@property (assign, nonatomic) NSInteger selectedIndex;

@end

@interface UIViewController (CustomTabbarControllerItem)

@property(readonly, nonatomic) CustomTabbarViewController *customTabbarController;

@end
