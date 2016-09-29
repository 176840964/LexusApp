//
//  CustomZoomScaleImageView.m
//  LexusApp
//
//  Created by Dragonet on 2016/9/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "CustomZoomScaleImageView.h"

@interface CustomZoomScaleImageView ()
@property (strong, nonatomic) UIImageView *imgView;
@end

@implementation CustomZoomScaleImageView

- (void)layoutCustomZoomScaleImageView {
    self.delegate = self;
    self.backgroundColor = [UIColor clearColor];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 5.0;
}

- (void)setImage:(UIImage *)image {
    self.imgView.image = image;
}

#pragma mark -
- (UIImageView*)imgView {
    if (nil == _imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64)];
        [self addSubview:_imgView];
    }
    
    return _imgView;
}

#pragma mark - UIScrollViewDelegate
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
}

@end
