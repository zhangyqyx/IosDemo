//
//  ZYQEmitterAnimationController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQEmitterAnimationController.h"
#import "ZYQEmitterView.h"
#import "ZYQEmitterShowController.h"

@interface ZYQEmitterAnimationController ()<UITableViewDelegate , UITableViewDataSource>
/** tableView */
@property(nonatomic , strong)UITableView *tableView;
/** 数据源 */
@property(nonatomic , strong)NSArray *datas;


@end

@implementation ZYQEmitterAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"粒子动画";
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height  - ZYQ_TopH) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark - 加载数据
- (void)loadData {
    self.datas = @[@{@"title":@"红包雨动画",@"type":@"RedPacket",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"下雪动画",@"type":@"Snowflake",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"下雨动画",@"type":@"rain",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"小球喷射效果",@"type":@"ball",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"心型发射效果",@"type":@"love",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"彩带效果",@"type":@"rinnon",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"火焰效果",@"type":@"fire",@"nextVc":@"ZYQEmitterShowController"},
                   @{@"title":@"按钮点赞效果",@"type":@"btn",@"nextVc":@"ZYQEmitterBtnController"}];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.datas[indexPath.section];
    cell.textLabel.text = dic[@"title"];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.datas[indexPath.section];
    Class class = NSClassFromString(dic[@"nextVc"]);
    UIViewController *vc = [[class alloc] init];
    if ([vc isKindOfClass:NSClassFromString(@"ZYQEmitterShowController")]) {
        ZYQEmitterShowController *showVc = (ZYQEmitterShowController*)vc;
        showVc.type = dic[@"type"];
        [self.navigationController pushViewController:showVc animated:true];
        return;
    }
   
    [self.navigationController pushViewController:vc animated:true];
    
}


@end
