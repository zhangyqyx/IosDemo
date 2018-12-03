//
//  ZYQTransitionModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQTransitionModel.h"

@implementation ZYQTransitionModel
+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQTransitionModel *model = [[ZYQTransitionModel alloc] init];
        model.title = dic[@"title"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}
+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"系统默认支持的一些转场动画", @"nextVc":@"ZYQSystemAnimationController"},
                      @{@"title":@"自定义的圆形转场动画", @"nextVc":@"ZYQCircularAnimationController"}];
    return data;
}
@end
