//
//  CustomHintViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/20.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CustomHintViewController.h"

@interface CustomHintViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *messageLab;
@property (weak, nonatomic) IBOutlet UIView *activityBg;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@property (copy, nonatomic) void(^dismissBlock)();
@property (strong, nonatomic) NSTimer *presentTimer;
@end

@implementation CustomHintViewController

+ (instancetype)getInstance {
    static CustomHintViewController *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[CustomHintViewController alloc] initWithNibName:@"CustomHintViewController" bundle:nil];
    });
    
    return s_instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentMessage:(NSString *)message parentController:(UIViewController*)parentController isAutoDismiss:(BOOL)isAuto dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^)(void))dismissBlock {
    
    [self becomeChildrenControllerAddToParentController:parentController];
    self.messageLab.text = message;
    
    self.messageLab.hidden = NO;
    self.messageLab.alpha = 0.0;
    [UIView animateWithDuration:seconds / 2 animations:^{
        self.messageLab.alpha = 1.0;
        self.messageLab.transform = CGAffineTransformMakeTranslation(0, -10);
    } completion:^(BOOL finished) {
        
    }];
    
    if (dismissBlock) {
        self.dismissBlock = dismissBlock;
    }
    
    if (isAuto) {
        self.closeBtn.enabled = NO;
        self.presentTimer = [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(dismissMessage) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.presentTimer forMode:NSRunLoopCommonModes];
    } else {
        self.closeBtn.enabled = YES;
    }
}

- (void)startLoadingMessage:(NSString *)startMessage parentController:(UIViewController*)parentController {
    [self becomeChildrenControllerAddToParentController:parentController];
    self.closeBtn.enabled = NO;
    self.messageLab.text = startMessage;
    self.messageLab.hidden = NO;
    self.messageLab.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        self.messageLab.alpha = 1.0;
        self.messageLab.transform = CGAffineTransformMakeTranslation(0, -10);
    }];
}

- (void)endLoadingMessage:(NSString *)endMessage dismissTimeInterval:(NSTimeInterval)seconds dismissBlock:(void (^) (void))dismissBlock {
    if (endMessage.isValid) {
        self.messageLab.text = endMessage;
    }
    
    if (dismissBlock) {
        self.dismissBlock = dismissBlock;
    }
    
    self.presentTimer = [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(dismissMessage) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.presentTimer forMode:NSRunLoopCommonModes];
}

- (void)dismissMessage {
    [UIView animateWithDuration:1 animations:^{
        self.messageLab.alpha = 0.0;
        self.messageLab.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self endSimpleLoading];
        [self removeFromParentController];
        self.messageLab.hidden = YES;
        self.messageLab.text = @"";
        [self.presentTimer invalidate];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
}

- (void)showSimpleLoading:(UIViewController *)parentController; {
    [self becomeChildrenControllerAddToParentController:parentController];
    self.activityBg.hidden = NO;
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

- (void)endSimpleLoading {
    self.activityBg.hidden = YES;
    self.activityView.hidden = YES;
    [self removeFromParentController];
}

#pragma mark - 
- (void)becomeChildrenControllerAddToParentController:(UIViewController*)parentController {
    if (self.parentViewController) {
        return;
    }
    
    [self beginAppearanceTransition:YES animated:NO];
    [parentController addChildViewController:self];
    [parentController.view addSubview:self.view];
    self.view.frame = parentController.view.bounds;
    [self didMoveToParentViewController:self];
    [self endAppearanceTransition];
}

- (void)removeFromParentController {
    if (!self.parentViewController) {
        return;
    }
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)onTapCloseBtn:(id)sender {
    [self dismissMessage];
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
