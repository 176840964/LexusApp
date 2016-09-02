//
//  CustomTabbarViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/2.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import <objc/runtime.h>

@interface CustomTabbarViewController ()
@property (weak, nonatomic) UIViewController *selectedViewController;
@end

@interface UIViewController (CustomTabbarViewControllerItemInternal)
- (void)setCustomTabbarController:(CustomTabbarViewController *)tabbarController;
@end

@implementation UIViewController (CustomTabbarViewControllerItemInternal)

- (void)setCustomTabbarController:(CustomTabbarViewController *)tabbarController {
    objc_setAssociatedObject(self, @selector(customTabbarController), tabbarController, OBJC_ASSOCIATION_ASSIGN);
}

@end

@implementation CustomTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UINavigationController *firstNaviController = [self.storyboard instantiateViewControllerWithIdentifier:@"FMNaviController"];
    
    UINavigationController *secondNaviController = [self.storyboard instantiateViewControllerWithIdentifier:@"DANaviController"];
    
    UINavigationController *thirdNaviController = [self.storyboard instantiateViewControllerWithIdentifier:@"EWPNaviController"];
    
    UINavigationController *fouthNaviController = [self.storyboard instantiateViewControllerWithIdentifier:@"HEVANaviController"];
    
    self.viewControllersArr = @[firstNaviController, secondNaviController, thirdNaviController, fouthNaviController];
    
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (selectedIndex >= self.viewControllersArr.count) {
        return;
    }
    
    if (_selectedViewController) {
        [_selectedViewController willMoveToParentViewController:nil];
        [_selectedViewController.view removeFromSuperview];
        [_selectedViewController removeFromParentViewController];
    }
    
    _selectedIndex = selectedIndex;
    
    _selectedViewController = [_viewControllersArr objectAtIndex:_selectedIndex];
    [self addChildViewController:_selectedViewController];
    _selectedViewController.view.frame = self.view.bounds;
    [self.view addSubview:_selectedViewController.view];
    [_selectedViewController didMoveToParentViewController:self];
}

- (void)setViewControllersArr:(NSArray *)viewControllersArr {
    if (_viewControllersArr && _viewControllersArr.count) {
        for (UIViewController *viewController in _viewControllersArr) {
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllersArr && [viewControllersArr isKindOfClass:[NSArray class]]) {
        _viewControllersArr = [viewControllersArr copy];
        
//        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        
        for (UIViewController *viewController in viewControllersArr) {
//            RDVTabBarItem *tabBarItem = [[RDVTabBarItem alloc] init];
//            [tabBarItem setTitle:viewController.title];
//            [tabBarItems addObject:tabBarItem];
            [viewController setCustomTabbarController:self];
        }
        
//        [[self tabBar] setItems:tabBarItems];
    } else {
        for (UIViewController *viewController in _viewControllersArr) {
            [viewController setCustomTabbarController:nil];
        }
        
        _viewControllersArr = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end

@implementation UIViewController (CustomTabbarControllerItem)

- (CustomTabbarViewController *)customTabbarController {
    CustomTabbarViewController *tabBarController = objc_getAssociatedObject(self, @selector(customTabbarController));
    
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController customTabbarController];
    }
    
    return tabBarController;
}

@end
