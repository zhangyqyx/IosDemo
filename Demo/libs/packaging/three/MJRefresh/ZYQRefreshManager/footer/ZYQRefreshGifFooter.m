//
//  ZYQRefreshGifFooter.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshGifFooter.h"

@implementation ZYQRefreshGifFooter
/** 初始化数据 */
- (void)prepare {
    [super prepare];
    self.ignoredScrollViewContentInsetBottom = 10;
    [self setImages:@[[UIImage imageNamed:@"refresh6"]] forState:MJRefreshStateIdle];
    [self setImages:[self getRefreshImages] forState:MJRefreshStatePulling];
    [self setImages:[self getRefreshImages] forState:MJRefreshStateRefreshing];
}
- (NSArray *)getRefreshImages{
    NSMutableArray * images = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d" , i]];
        [images addObject:image];
    }
    return images;
}


@end
