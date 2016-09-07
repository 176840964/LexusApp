//
//  GestureUnlockView.h
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GestureModel.h"

@protocol GestureUnlockViewDelegate;

@interface GestureUnlockView : UIView

@property (strong, nonatomic) GestureModel * gestureModel;
@property (weak, nonatomic) id<GestureUnlockViewDelegate> delegate;

@end

@protocol GestureUnlockViewDelegate <NSObject>

- (void)gestureViewUnlockSuccess:(GestureUnlockView *)gestureView;

@end
