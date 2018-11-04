//
//  ZYQSearchController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/2.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQSearchController.h"

@interface ZYQSearchController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic , strong)UITableView *tableView;

@end

@implementation ZYQSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.hideHotSearch = YES;
    self.searchInputFont = [UIFont systemFontOfSize:15];
    self.hotType = TFSearchHotStyleRoundTag;
    self.historyStyleType = TFSearchHistoryStyleColorfulTag;
//    self.hotArr = @[@"我" ,@"先这样",@"走这"];
    [self creatTableView];
    
    
    
}
-(void)TF_startSearchWithTitle:(NSString *)searchText {
    NSLog(@"searchText = %@" , searchText);
    //    if ([searchText isEqualToString:@""]) {
    //        _tableView.hidden = YES;
    //    }else {
    //        _tableView.hidden = NO;
    //    }
    //
}




- (void)TF_searchStrDidChange:(NSString *)searchText {
    NSLog(@"searchText = %@" , searchText);
    if ([searchText isEqualToString:@""]) {
        _tableView.hidden = YES;
    }else {
        _tableView.hidden = NO;
    }
}
- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ZYQ_TopH, self.view.frame.size.width, self.view.frame.size.height - ZYQ_TopH) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.hidden = YES;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
//    headerView.backgroundColor = [UIColor greenColor];
//    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第几行%ld" , indexPath.row];
    
    return cell;
}



@end
