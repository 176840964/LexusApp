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

- (void)layoutSubViewsByStudyListModel:(StudyListModel*)model andIndex:(NSInteger)index;

@end
