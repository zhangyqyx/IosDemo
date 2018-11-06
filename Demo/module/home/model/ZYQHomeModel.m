//
//  ZYQHomeModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/8/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHomeModel.h"

@implementation ZYQHomeModel


+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQHomeModel *model = [[ZYQHomeModel alloc] init];
        model.title = dic[@"title"];
        model.introduction = dic[@"introduction"];
        model.image = dic[@"image"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}

+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"分类",@"introduction":@"关于项目中的分类",@"image":@"" , @"nextVc":@"ZYQCategoryViewController"},
                      @{@"title":@"三方",@"introduction":@"有关三方的封装和使用",@"image":@"", @"nextVc":@"ZYQThreeViewController"},
                      @{@"title":@"工具",@"introduction":@"项目中用到的工具类",@"image":@"", @"nextVc":@"ZYQToolController"},
                      @{@"title":@"功能",@"introduction":@"有关功能的封装",@"image":@"",@"nextVc":@"ZYQFunctionController"},
                       @{@"title":@"动画",@"introduction":@"有关一些视图等动画效果",@"image":@"", @"nextVc":@"ZYQAnimationController"},
                      @{@"title":@"文章总结",@"introduction":@"经典的文章和博客",@"image":@"", @"nextVc":@""},
                      @{@"title":@"其他",@"introduction":@"其他方面的一些使用",@"image":@"", @"nextVc":@"ZYQOtherController"}];
    return data;
}




@end
