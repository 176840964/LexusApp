//
//  FMDetailChangeView.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "FMDetailChangeView.h"
#import "FMDetailChangeShowView.h"
#import "FMDetailChangeTableViewCell.h"

@interface FMDetailChangeView () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *descriptionPriceLab;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FMDetailChangeShowView *showView;
@end

@implementation FMDetailChangeView

- (void)setupSubviews {
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailChangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMDetailChangeTableViewCell"];
    
    NSString *string = @"3万公里保养，共检查3个项目，更换8种零件！ 零件费：80000元   工时费：53626元";
    [self.descriptionPriceLab setAttributedNumberStringInContentString:string attributesDic:@{NSForegroundColorAttributeName:[UIColor blueColor], NSFontAttributeName:[UIFont systemFontOfSize:25]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMDetailChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMDetailChangeTableViewCell"];
    [cell layoutChangeTableViewCell];
    return cell;
}

#pragma mark - UITableViewDelegate


@end
