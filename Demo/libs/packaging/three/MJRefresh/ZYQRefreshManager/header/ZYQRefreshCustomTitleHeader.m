//
//  ZYQCustomTitleHeader.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshCustomTitleHeader.h"

@implementation ZYQRefreshCustomTitleHeader

- (void)prepare {
    [super prepare];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开加载" forState:MJRefreshStatePulling];
    [self setTitle:@"下拉加载" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"下拉加载" forState:MJRefreshStateIdle];

    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
}

@end
