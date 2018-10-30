//
//  ZYQSystemAnimationController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQSystemAnimationController.h"
#import "ZYQSystemAnimationNextController.h"
#import "ZYQNavController.h"

@interface ZYQSystemAnimationController ()<UITableViewDelegate , UITableViewDataSource>
/** 所有动画文字数组 */
@property (nonatomic , strong)NSArray *dataSources;

@end

@implementation ZYQSystemAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)setupUI {
    self.navigationItem.title = @"系统的y转场动画";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    self.dataSources = @[@"系统支持动画一",
                         @"系统支持动画二",
                         @"系统支持动画三",
                         @"系统支持动画四" ,
                         @"自定义动画一",
                         @"自定义动画二",
                         @"自定义动画三",
                         @"自定义动画四",
                         @"自定义动画五",
                         @"自定义动画六",
                         @"自定义动画七",
                         @"自定义动画八" ];
}

#pragma mark - 跳转动画
- (void)systemPresentWith:(UIModalTransitionStyle)style {
    ZYQNavController *nav = [[ZYQNavController alloc] initWithRootViewController:[ZYQSystemAnimationNextController new]];
    [nav setModalTransitionStyle:style];
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)customPresentWith:(NSString *)type {
    ZYQNavController *nav = [[ZYQNavController alloc] initWithRootViewController:[ZYQSystemAnimationNextController new]];
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = type;
    //可以改变subtype的类型
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSources[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            //默认方式，竖向上推
            [self systemPresentWith:UIModalTransitionStyleCoverVertical];
            break;
        case 1:
            //水平反转
            [self systemPresentWith:UIModalTransitionStyleFlipHorizontal];
            break;
        case 2:
            //隐出隐现
            [self systemPresentWith:UIModalTransitionStyleCrossDissolve];
            break;
        case 3:
            //翻页
            [self systemPresentWith:UIModalTransitionStylePartialCurl];
            break;
        case 4:
            //淡出
            [self customPresentWith:kCATransitionFade];
            break;
        case 5:
            //推出
            [self customPresentWith:kCATransitionPush];
            break;
        case 6:
            //向上翻一页
            [self customPresentWith:@"pageCurl"];
            break;
        case 7:
            //向下翻一页
            [self customPresentWith:@"pageUnCurl"];
            break;
        case 8:
            //滴水效果
            [self customPresentWith:@"rippleEffect"];
            break;
        case 9:
            //收缩效果，如一块布被抽走
            [self customPresentWith:@"suckEffect"];
            break;
        case 10:
            //立方体效果
            [self customPresentWith:@"cube"];
            break;
        case 11:
            //上下翻转效果
            [self customPresentWith:@"oglFlip"];
            break;
        default:
            break;
    }
}



@end
