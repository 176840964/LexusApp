//
//  DAType1View.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAType1View.h"

@interface DAType1View ()
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UIImageView *imgView2;
@property (strong, nonatomic) UIImageView *imgView3;
@property (strong, nonatomic) UIImageView *imgView4;
@property (strong, nonatomic) UIImageView *imgView5;
@end

@implementation DAType1View

- (void)setupSubviewsByType1Model:(DAType1Model*)model {
    self.imgView1 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView1];
    [self.imgView1 autoPinEdgesToSuperviewEdges];
    
    self.imgView2 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView2];
    [self.imgView2 autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:35];
    [self.imgView2 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.imgView2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.imgView2];
    
    self.imgView3 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView3];
    [self.imgView3 autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.imgView2 withOffset:15];
    [self.imgView3 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.imgView3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.imgView3];
    [self.imgView3 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.imgView2];
    
    self.imgView4 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView4];
    [self.imgView4 autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.imgView3 withOffset:15];
    [self.imgView4 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.imgView4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.imgView4];
    [self.imgView4 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.imgView3];
    
    self.imgView5 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView5];
    [self.imgView5 autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:self.imgView4 withOffset:15];
    [self.imgView5 autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:35];
    [self.imgView5 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [self.imgView5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.imgView5];
    [self.imgView5 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.imgView4];
    
    
    [self.imgView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str1]]];
    [self.imgView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str2]]];
    [self.imgView3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str3]]];
    [self.imgView4 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str4]]];
    [self.imgView5 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str5]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
