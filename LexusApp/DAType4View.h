//
//  DAType4View.h
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAType4Model.h"

@interface DAType4View : UIView

@property (copy, nonatomic) void (^playVideo)(NSString *);

- (void)setupSubviewsByType1Model:(DAType4Model*)model;
@end
