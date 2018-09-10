//
//  ZYQCategoryModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCategoryModel.h"

@implementation ZYQCategoryModel

+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQCategoryModel *model = [[ZYQCategoryModel alloc] init];
        model.titleName = dic[@"titleName"];
        model.pushVc = dic[@"pushVc"];
        model.introduction = dic[@"introduction"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
    
}
+ (NSArray *)createData {
    NSArray *data = @[@{@"titleName":@"视图",@"introduction":@"视图快速获取frame",@"pushVc":@"ZYQImageViewController"},
                      @{@"titleName":@"图片",@"introduction":@"有关图片的一些操作",@"pushVc":@"ZYQImageViewController"},
                      @{@"titleName":@"有关图片的一些操作",@"introduction":@"有关图片的一些操作",@"pushVc":@"关于项目中的分类"},
                      @{@"titleName":@"有关图片的一些操作",@"introduction":@"有关图片的一些操作",@"pushVc":@"关于项目中的分类"}];
    return data;
}


@end
