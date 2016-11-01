//
//  DAType5View.h
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DAType5Model.h"

@interface DAType5View : UIView
@property (copy, nonatomic) void (^playVideo)(NSString *);

- (void)setupSubviewsByType1Model:(DAType5Model*)model;
@end
