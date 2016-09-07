//
//  GestureUnlockView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "GestureUnlockView.h"

@interface GestureUnlockView ()

@property(strong, nonatomic) NSMutableArray *selectedBtnsTagArr;
@property(assign, nonatomic) CGPoint curPoint;
@property(assign, nonatomic) BOOL isFinished;
@end

@implementation GestureUnlockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        for (NSInteger index = 0; index < 9; index ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(index % 3 * (52 + 73), index / 3 * (52 + 33), 52, 52);
            btn.tag = index + 1;
            btn.userInteractionEnabled = NO;    // 不让用户点击, 防止点击显示高亮状态
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if(0 == self.selectedBtnsTagArr.count) {
        return;
    }
        
    // 把所有选中按钮的中心点连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    for (NSInteger index = 0; index < self.selectedBtnsTagArr.count; index++) {
        NSString *tagStr = [self.selectedBtnsTagArr objectAtIndex:index];
        UIButton *btn = [self viewWithTag:[tagStr integerValue]];
        if(index == 0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    
    // 判断是否松开手指
    if(self.isFinished) {
        if([self checkGestureResult]) { // 解锁成功
            [[UIColor blueColor] set];
            // 如果实现了解锁成功的代理方法
            if(self.delegate && [self.delegate respondsToSelector:@selector(gestureViewUnlockSuccess:)]) {
                [self.delegate gestureViewUnlockSuccess:self];
            }
        }else { // 解锁失败
            [[UIColor redColor] set];
        }
    }else {
        // 将路径描绘到当前的触摸点
        [path addLineToPoint:self.curPoint];
        // 设置绘制颜色
        [[UIColor colorWithRed:0 green:1.0 blue:0 alpha:.3] set];
    }
    
    // 线宽
    [path setLineWidth:10];
    // 线端圆角
    [path setLineCapStyle:kCGLineCapRound];
    // 线转角圆角
    [path setLineJoinStyle:kCGLineJoinRound];
    // 根据路径渲染
    [path stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isFinished = NO;
    
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = NO;
        }
    }
    [self.selectedBtnsTagArr removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark -
- (NSMutableArray *)selectedBtnsTagArr {
    if(nil == _selectedBtnsTagArr) {
        _selectedBtnsTagArr = [NSMutableArray new];
    }
    
    return _selectedBtnsTagArr;
}

- (BOOL)checkGestureResult {
    NSMutableString *resultStr = [NSMutableString string];
    for (NSString *str in self.selectedBtnsTagArr) {
        [resultStr appendString:str];
    }
    
    return [resultStr isEqualToString:self.gestureModel.gesturePasswordStr];
}

#pragma mark - UIGestureRecognizer
- (void)pan:(UIGestureRecognizer *)recognizer {
    
    self.curPoint = [recognizer locationInView:self];
    
    for (UIButton *btn in self.subviews) {
        if(CGRectContainsPoint(btn.frame, self.curPoint)) {
            btn.selected = YES;
            NSString *tagStr = [NSString stringWithFormat:@"%zd", btn.tag];
            if (![self.selectedBtnsTagArr.lastObject isEqualToString:tagStr]) {
                [self.selectedBtnsTagArr addObject:tagStr];
            }
        }
    }
    
    [self setNeedsDisplay];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        self.isFinished = YES;
    }
}


@end
