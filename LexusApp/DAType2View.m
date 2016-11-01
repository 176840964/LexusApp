//
//  DAType2View.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAType2View.h"

@interface DAType2View ()
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UIImageView *imgView2;
@end

@implementation DAType2View

- (void)setupSubviewsByType1Model:(DAType2Model*)model {
    self.imgView1 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView1];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.imgView1 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.imgView1 autoSetDimension:ALDimensionWidth toSize:210];
    
    self.imgView2 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView2];
    [self.imgView2 autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.imgView2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.imgView2 autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.imgView2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.imgView1];
    
    [self.imgView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str1]]];
    [self.imgView2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str2]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
