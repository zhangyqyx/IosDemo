//
//  ZYQEncryptionAndDecryptionController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQEncryptionAndDecryptionController.h"

@interface ZYQEncryptionAndDecryptionController ()<UITableViewDelegate , UITableViewDataSource>
/**功能选项 */
@property (nonatomic , strong)NSArray *list;

@end

@implementation ZYQEncryptionAndDecryptionController


- (NSArray *)list {
    if (!_list) {
        _list = @[
                  @{@"name":@"HASH加密",@"VC":@"ZYQHASHController"},
                  @{@"name":@"DES加密",@"VC":@"ZYQDESController"},
                  @{@"name":@"AES加密",@"VC":@"ZYQAESController"},
                  @{@"name":@"BASE64加密",@"VC":@"ZYQBASE64Controller"},
                  @{@"name":@"RSA加密",@"VC":@"ZYQRSAController"}];
    }
    return _list;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
}
#pragma mark -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = self.list[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.textLabel.numberOfLines = 0;
    if (indexPath.row == 0) {
        cell.accessoryType  = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *VcStr = self.list[indexPath.row][@"VC"];
    Class Vc =  NSClassFromString(VcStr);
    UIViewController *vc = [[Vc alloc] init];
    vc.navigationItem.title = self.list[indexPath.row][@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



@end
