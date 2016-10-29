//
//  StudySelectKMView.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudySelectKMView.h"

@interface StudySelectKMView ()
@property (weak, nonatomic) IBOutlet UIImageView *carImgView;
@property (strong, nonatomic) NSMutableArray *btnsArr;
@property (copy, nonatomic) NSString *carAllName;
@end

@implementation StudySelectKMView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupSubviewsByCarName:(NSString *)carName carModel:(NSString *)carModel {
    self.carAllName = [NSString stringWithFormat:@"%@%@", carName, carModel];
    for (UIButton *btn in self.btnsArr) {
        [btn removeFromSuperview];
    }
    [self.btnsArr removeAllObjects];
    
    NSString *str = [self carImageNameByCarName:carName carMode:carModel];
    self.carImgView.image = [UIImage imageNamed:str];
    NSArray *kmArr = [[CarCategoreManager shareManager] getCarKMByCarName:carName carModel:carModel];
    
    CGFloat x = ((CGRectGetWidth(self.bounds) - 60) - (35 * kmArr.count + 8 * (kmArr.count - 1))) / 2.0 + 60;
    for (NSInteger index = 0; index < kmArr.count; index++) {
        NSString *str = [NSString stringWithFormat:@"%zd万", index + 1];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = index;
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(x + index * (35 + 8), CGRectGetHeight(self.bounds) - 50 - 35 - 3, 35, 35);
        btn.titleLabel.font = [UIFont fontWithName:@"LEXUS-HeiS-Xbold-U" size:12];
        [btn setTitleColor:[UIColor colorWithHexString:@"#5f5f5f"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#050608"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"kmBtn_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"kmBtn_highlight"] forState:UIControlStateHighlighted];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onTapSelectedKmBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
    }
}

- (NSMutableArray*)btnsArr {
    if (nil == _btnsArr) {
        _btnsArr = [NSMutableArray new];
    }
    
    return _btnsArr;
}

#pragma mark - 
- (void)onTapSelectedKmBtn:(UIButton *)btn {
    if (self.selectedKMHandle) {
        self.selectedKMHandle([NSString stringWithFormat:@"%zd万", btn.tag + 1], self.carAllName);
    }
}

- (NSString *)carImageNameByCarName:(NSString *)carName carMode:(NSString *)carModel{
    if ([carName isEqualToString:@"GS"]) {
        if ([carModel isEqualToString:@"350h"] || [carModel isEqualToString:@"450h"]) {
            return @"GS450h-300h";
        } else {
            return @"GS-200t-250-350-350(AWD)";
        }
    } else if ([carName isEqualToString:@"LS"]) {
        if ([carModel isEqualToString:@"600hl"]) {
            return @"LS600hl";
        } else {
            return @"LS460(4wd)";
        }
    } else if ([carName isEqualToString:@"NX"]) {
        if ([carModel isEqualToString:@"300h(4wd)"]) {
            return @"NX300h";
        } else {
            return @"NX200t、200（4WD)";
        }
    } else if ([carName isEqualToString:@"RX"]) {
        if ([carModel isEqualToString:@"450h"]) {
            return @"RX450h";
        } else {
            return @"RX200t、RX270、350";
        }
    } else {
        return [NSString stringWithFormat:@"%@KM", carName];
    }
}

#pragma mark - IBAction
- (IBAction)onTapBackBtn:(id)sender {
    if (self.tapBackBtnHandle) {
        self.tapBackBtnHandle();
    }
}

@end
