//
//  ZYQAnimationModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAnimationModel.h"

@implementation ZYQAnimationModel


+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQAnimationModel *model = [[ZYQAnimationModel alloc] init];
        model.title = dic[@"title"];
        model.introduction = dic[@"introduction"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}
+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"QQ粘贴效果动画",@"introduction":@"类似QQ消息粘贴的效果", @"nextVc":@"ZYQViscousBadgeController"},
                      @{@"title":@"转场动画",@"introduction":@"页面之间跳转的一些动画效果", @"nextVc":@"ZYQTransitionsController"}];
    return data;
}


@end
