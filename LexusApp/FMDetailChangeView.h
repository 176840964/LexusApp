//
//  FMDetailChangeView.h
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMDetailChangeView : UIView

@property (weak, nonatomic) IBOutlet UILabel *descriptionPriceLab;

@property (copy, nonatomic) void(^didSelectedChangeItem)(NSDictionary *dic);
@property (copy, nonatomic) NSString *carNameStr;

- (void)setupSubviewsWithDataArr:(NSArray*)dataArr;

@end
