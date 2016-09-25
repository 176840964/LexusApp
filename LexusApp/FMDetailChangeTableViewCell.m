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

- (void)layoutChangeTableViewCellWithDataDic:(NSDictionary *)dic {
    NSString *thumbnailStr = [NSString stringWithFormat:@"changeThumb%@", [dic objectForKey:@"thumbnail"]];
    self.imageView.image = [UIImage imageNamed:thumbnailStr];
}

@end
