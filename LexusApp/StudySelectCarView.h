//
//  StudySelectCarView.h
//  LexusApp
//
//  Created by Dragonet on 2016/10/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudySelectCarView : UIView <UIScrollViewDelegate>
@property (copy, nonatomic) NSString *selectedCarNameStr;
@property (copy, nonatomic) NSString *selectedCarModelStr;

@property (copy, nonatomic) void(^selectedCarHandle)(NSString*, NSString*);

- (void)setupSubviews;
@end
