//
//  StudyListTableViewCell.h
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudyListModel.h"

@interface StudyListTableViewCell : UITableViewCell

@property (strong, nonatomic) StudyListModel *studyModel;
@property (copy, nonatomic) void(^tapListenBtnHandle)(StudyListModel*);
- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model index:(NSInteger)index listeningIndex:(NSInteger)listeningIndex;

@end
