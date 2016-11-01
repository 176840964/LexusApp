//
//  DAType3View.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAType3View.h"
@interface DAType3View ()
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation DAType3View

- (void)setupSubviewsByType1Model:(DAType3Model*)model {
    self.imgView1 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView1];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    self.webView = [UIWebView newAutoLayoutView];
    self.webView.userInteractionEnabled = NO;
    [self addSubview:self.webView];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.webView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.webView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imgView1];
    [self.webView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.imgView1];
    
    [self.imgView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str1]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str2]]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
