//
//  ZYQAFNModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQAFNModel.h"

@implementation ZYQAFNModel

+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQAFNModel *model = [[ZYQAFNModel alloc] init];
        model.title = dic[@"title"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}

+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"GET请求数据"},
                      @{@"title":@"POST请求数据"},
                      @{@"title":@"DELETE请求数据"},
                      @{@"title":@"PATCH请求数据"},
                      @{@"title":@"PUT请求数据"}];
    return data;
}

@end
