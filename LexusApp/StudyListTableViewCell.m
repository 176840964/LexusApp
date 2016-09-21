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
@property (weak, nonatomic) IBOutlet UILabel *numLab;
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

- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model andIndex:(NSInteger)index {
    if (index < 3) {
        self.numImageView.hidden = NO;
        self.numLab.hidden = YES;
        self.numImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"study_num%zd", index + 1]];
    } else {
        self.numImageView.hidden = YES;
        self.numLab.highlighted = NO;
        self.numLab.text = [NSString stringWithFormat:@"%zd", index + 1];
    }
    self.userIconImageView.image = [UIImage imageNamed:model.userIconStr];
    self.userNameLab.text = model.userNameStr;
}

#pragma mark - IBAciton
- (IBAction)onTapPlayBtn:(id)sender {
    
}

@end
