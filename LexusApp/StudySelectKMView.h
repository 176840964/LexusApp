//
//  StudySelectKMView.h
//  LexusApp
//
//  Created by Dragonet on 2016/10/29.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudySelectKMView : UIView

@property (copy, nonatomic) void (^tapBackBtnHandle)();
@property (copy, nonatomic) void (^selectedKMHandle)(NSString *KMStr, NSString*);

- (void)setupSubviewsByCarName:(NSString *)carName carModel:(NSString *)carModel;

@end
