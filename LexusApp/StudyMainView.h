//
//  StudyMainView.h
//  LexusApp
//
//  Created by Dragonet on 16/9/8.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudyMainView : UIView

@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (copy, nonatomic) NSString *carNameStr;
@property (copy, nonatomic) NSString *carKMStr;

- (void)sutupSubviews;

@end
