//
//  FMDetailChangeTableViewCell.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailChangeTableViewCell.h"

@implementation FMDetailChangeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutChangeTableViewCell {
    self.textView.text = @"-机油更换\n-排放螺旋垫片更换";
}

@end
