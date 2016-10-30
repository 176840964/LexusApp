//
//  StudyUpdateListTableViewCell.h
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyListModel.h"

@interface StudyUpdateListTableViewCell : UITableViewCell

@property (strong, nonatomic) StudyListModel *studyModel;
@property (copy, nonatomic) void(^tapListenBtnHandle)(StudyListModel*);
@property (copy, nonatomic) void(^tapGoodBtnHandle)(StudyListModel*);
- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model index:(NSInteger)index;

@end
