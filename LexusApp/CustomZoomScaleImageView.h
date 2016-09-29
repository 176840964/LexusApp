//
//  CustomZoomScaleImageView.h
//  LexusApp
//
//  Created by Dragonet on 2016/9/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomZoomScaleImageView : UIScrollView <UIScrollViewDelegate>
@property (strong, nonatomic) UIImage *image;

- (void)layoutCustomZoomScaleImageView;
@end
