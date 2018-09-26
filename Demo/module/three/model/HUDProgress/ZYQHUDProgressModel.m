//
//  ZYQHUDProgressModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHUDProgressModel.h"

@implementation ZYQHUDProgressModel
+ (NSArray *)loadData {
    ZYQHUDProgressModel *model = [[ZYQHUDProgressModel alloc] init];
    model.header = @"加载视图";
    model.vcClass = [NSClassFromString(@"ZYQProgressHUDDetailController") class];
    model.titles = @[@"全局的透明背景的加载框，不自动消失",
                     @"全局文本和图片提示框，自动消失",
                     @"全局文本提示框，自动消失",
                     @"有透明背景的加载框,不自动消失",
                     @"文字加载框，不自动消失",
                     @"文本提示框,自动消失",
                     @"图片、文字的提示框,自动消失",
                     @"全局文字加载框，不自动消失",
                     @"加一个断网提示的视图",
                     @"加一个空白页加载的视图",
                     @"加一个gif加载的视图"];
    model.methods = @[@"example01",
                      @"example02",
                      @"example03",
                      @"example04",
                      @"example05",
                      @"example06",
                      @"example07",
                      @"example08",
                      @"example09",
                      @"example10",
                      @"example11"];
    return  @[model];
}
@end
