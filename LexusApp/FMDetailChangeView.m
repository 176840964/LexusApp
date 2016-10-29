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

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet FMDetailChangeShowView *showView;

@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation FMDetailChangeView

- (void)setupSubviewsWithDataArr:(NSArray*)dataArr {
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailChangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMDetailChangeTableViewCell"];
    
    self.showView.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@ChangeDefulteBg", self.carNameStr]];
    
    self.dataArr = dataArr;
    [self.tableView reloadData];
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMDetailChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMDetailChangeTableViewCell"];
    
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    
    [cell layoutChangeTableViewCellWithDataDic:dic];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    
    NSString *thumbnailStr = [NSString stringWithFormat:@"change%@", [dic objectForKey:@"thumbnail"]];
    self.showView.imgView.image = [UIImage imageNamed:thumbnailStr];
}


@end
