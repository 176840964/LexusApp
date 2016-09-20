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
@property (strong, nonatomic) UIControl *bgMarkCtrl;
@property (assign, nonatomic) NSInteger selectedIndex;
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
    
    UINavigationController *fifthNaviController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudyNaviController"];
    
    self.viewControllersArr = @[firstNaviController, secondNaviController, thirdNaviController, fouthNaviController, fifthNaviController];
    
    _selectedIndex = NSIntegerMax;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([UserManager shareUserManager].isLoginStudy) {
        [self setSelectedIndex:4 isAnimated:NO];
    } else {
        [self setSelectedIndex:0 isAnimated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIControl *)bgMarkCtrl {
    if (nil == _bgMarkCtrl) {
        _bgMarkCtrl = [[UIControl alloc] initWithFrame:self.view.bounds];
        _bgMarkCtrl.alpha = 0.0;
        _bgMarkCtrl.backgroundColor = [UIColor blackColor];
        [_bgMarkCtrl addTarget:self action:@selector(onTapBgMarkCtrl:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bgMarkCtrl];
    }
    
    return _bgMarkCtrl;
}

- (void)onTapBgMarkCtrl:(UIControl *)ctrl {
    [self dismissTabbarView:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex isAnimated:(BOOL)isAnimated {
    if (selectedIndex >= self.viewControllersArr.count || _selectedIndex == selectedIndex) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    UIViewController *controller = [_viewControllersArr objectAtIndex:_selectedIndex];
    if ([controller isEqual:self.selectedViewController]) {
        return;
    }
    
    controller.view.frame = CGRectMake(CGRectGetWidth(self.view.bounds), 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];
    
    __weak typeof(self) weakSelf = self;
    void (^block)() = ^{
        weakSelf.selectedViewController.view.frame = CGRectMake(-CGRectGetWidth(weakSelf.view.bounds), 0, CGRectGetWidth(weakSelf.view.bounds), CGRectGetHeight(weakSelf.view.bounds));
        controller.view.frame = weakSelf.view.bounds;
    };
    
    void (^completion)(BOOL) = ^(BOOL isCompletion) {
        if (weakSelf.selectedViewController) {
            [weakSelf.selectedViewController willMoveToParentViewController:nil];
            [weakSelf.selectedViewController.view removeFromSuperview];
            [weakSelf.selectedViewController removeFromParentViewController];
        }
        weakSelf.selectedViewController = controller;
    };
    
    if (isAnimated && _selectedViewController) {
        [UIView animateWithDuration:.5 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
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
        
        for (UIViewController *viewController in viewControllersArr) {
            [viewController setCustomTabbarController:self];
        }
        
        [self dismissTabbarView:NO];
        
    } else {
        for (UIViewController *viewController in _viewControllersArr) {
            [viewController setCustomTabbarController:nil];
        }
        
        _viewControllersArr = nil;
    }
}

- (void)showTabbarView:(BOOL)isAnimated {
    [self.view bringSubviewToFront:self.bgMarkCtrl];
    [self.view bringSubviewToFront:self.tabbarView];
    self.tabbarView.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    void (^block)() = ^{
        weakSelf.tabbarView.transform = CGAffineTransformIdentity;
        weakSelf.bgMarkCtrl.alpha = .3;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
    };
    
    if (isAnimated) {
        [UIView animateWithDuration:0.24 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
}

- (void)dismissTabbarView:(BOOL)isAnimated {
    __weak typeof(self) weakSelf = self;
    void (^block)() = ^{
        weakSelf.tabbarView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(weakSelf.tabbarView.bounds), 0);
        weakSelf.bgMarkCtrl.alpha = .0;
    };
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        weakSelf.tabbarView.hidden = YES;
    };
    
    if (isAnimated) {
        [UIView animateWithDuration:0.24 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
}

- (void)showLoginViewController {
    [self performSegueWithIdentifier:@"presentLgoinViewController" sender:self];
}

- (void)showStudyViewController {
    [self performSegueWithIdentifier:@"presentStudyViewController" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBAction
- (IBAction)onTapTabbarItems:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [self setSelectedIndex:btn.tag isAnimated:NO];
    
    [self dismissTabbarView:NO];
}


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
