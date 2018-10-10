//
//  ZYQBadgeDeatilOneController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQBadgeDeatilOneController.h"
#import "UIView+ZYQBadge.h"

@interface ZYQBadgeDeatilOneController ()<UITableViewDelegate , UITableViewDataSource>
/** 显示数据 */
@property (nonatomic , strong)NSArray *datas;

@end

@implementation ZYQBadgeDeatilOneController

- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@[@"label上红点",@"button上红点",@"view上红点"],
                   @[@"样式1",@"样式2",@"样式3",@"样式4",@"样式5"]];
    }
    return _datas;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self createUI];
}
- (void)createUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.datas[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = self.datas[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self setupLabelBadgeWithCell:cell];
        }
        if (indexPath.row == 1) {
            [self setupButtonBadgeWithCell:cell];
        }
        if (indexPath.row == 2) {
            [self setupViewBadgeWithCell:cell];
        }
        return cell;
    }
    if (indexPath.row == 0) {
        [self setuplabelBadgeType1WithCell:cell];
    }
    if (indexPath.row == 1) {
        [self setuplabelBadgeType2WithCell:cell];
    }
    if (indexPath.row == 2) {
        [self setuplabelBadgeType3WithCell:cell];
    }
    if (indexPath.row == 3) {
        [self setuplabelBadgeType4WithCell:cell];
    }
    if (indexPath.row == 4) {
        [self setuplabelBadgeType5WithCell:cell];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"控件上的红点";
    }
    return @"红点样式";
}
-(CGFloat)tableView:(UITableView *)tableView heighZYQorRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark - 设置红点
//label上红点
- (void)setupLabelBadgeWithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"label红点";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showBadge];
    [cell addSubview:label];
    
}
//button上红点
- (void)setupButtonBadgeWithCell:(UITableViewCell *)cell {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(160, 10, 90, 21);
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"button红点" forState:UIControlStateNormal];
    [button ZYQ_showBadge];
    [cell addSubview:button];
}
//view上红点
- (void)setupViewBadgeWithCell:(UITableViewCell *)cell {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    view.backgroundColor = [UIColor redColor];
    view.badgeBgColor = [UIColor blueColor];
    [view ZYQ_showBadge];
    [cell addSubview:view];
}
//样式1
- (void)setuplabelBadgeType1WithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"样式1";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showNumberBadgeWithValue:10];
    [cell addSubview:label];
}
//样式2
- (void)setuplabelBadgeType2WithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"样式2";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showNumberBadgeWithValue:20 animationType:ZYQBadgeAnimTypeScale];
    [cell addSubview:label];
}
//样式3
- (void)setuplabelBadgeType3WithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"样式3";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showBadgeWithStyle:ZYQBadgeStyleNew value:1 animationType:ZYQBadgeAnimTypeNone];
    [cell addSubview:label];
}
//样式4
- (void)setuplabelBadgeType4WithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"样式4";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showBadgeWithStyle:ZYQBadgeStyleRedDot value:0 animationType:ZYQBadgeAnimTypeShake];
    [cell addSubview:label];
}
//样式4
- (void)setuplabelBadgeType5WithCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 90, 21)];
    label.text  =  @"样式5";
    label.backgroundColor = [UIColor lightGrayColor];
    [label ZYQ_showBadgeWithStyle:ZYQBadgeStyleNumber value:100 animationType:ZYQBadgeAnimTypeBounce];
    [cell addSubview:label];
}

@end
