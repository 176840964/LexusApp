//
//  StudySelectCarView.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudySelectCarView.h"

@interface StudySelectCarView ()
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *carBtnsArr;
@property (assign, nonatomic) NSInteger curSelectedIndex;
@property (strong, nonatomic) NSMutableArray *carModelBtnArr;
@property (strong, nonatomic) NSArray *carModelsArr;
@end

@implementation StudySelectCarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupSubviews {
    for (UIButton *btn in self.carBtnsArr) {
        [btn removeFromSuperview];
    }
    [self.carBtnsArr removeAllObjects];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width *2, self.scrollView.height);
    
    self.carBtnsArr = [NSMutableArray new];
    NSInteger count = [CarCategoreManager shareManager].carsCount;
    CGFloat spacing = self.scrollView.width / count;
    for (NSInteger index = 0; index < count;  index ++) {
        NSString *carName = [[[CarCategoreManager shareManager] getCarInfoDicByIndex:index] objectForKey:@"name"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.scrollView.center.x - spacing / 2.0 + spacing * index, (self.scrollView.height - 40) / 2.0, spacing, 40);
        btn.tag = index;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:carName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapCarNameBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        [self.carBtnsArr addObject:btn];
        
        CGFloat fontVal = 38;
        CGFloat alphaVal = 1;
        if (4 != index) {
            fontVal = fmax(index, 4.0) / fmin(4.0, index) * 40;
            alphaVal = fmax(index, 4.0) / fmin(4.0, index) * 1.0;
        }
        
        btn.alpha = alphaVal;
        btn.titleLabel.font = [UIFont fontWithName:@"Nobel-Black" size:fontVal];
    }
    
    UIButton *btn = [self.carBtnsArr objectAtIndex:4];
    [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)setCurSelectedIndex:(NSInteger)curSelectedIndex {
    _curSelectedIndex = curSelectedIndex;
    
    for (UIButton *btn in self.carModelBtnArr) {
        [btn removeFromSuperview];
    }
    [self.carModelBtnArr removeAllObjects];
    
    NSDictionary *carInfo = [[CarCategoreManager shareManager] getCarInfoDicByIndex:_curSelectedIndex];
    self.selectedCarNameStr = [carInfo objectForKey:@"name"];
    self.carModelsArr = [[CarCategoreManager shareManager] getCarModelsByCarName:self.selectedCarNameStr];
    self.carImageView.image = [UIImage imageNamed:self.selectedCarNameStr];
    
    NSInteger x = (CGRectGetWidth(self.bounds) - (70 * self.carModelsArr.count + 24 * (self.carModelsArr.count - 1))) / 2.0;
    for (NSInteger index = 0; index < self.carModelsArr.count; index ++) {
        NSString *carModel = [self.carModelsArr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(x + (70 + 24) * index, self.center.y + 127 + 5, 70, 26);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:8];
        [btn setTitle:[NSString stringWithFormat:@"%@%@", self.selectedCarNameStr, carModel] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#89939c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#373737"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"car_highlight"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(onTapSelectedCar:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.carModelBtnArr addObject:btn];
    }
}

- (NSMutableArray *)carModelBtnArr {
    if (nil == _carModelBtnArr) {
        _carModelBtnArr = [[NSMutableArray alloc] init];
    }
    return _carModelBtnArr;
}

#pragma mark -
- (void)scrollViewEnd:(UIScrollView *)scrollView {
    CGFloat min = scrollView.width;
    NSInteger tag = 0;
    UIButton *button = nil;
    for (UIButton *btn in self.carBtnsArr) {
        CGRect rect = [scrollView convertRect:btn.frame toView:self];
        CGFloat val = self.center.x - CGRectGetMidX(rect);
        //        NSLog(@"%f, %f", fabs(min), val);
        if (fabs(min) > fabs(val)) {
            min = val;
            tag = btn.tag;
            button = btn;
        }
    }
    
    scrollView.contentOffset = CGPointMake(button.center.x - scrollView.contentSize.width / 4.0, scrollView.contentOffset.y);
    self.curSelectedIndex = tag;
}

- (void)onTapCarNameBtn:(UIButton*)btn {
    self.curSelectedIndex = btn.tag;
    self.scrollView.contentOffset = CGPointMake(btn.center.x - self.scrollView.contentSize.width / 4.0, self.scrollView.contentOffset.y);
}

- (void)onTapSelectedCar:(UIButton*)btn {
    self.selectedCarModelStr = [self.carModelsArr objectAtIndex:btn.tag];
    if (self.selectedCarHandle) {
        self.selectedCarHandle(self.selectedCarNameStr, self.selectedCarModelStr);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger count = [CarCategoreManager shareManager].carsCount;
    CGFloat spacing = self.scrollView.width / count;
    CGRect mainRect = CGRectMake((self.width - spacing) / 2.0, (self.scrollView.height - 40) / 2.0, spacing, 40);
    for (UIButton *btn in self.carBtnsArr) {
        CGRect rect = [self.scrollView convertRect:btn.frame toView:self];
        CGFloat font = 50;
        CGFloat alpha = 100.0;
        //    NSLog(@"%f, %f", CGRectGetMidX(rect), CGRectGetMinX(mainRect));
        if (CGRectGetMidX(rect) < CGRectGetMinX(mainRect)) {
            font = 30 - (CGRectGetMinX(mainRect) - CGRectGetMidX(rect)) / self.center.x * 35;
            alpha = 80 - (CGRectGetMinX(mainRect) - CGRectGetMidX(rect)) / self.center.x * 95;
        } else if (CGRectGetMidX(rect) > CGRectGetMaxX(mainRect)) {
            font = 10 + (1 - (CGRectGetMidX(rect) - CGRectGetMaxX(mainRect)) / self.center.x) * 25;
            alpha = 5 + (1 - (CGRectGetMidX(rect) - CGRectGetMaxX(mainRect)) / self.center.x) * 75;
        } else {
            font = 40;
            alpha = 100;
        }
        btn.alpha = alpha / 100.0;
        btn.titleLabel.font = [UIFont fontWithName:@"Nobel-Black" size:font];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self scrollViewEnd:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewEnd:scrollView];
}

@end
