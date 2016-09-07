//
//  StudyListTableViewCell.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyListTableViewCell.h"

@interface StudyListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *numImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@end

@implementation StudyListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model {
    self.numImageView.image = [UIImage imageNamed:model.numIconStr];
    self.userIconImageView.image = [UIImage imageNamed:model.userIconStr];
    self.userNameLab.text = model.userNameStr;
}

#pragma mark - IBAciton
- (IBAction)onTapPlayBtn:(id)sender {
    
}

@end
