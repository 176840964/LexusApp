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

- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model index:(NSInteger)index listeningIndex:(NSInteger)listeningIndex{
    self.studyModel = model;
    if (index < 3) {
        self.numImageView.hidden = NO;
        self.numLab.hidden = YES;
        self.numImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"study_num%zd", index + 1]];
    } else {
        self.numImageView.hidden = YES;
        self.numLab.hidden = NO;
        self.numLab.text = [NSString stringWithFormat:@"%zd", index + 1];
    }
    self.userIconImageView.image = [UIImage imageNamed:@"manIcon"];
    self.userNameLab.text = model.username;
    self.playBtn.selected = (index == listeningIndex);
}

#pragma mark - IBAciton
- (IBAction)onTapPlayBtn:(id)sender {
    self.playBtn.selected = !self.playBtn.selected;
    if (self.tapListenBtnHandle) {
        self.tapListenBtnHandle(self.studyModel, self.playBtn.selected);
    }
}

@end
