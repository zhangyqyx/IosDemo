//
//  ZYQRefreshDetailController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshDetailController.h"
#import "ZYQRefreshNormalHeader.h"
#import "ZYQRefreshGifHeader.h"
#import "ZYQRefreshCustomTitleHeader.h"
#import "ZYQRefreshCustomHeader.h"

#import "ZYQRefreshNormalFooter.h"
#import "ZYQRefreshGifFooter.h"
#import "ZYQRefreshCustomTitleFooter.h"
#import "ZYQRefreshCustomFooter.h"
#import "ZYQRefreshCustomBackFooter.h"

#import "UIViewController+Example.h"

@interface ZYQRefreshDetailController ()<UITableViewDelegate,UITableViewDataSource>
/** 数据 */
@property (nonatomic , strong)NSMutableArray *datas;
/** tableView */
@property(nonatomic , strong)UITableView *tableView;

@end

@implementation ZYQRefreshDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadDatas];
}
#pragma mark - 初始化数据
- (void)loadDatas {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"上下拉加载";
    self.datas = [NSMutableArray array];
    MJPerformSelectorLeakWarning(
                                 [self performSelector:NSSelectorFromString(self.method) withObject:nil];
                                 );
}
- (void)createUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - ZYQ_TopH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
}

#pragma mark - 下拉刷新
- (void)example01 {
    self.tableView.mj_header = [ZYQRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example02 {
    self.tableView.mj_header = [ZYQRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example03 {
    ZYQRefreshGifHeader *header = [ZYQRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}
- (void)example04 {
    self.tableView.mj_header = [ZYQRefreshCustomTitleHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example05 {
    self.tableView.mj_header = [ZYQRefreshCustomHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 上拉加载
- (void)example06 {
    [self example01];
    self.tableView.mj_footer = [ZYQRefreshNormalFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)example07 {
    [self example01];
    self.tableView.mj_footer = [ZYQRefreshGifFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example08 {
    [self example01];
    ZYQRefreshGifFooter *footGif = [ZYQRefreshGifFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footGif.refreshingTitleHidden = YES;
    
    self.tableView.mj_footer = footGif;
    [self.tableView.mj_header beginRefreshing];
}
- (void)example09 {
    [self example01];
    self.tableView.mj_footer = [ZYQRefreshCustomTitleFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example10 {
    [self example01];
    self.tableView.mj_footer = [ZYQRefreshCustomFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)example11 {
    [self example01];
    self.tableView.mj_footer = [ZYQRefreshCustomBackFooter  footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.mj_header beginRefreshing];
}



#pragma mark 只加载一次数据
- (void)loadNewData{
    [self.datas removeAllObjects];
    // 1.添加假数据
    for (int i = 0; i<10; i++) {
        NSString *str = [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)];
        [self.datas insertObject:str atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableView.mj_header endRefreshing];
    });
}
- (void)loadMoreData{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        NSString *str = [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)];
        [self.datas insertObject:str atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    __weak UITableView *tableView = self.tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [tableView.mj_footer endRefreshing];
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %@", indexPath.row, self.datas[indexPath.row]];
    
    return cell;
}


@end
