//
//  ZYQOtherModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQOtherModel.h"

@implementation ZYQOtherModel

+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQOtherModel *model = [[ZYQOtherModel alloc] init];
        model.title = dic[@"title"];
        model.imageStr = dic[@"imageStr"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}

+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"分类",@"imageStr":@"" , @"nextVc":@"ZYQCategoryViewController"},
  @{@"title":@"分类",@"imageStr":@"" , @"nextVc":@"ZYQCategoryViewController"},
  @{@"title":@"分类",@"imageStr":@"" , @"nextVc":@"ZYQCategoryViewController"}];
    return data;
}

@end
