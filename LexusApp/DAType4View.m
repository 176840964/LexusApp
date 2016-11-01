//
//  DAType4View.m
//  LexusApp
//
//  Created by Dragonet on 2016/10/30.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "DAType4View.h"
#import <AVFoundation/AVFoundation.h>
@interface DAType4View ()
@property (strong, nonatomic) UIImageView *imgView1;
@property (strong, nonatomic) UIButton *button;

@property (copy, nonatomic) NSString *videoStr;
@end

@implementation DAType4View

- (void)setupSubviewsByType1Model:(DAType4Model*)model {
    self.imgView1 = [UIImageView newAutoLayoutView];
    [self addSubview:self.imgView1];
    [self.imgView1 autoPinEdgesToSuperviewEdges];
    
    self.button = [UIButton newAutoLayoutView];
    [self.button setImage:[UIImage imageNamed:@"videoPlay"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(onTapVideoPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    [self.button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [self.button autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:30];
    [self.button autoSetDimension:ALDimensionWidth toSize:344];
    [self.button autoSetDimension:ALDimensionHeight toSize:166];
    
    [self.imgView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str1]]];
    self.videoStr = [NSString stringWithFormat:@"http://114.55.235.176/lkss/%@", model.str2];
}

- (void)onTapVideoPlayBtn:(UIButton *)btn {
    if (self.playVideo) {
        self.playVideo(self.videoStr);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
