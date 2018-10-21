//
//  ZYQFunctionModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFunctionModel.h"

@implementation ZYQFunctionModel

+ (NSArray *)loadData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQFunctionModel *model = [[ZYQFunctionModel alloc] init];
        model.title = dic[@"title"];
        model.introduction = dic[@"introduction"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}
+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"红点提醒功能",@"introduction":@"有关于项目中用到的红点操作", @"nextVc":@"ZYQBadgeController"},
                      @{@"title":@"健康数据健康",@"introduction":@"有关苹果的healthKit功能的使用", @"nextVc":@"ZYQHealthKitController"},
                      @{@"title":@"Runtime",@"introduction":@"有关Runtime的一些使用", @"nextVc":@"ZYQRuntimeController"},
                      @{@"title":@"加密解密",@"introduction":@"有关基本的一些加密、解密技术的使用，涉及到HASH、DES、AES、BASE64 、RSA", @"nextVc":@"ZYQEncryptionAndDecryptionController"}];
    return data;
}

@end
