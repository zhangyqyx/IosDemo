//
//  ZYQHealthKitController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHealthKitController.h"
#import "ZYQHealthKitDetailController.h"

@interface ZYQHealthKitController ()<UITableViewDelegate , UITableViewDataSource>

/**数据列表 */
@property (nonatomic , strong)NSArray *list;

@end

@implementation ZYQHealthKitController

- (NSArray *)list {
    if (!_list) {
        _list = @[@"ZYQQuantityTypeStep",
                  @"ZYQQuantityTypeWalking",
                  @"ZYQQuantityTypeCycling",
                  @"ZYQQuantityTypeSwimming",
                  @"ZYQQuantityTypeHeight",
                  @"ZYQQuantityTypeBodyMass",
                  @"ZYQQuantityTypeActiveEnergyBurned",
                  @"ZYQQuantityTypeBasalEnergyBurned",
                  @"ZYQQuantityTypeBloodGlucose",
                  @"ZYQQuantityTypeBloodPressureSystolic",
                  @"ZYQQuantityTypeBloodPressureDiastolic"];
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setupUI];


}
#pragma mark - 设置UI
- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 50;
    tableView.frame = self.view.frame;
    [self.view addSubview:tableView];
}

#pragma mark --UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.list[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQHealthKitDetailController *nextVc = [[ZYQHealthKitDetailController alloc] init];
    nextVc.type = self.list[indexPath.row];
    [self.navigationController pushViewController:nextVc animated:YES];
}


@end
