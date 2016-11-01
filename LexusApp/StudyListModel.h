//
//  StudyListModel.h
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudyListModel : BaseModel

@property (copy, nonatomic) NSString *car_distince;
@property (copy, nonatomic) NSString *car_type;
@property (strong, nonatomic) NSNumber *csid;
@property (strong, nonatomic) NSNumber *date;
@property (strong, nonatomic) NSNumber *hasupdate;
@property (strong, nonatomic) NSNumber *num;
@property (copy, nonatomic) NSString *song_url;
@property (strong, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSNumber *update_date;
@property (strong, nonatomic) NSNumber *userid;
@property (copy, nonatomic) NSString *username;

@end
