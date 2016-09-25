//
//  FMDetailChangeTableViewCell.h
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMDetailChangeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

- (void)layoutChangeTableViewCellWithDataDic:(NSDictionary *)dic;
@end
