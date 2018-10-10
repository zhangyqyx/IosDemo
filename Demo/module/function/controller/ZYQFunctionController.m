//
//  ZYQFunctionController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFunctionController.h"
#import "ZYQFunctionCell.h"
#import "ZYQFunctionModel.h"

@interface ZYQFunctionController ()<UITableViewDelegate , UITableViewDataSource>
/** UItableView */
@property(nonatomic , strong)UITableView *tableView;

/** 数据 */
@property(nonatomic , strong)NSArray *datas;


@end

@implementation ZYQFunctionController
#define kFunctionCell @"kFunctionCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self loadData];
    

}
#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"功能封装";
    UITableView *tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ZYQ_ScreenWidth, ZYQ_ScreenHeight - ZYQ_TopH) style:UITableViewStylePlain];
    tabelView.dataSource = self;
    tabelView.delegate = self;
    tabelView.backgroundColor = kViewLightBgColor;
    tabelView.tableFooterView = [UIView new];
    tabelView.showsVerticalScrollIndicator = false;
    tabelView.showsHorizontalScrollIndicator = false;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tabelView registerNib:[UINib nibWithNibName:@"ZYQFunctionCell" bundle:nil] forCellReuseIdentifier:kFunctionCell];
    [self.view addSubview:tabelView];
    self.tableView = tabelView;
    
}
#pragma mark - 加载数据
- (void)loadData  {
    self.datas = [ZYQFunctionModel loadData];
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:kFunctionCell forIndexPath:indexPath];
    cell.backgroundColor = kNavColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZYQFunctionModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQFunctionModel *model = self.datas[indexPath.row];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}




@end
