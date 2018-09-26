//
//  ZYQProgressHUDController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQProgressHUDController.h"
#import "ZYQHUDProgressModel.h"

@interface ZYQProgressHUDController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;

/** 数据源 */
@property(nonatomic , strong)NSArray *dataSource;

@end

@implementation ZYQProgressHUDController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
    
}
#pragma mark - 设置UI
- (void)createUI {
    self.navigationItem.title = @"加载提示框";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-ZYQ_TopH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}
#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQHUDProgressModel loadData];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZYQHUDProgressModel *model = self.dataSource[section];
    return model.titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    UIView *backgroundViews = [[UIView alloc]initWithFrame:cell.frame];
    backgroundViews.backgroundColor = [UIColor ZYQ_randomColor];
    [cell setSelectedBackgroundView:backgroundViews];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = kNavColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ZYQHUDProgressModel *model = self.dataSource[indexPath.section];
    cell.textLabel.text = model.titles[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", model.vcClass, model.methods[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYQHUDProgressModel *model = self.dataSource[indexPath.section];
    UIViewController *vc = [[model.vcClass alloc] init];
    vc.title = model.titles[indexPath.row];
    [vc setValue:model.methods[indexPath.row] forKeyPath:@"method"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



@end
