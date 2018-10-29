//
//  ZYQAnimationController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAnimationController.h"
#import "ZYQAnimationModel.h"

@interface ZYQAnimationController ()<UITableViewDelegate , UITableViewDataSource>
/** 数据源 */
@property(nonatomic , strong)NSArray *datas;
/** tableView */
@property(nonatomic , strong)UITableView *tableView;


@end

@implementation ZYQAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}
#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"动画效果";
    [self setupTableView];
    
}
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
#pragma mark - 加载数据源
- (void)loadData {
    self.datas = [ZYQAnimationModel loadData];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    UILabel *accLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self getWidthAccordingText:[self getSymbol][indexPath.section] font:[UIFont systemFontOfSize:17] height:30], 30)];
    accLabel.textColor = [UIColor whiteColor];
    accLabel.text = [self getSymbol][indexPath.section];
    cell.accessoryView = accLabel;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZYQAnimationModel *model = self.datas[indexPath.section];
    cell.backgroundColor = kNavColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = model.introduction;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYQAnimationModel *model = self.datas[indexPath.section];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZYQ_ScreenWidth, 5)];
    return view;
}


- (NSArray *)getSymbol {
    return @[@"╭(╯^╰)╮",@":-(",@"o(TωT)o",@"(*T_T*)",@"(/□＼*)",@"(╥╯^╰╥)"
             ,@"(ಥ_ಥ)",@"T^T",@"(／_＼)",@"(つД｀)",@"O(∩_∩)O",@"(ﾟ▽ﾟ)/"
             ,@"(*≧∪≦)",@"(ﾟ▽ﾟ)/",@"(`Д´*)9",@"(￣.￣)",@"￣▽￣",@"(=0=)y"];
}

-(CGFloat)getWidthAccordingText:(NSString *)text
                                 font:(UIFont *)font
                               height:(CGFloat)height {
    CGSize size = CGSizeMake(1000, height);
    CGFloat width = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.width;
    //    CGSize titleSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, height)];
    return width;
}
@end
