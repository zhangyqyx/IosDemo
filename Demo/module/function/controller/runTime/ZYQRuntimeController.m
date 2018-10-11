//
//  ZYQRuntimeController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRuntimeController.h"
#import "ZYQRuntimeManager.h"
#import "ZYQIvarAndMethodViewController.h"
#import "ZYQExchangeViewController.h"
#import "ZYQDictChangeModelViewController.h"
#import "ZYQArchiveViewController.h"

@interface ZYQRuntimeController ()<UITableViewDelegate , UITableViewDataSource>

/**列表数据 */
@property (nonatomic , strong)NSArray *dataList;

@end

@implementation ZYQRuntimeController

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = @[@"获取所有属性名" ,@"获得所有方法名",@"交换两个方法或取代某个方法",@"字典转模型",@"归档解档"];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
}


#pragma mark --UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *str = self.dataList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"runtime --- %@" , str];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:  case 1:
        {
            ZYQIvarAndMethodViewController *vc = [[ZYQIvarAndMethodViewController  alloc] init];
            vc.titleName = self.dataList[indexPath.row];
            vc.type = (int)indexPath.row + 1;
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
        case 2:  
        {
            ZYQExchangeViewController *vc = [[ZYQExchangeViewController alloc] init];
            vc.titleName = self.dataList[indexPath.row];
            vc.type = (int)indexPath.row - 1;
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            ZYQDictChangeModelViewController *vc = [[ZYQDictChangeModelViewController alloc] init];
            vc.titleName = self.dataList[indexPath.row];
            [self.navigationController  pushViewController:vc animated:YES];
        }   break;
        case 4:
        {
            ZYQArchiveViewController *vc = [[ZYQArchiveViewController alloc] init];
            vc.titleName = self.dataList[indexPath.row];
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end
