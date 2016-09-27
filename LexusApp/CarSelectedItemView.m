//
//  CarSelectedItemView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/14.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CarSelectedItemView.h"

@implementation CarSelectedItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSArray *arr = [CarPositionManager shareInstance].carPosArr;
    for (CarPosItem *item in arr) {
        CGRect rect = [item realRectByFatherViewWidth:self.width height:self.height];
        if (CGRectContainsPoint(rect, point) && self.touchHotRangeHandle) {
            self.touchHotRangeHandle(item.offset);
            break;
        }
    }
}

- (UIImageView *)imgView {
    if (nil == _imgView) {
        _imgView = [UIImageView newAutoLayoutView];
        [self addSubview:_imgView];
        [_imgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [_imgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_imgView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [_imgView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    }
    
    return _imgView;
}

@end
