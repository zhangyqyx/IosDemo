//
//  ZYQRefreshModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshModel.h"

@implementation ZYQRefreshModel
+ (NSArray *)loadData {
    ZYQRefreshModel *model = [[ZYQRefreshModel alloc] init];
    model.header = @"下拉刷新";
    model.vcClass = [NSClassFromString(@"ZYQRefreshDetailController") class];
    model.titles = @[@"默认",
                     @"动图",
                     @"隐藏控件",
                     @"自定义文字",
                     @"自定义视图",];
    model.methods = @[@"example01",
                      @"example02",
                      @"example03",
                      @"example04",
                      @"example05"];
    ZYQRefreshModel *model1 = [[ZYQRefreshModel alloc] init];
    model1.header = @"上拉加载";
    model1.vcClass = [NSClassFromString(@"ZYQRefreshDetailController") class];
    model1.titles = @[@"默认",
                      @"动图",
                      @"隐藏控件",
                      @"自定义文字并回弹",
                      @"自定义视图(不自动回弹)",
                      @"自定义视图(自动回弹)"];
    model1.methods = @[@"example06",
                       @"example07",
                       @"example08",
                       @"example09",
                       @"example10",
                       @"example11"];
    return @[model, model1];
}




@end
