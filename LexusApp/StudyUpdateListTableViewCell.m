//
//  StudyUpdateListTableViewCell.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyUpdateListTableViewCell.h"

@interface StudyUpdateListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *goodBtn;

@end

@implementation StudyUpdateListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model index:(NSInteger)index {
    self.studyModel = model;
    self.userIconImageView.image = [UIImage imageNamed:@"manIcon"];
    self.userNameLab.text = model.username;
    self.numLab.text = [NSString stringWithFormat:@"%zd", index + 1];
}

#pragma mark - IBAction
- (IBAction)onTapPlayBtn:(id)sender {
    if (self.tapListenBtnHandle) {
        self.tapListenBtnHandle(self.studyModel);
    }
}

- (IBAction)onTapGoodBtn:(id)sender {
    if (self.tapGoodBtnHandle) {
        self.tapGoodBtnHandle(self.studyModel);
    }
}

@end
