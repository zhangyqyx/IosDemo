//
//  ZYQRefreshCustomTitleFooter.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshCustomTitleFooter.h"

@implementation ZYQRefreshCustomTitleFooter
- (void)prepare {
    [super prepare];
    
    // 设置文字
    [self setTitle:@"下拉加载" forState:MJRefreshStateIdle];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开加载" forState:MJRefreshStatePulling];
    [self setTitle:@"下拉加载" forState:MJRefreshStateWillRefresh];
    // 设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    self.stateLabel.textColor = [UIColor blueColor];
    
    
}

@end
