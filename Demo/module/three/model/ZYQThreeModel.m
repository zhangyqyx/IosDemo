//
//  ZYQThreeModel.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQThreeModel.h"

@implementation ZYQThreeModel
+ (NSArray *)loadThreeData {
    NSMutableArray *mutArr = [NSMutableArray array];
    for (NSDictionary *dic in [self createData]) {
        ZYQThreeModel *model = [[ZYQThreeModel alloc] init];
        model.title = dic[@"title"];
        model.introduction = dic[@"introduction"];
        model.nextVc = dic[@"nextVc"];
        [mutArr addObject:model];
    }
    
    return [mutArr copy];
}

+ (NSArray *)createData {
    NSArray *data = @[@{@"title":@"AFNetworking",@"introduction":@" AFNetworking是一个在IOS开发中使用非常多网络开源库,适用于iOS以及Mac OS X. 它构建于(apple iOS开发文档)NSURLSection,以及其他熟悉的Foundation技术之上。它拥有良好的架构,丰富的API,以及模块化构建方式,使得使用起来非常轻松.地址:https://github.com/AFNetworking/AFNetworking", @"nextVc":@"ZYQAFNController"},
                      @{@"title":@"MJRefresh",@"introduction":@"MJRefresh我们在项目中常用的一款开发辅助工具，里面包括有下拉刷新，上拉加载更多数据，一般在tableView,UICollectionView,UIWebView上面使用，关于下拉刷新和上拉加载的样式也是有很多，我们也可以自己定义样式，使用起来方便快捷.地址:https://github.com/CoderMJLee/MJRefresh", @"nextVc":@"ZYQRefreshController"},
                      @{@"title":@"工具",@"introduction":@"项目中用到的工具类", @"nextVc":@""},
                      @{@"title":@"动画",@"introduction":@"有关一些视图等动画效果", @"nextVc":@""},
                      @{@"title":@"文章总结",@"introduction":@"经典的文章和博客", @"nextVc":@""},
                      @{@"title":@"其他",@"introduction":@"其他方面的",@"image":@""},
                      @{@"title":@"完整项目",@"introduction":@"比较完整的项目", @"nextVc":@""}];
    return data;
}
@end
