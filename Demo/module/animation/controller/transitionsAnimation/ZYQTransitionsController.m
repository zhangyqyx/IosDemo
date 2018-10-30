//
//  ZYQTransitionsController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQTransitionsController.h"
#import "ZYQTransitionModel.h"

@interface ZYQTransitionsController ()<UITableViewDelegate , UITableViewDataSource>
/** 数据源 */
@property(nonatomic , strong)NSArray *datas;
/** tableView */
@property(nonatomic , strong)UITableView *tableView;


@end

@implementation ZYQTransitionsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
}
#pragma mark - 设置UI
- (void)createUI {
    self.navigationItem.title = @"转场动画";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;

    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark - 加载数据
- (void)loadData {
    self.datas = [ZYQTransitionModel loadData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kNavColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    ZYQTransitionModel *model = self.datas[indexPath.section];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQTransitionModel *model = self.datas[indexPath.section];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:true];
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01)];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return footView;
}



@end
