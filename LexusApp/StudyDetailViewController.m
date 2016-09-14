//
//  StudyDetailViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/7.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "StudyDetailViewController.h"
#import "StudyListTableViewCell.h"
#import "StudyMainView.h"

@interface StudyDetailViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainScrollViewWidth1;
@property (weak, nonatomic) IBOutlet StudyMainView *studyMainView;

@property (weak, nonatomic) IBOutlet UIScrollView *listScrollView;
@property (weak, nonatomic) IBOutlet UILabel *listTitleLab;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) NSMutableArray *listDataArr;
@end

@implementation StudyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.studyMainView sutupSubviews];
    
    self.titleLab.text = @"学习平台";
    
    self.listDataArr = [[NSMutableArray alloc] init];
    
    [self.listTableView registerNib:[UINib nibWithNibName:@"StudyListTableViewCell" bundle:nil] forCellReuseIdentifier:@"StudyListTableViewCell"];
    
    for (NSInteger index = 0; index < 20; index++) {
        StudyListModel *model = [[StudyListModel alloc] init];
        model.numIconStr = @"study_num1";
        model.userNameStr = @"test";
        model.userIconStr = @"manIcon";
        
        [self.listDataArr addObject:model];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [UserManager shareUserManager].isLoginStudy = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mainScrollView setContentOffset:CGPointZero animated:NO];
    [self.listScrollView setContentOffset:CGPointZero animated:NO];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    self.mainScrollViewWidth1.constant = (CGRectGetWidth(self.view.bounds) - 335) * 3;
}

#pragma mark - IBAction
- (IBAction)onTapSelectedCarModelBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds), 0) animated:YES];
}

- (IBAction)onTapSelectedKmBtn:(id)sender {
    [self.mainScrollView setContentOffset:CGPointMake((CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.listScrollView.bounds)) * 2, 0) animated:YES];
}

- (IBAction)onTapListBtn:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.listTitleLab.text = btn.titleLabel.text;
    [self.listScrollView setContentOffset:CGPointMake(335, 0) animated:YES];
}

- (IBAction)onTapListBackBtn:(id)sender {
    [self.listScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StudyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudyListTableViewCell"];
    StudyListModel *model = [self.listDataArr objectAtIndex:indexPath.row];
    
    [cell layoutSubViewsByStudyListModel:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
