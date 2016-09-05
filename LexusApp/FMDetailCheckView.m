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

#pragma mark - IBAction
- (IBAction)onTapSubviewBtn:(id)sender {
    UIButton * btn = (UIButton *)sender;
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
