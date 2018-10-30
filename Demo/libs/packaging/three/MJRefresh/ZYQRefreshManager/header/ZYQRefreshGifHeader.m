//
//  ZYQRefreshGifHeader.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQRefreshGifHeader.h"

@implementation ZYQRefreshGifHeader
- (void)prepare {
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"松开加载" forState:MJRefreshStatePulling];
    [self setTitle:@"上拉加载" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"上拉加载" forState:MJRefreshStateIdle];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"ZYQRefreshManager.bundle/refresh6.png" ofType:nil]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    [self setImages:@[[UIImage imageWithData:data]] forState:MJRefreshStateIdle];
    [self setImages:[self getRefreshImages] forState:MJRefreshStatePulling];
    [self setImages:[self getRefreshImages] forState:MJRefreshStateRefreshing];
}
- (NSArray *)getRefreshImages{
    NSMutableArray * images = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"ZYQRefreshManager.bundle/refresh%d.png", i] ofType:nil]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        [images addObject:image];
    }
    return images;
}


@end
