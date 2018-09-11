//
//  ZYQCategoryViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCategoryViewController.h"
#import "ZYQCategoryModel.h"
#import "ZYQCategoryCell.h"

@interface ZYQCategoryViewController ()<UITableViewDelegate , UITableViewDataSource>
/** tabelView */
@property(nonatomic , strong)UITableView *tableView;
/** 数据 */
@property(nonatomic , strong)NSArray *dataSource;



@end

@implementation ZYQCategoryViewController

#define kCategoryCell @"kCategoryCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
}
#pragma mark - 设置UI
- (void)setupUI {
   self.navigationItem.title = @"分类";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerNib:[UINib nibWithNibName:@"ZYQCategoryCell" bundle:nil] forCellReuseIdentifier:kCategoryCell];
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQCategoryModel loadData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategoryCell forIndexPath:indexPath];
    UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
    backgroundViews.backgroundColor = [UIColor ZYQ_randomColor];
    [cell setSelectedBackgroundView:backgroundViews];
    cell.backgroundColor = kNavColor;
    ZYQCategoryModel *model = self.dataSource[indexPath.row];
    cell.titleLabel.text = model.titleName;
    cell.introductionLabel.text = model.introduction;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQCategoryModel *model = self.dataSource[indexPath.row];
    Class  class = NSClassFromString(model.pushVc);
    UIViewController *vc = [[class alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - 解决分割线缺20的问题
- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}



@end
