//
//  FMDetailCheckView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailCheckView.h"

@interface FMDetailCheckView ()
@property (weak, nonatomic) IBOutlet UILabel *testLab;
@end

@implementation FMDetailCheckView

- (void)setupSubviewsByCheckArr:(NSArray *)arr {
    CGFloat x = ((CGRectGetWidth(self.bounds) - 80) - (125 * arr.count + 8 * (arr.count - 1))) / 2.0 + 80;
    for (NSInteger index = 0; index < arr.count; index++) {
        NSString *str = [arr objectAtIndex:index];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(x + index * (125 + 8), CGRectGetHeight(self.bounds) - 128, 125, 49);
        btn.cornerRadius = 4.0;
        btn.borderColor = [UIColor colorWithHexString:@"#7c7c7c"];
        btn.borderWidth = 2.0;
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:17];
        [btn setTitleColor:[UIColor colorWithHexString:@"#7c7c7c"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateHighlighted];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapSelectedCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

#pragma mark -
- (void)onTapSelectedCheckBtn:(UIButton*)btn {
    self.testLab.text = btn.titleLabel.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
