//
//  FMDetailCheckView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailCheckView.h"

@interface FMDetailCheckView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *thumbBtn;
@property (weak, nonatomic) IBOutlet UIButton *bigBtn;
@property (strong, nonatomic) NSArray *dataArr;

@property (copy, nonatomic) NSString *fileNameStr;
@property (strong, nonatomic) NSMutableArray *hotZoneBtnsArr;
@property (strong, nonatomic) NSMutableArray *showingHotZone;
@property (copy, nonatomic) NSString *showingItemStr;
@end

@implementation FMDetailCheckView

- (void)setupSubviewsByCheckArr:(NSArray *)arr {
    self.hotZoneBtnsArr = [NSMutableArray new];
    self.dataArr = arr;
    CGFloat x = ((CGRectGetWidth(self.bounds) - 80) - (125 * arr.count + 8 * (arr.count - 1))) / 2.0 + 80;
    for (NSInteger index = 0; index < arr.count; index++) {
        NSDictionary *dic = [arr objectAtIndex:index];
        NSString *str = [dic objectForKey:@"title"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(x + index * (125 + 8), CGRectGetHeight(self.bounds) - 128, 125, 49);
        btn.cornerRadius = 4.0;
        btn.borderColor = [UIColor colorWithHexString:@"#7c7c7c"];
        btn.borderWidth = 2.0;
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:17];
        [btn setTitleColor:[UIColor colorWithHexString:@"#7c7c7c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateSelected];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapSelectedCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (0 == index) {
            [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
}

#pragma mark -
- (void)onTapSelectedCheckBtn:(UIButton*)btn {
    [self setAllBtnNormalState];
    btn.backgroundColor = [UIColor whiteColor];
    btn.selected = YES;
    
    self.fileNameStr = [[self.dataArr objectAtIndex:btn.tag] objectForKey:@"plist"];
    self.imgView.image = [UIImage imageNamed:self.fileNameStr];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:self.fileNameStr ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.showingHotZone = [dic objectForKey:@"hot_zone"];
    for (NSInteger index = 0; index < self.showingHotZone.count; index++) {
        NSDictionary *itemDic = [self.showingHotZone objectAtIndex:index];
        NSNumber *x = [itemDic objectForKey:@"x"];
        NSNumber *y = [itemDic objectForKey:@"y"];
        NSNumber *width = [itemDic objectForKey:@"width"];
        NSNumber *height = [itemDic objectForKey:@"height"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.frame = CGRectMake(x.floatValue / 2.0, y.floatValue / 2.0, width.floatValue / 2.0, height.floatValue / 2.0);
        btn.backgroundColor = [UIColor redColor];
        btn.alpha = .5;
        [btn addTarget:self action:@selector(onTapHotZoneBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgView addSubview:btn];
        [self.hotZoneBtnsArr addObject:btn];
    }
}

- (void)onTapHotZoneBtn:(UIButton *)btn {
    NSDictionary *dic = [self.showingHotZone objectAtIndex:btn.tag];
    self.showingItemStr = [dic objectForKey:@"img"];
    
    void (^showThumbBtnBlock)() = ^{
        self.thumbBtn.transform = CGAffineTransformMakeTranslation(self.thumbBtn.width + 40, 0);
        [self.thumbBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@_t", self.carStr, self.showingItemStr]] forState:UIControlStateNormal];
    };
    
    if (self.thumbBtn.hidden) {
        showThumbBtnBlock();
        self.thumbBtn.hidden = NO;
    } else {
        [UIView animateWithDuration:.25 animations:showThumbBtnBlock completion:^(BOOL finished) {
            [UIView animateWithDuration:.5 animations:^{
                self.thumbBtn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
            }];
        }];
    }
}

- (void)setAllBtnNormalState {
    for (UIButton *btn in self.hotZoneBtnsArr) {
        [btn removeFromSuperview];
    }
    
    [self.hotZoneBtnsArr removeAllObjects];
    
    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.backgroundColor = [UIColor clearColor];
            btn.selected = NO;
        }
    }
}

#pragma mark - IBAction
- (IBAction)onTapThumbBtn:(id)sender {
    [self.bigBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", self.carStr, self.showingItemStr]] forState:UIControlStateNormal];
    self.bigBtn.hidden = NO;
}

- (IBAction)onTapBigBtn:(id)sender {
    self.bigBtn.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
