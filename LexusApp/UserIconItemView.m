//
//  UserIconItemView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/6.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "UserIconItemView.h"

@implementation UserIconItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = .5;
        
        self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconBtn.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame));
        [self.iconBtn addTarget:self action:@selector(onTapIconBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.iconBtn];
        
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.iconBtn.frame) + 8, CGRectGetWidth(frame), 15)];
        self.nameLab.textAlignment = NSTextAlignmentCenter;
        self.nameLab.font = [UIFont fontWithName:@"MHeiGB" size:13];
        self.nameLab.textColor = [UIColor whiteColor];
        [self addSubview:self.nameLab];
        
//        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizer:)];
//        longPressGestureRecognizer.minimumPressDuration = 1.0;
//        [self.iconBtn addGestureRecognizer:longPressGestureRecognizer];
        
    }
    return self;
}

- (void)setupUserIconItemByUserModel:(UserModel *)model {
    [self.iconBtn setImage:[UIImage imageNamed:model.iconStr] forState:UIControlStateNormal];
    self.nameLab.text = model.name;
    self.userModel = model;
}

//- (void)shakeAnimation {
//    CGAffineTransform leftQuake = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4 / 16.0);
//    CGAffineTransform rightQuake = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4 / 16.0);
//    
//    self.iconBtn.transform = leftQuake;  // starting point
//    
//    [UIView beginAnimations:@"earthquake" context:(__bridge void * _Nullable)(self.iconBtn)];
//    [UIView setAnimationRepeatAutoreverses:YES];// important
//    [UIView setAnimationRepeatCount:1000];
//    [UIView setAnimationDuration:0.07];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
//    
//    self.iconBtn.transform = rightQuake;// end here & auto-reverse
//    
//    [UIView commitAnimations];
//}
//
//-(void)earthquakeEnded:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
//{
//    if([finished boolValue])
//    {
//        UIView* item =(__bridge UIView*)context;
//        item.transform =CGAffineTransformIdentity;
//    }
//}

#pragma mark -
- (void)onTapIconBtn:(UIButton *)btn {
    
    if (self.tapUserIconHandler) {
        self.tapUserIconHandler(self.userModel);
    }
}

//- (void)longPressGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
//    if (self.longPressHandler) {
//        self.longPressHandler();
//    }
//}

@end
