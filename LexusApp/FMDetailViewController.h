//
//  FMDetailViewController.h
//  LexusApp
//
//  Created by Dragonet on 16/9/4.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "BaseViewController.h"

@interface FMDetailViewController : BaseViewController
@property (strong, nonatomic) NSDictionary *detailDic;

@property (copy, nonatomic) NSString *carName;
@property (copy, nonatomic) NSString *carModel;
@end
