//
//  ZYQRefreshCustomHeader.m
//  封装
//
//  Created by 张睿 on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ZYQRefreshCustomHeader.h"

@interface ZYQRefreshCustomHeader()
/** 标题 */
@property (nonatomic , strong)UILabel *titleLabel;
/** 图片 */
@property (nonatomic , strong)UIImageView *logo;
/** 加载器 */
@property (nonatomic, strong) UIActivityIndicatorView *loading;

@end
@implementation ZYQRefreshCustomHeader
- (void)prepare {
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.titleLabel = label;
    
    
    // logo
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ZYQRefreshManager" ofType:@"bundle"];
    NSString *image_path = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"logo.png" ofType:nil];
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:image_path]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.logo = logo;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    self.titleLabel.frame = CGRectMake(self.mj_w * 0.5 - 50, self.mj_h - 21, self.mj_w - self.mj_w * 0.5 - 50, 21);
    self.loading.center = CGPointMake(self.titleLabel.mj_x - 50, self.mj_h * 0.5);
    self.logo.frame = CGRectMake(self.titleLabel.mj_x, 0, 30, 30);
    
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.titleLabel.text = @"赶紧下拉";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.titleLabel.text = @"放开我吧";
            break;
        case MJRefreshStateRefreshing:
            self.titleLabel.text = @"我在努力的加载";
            [self.loading startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    // 1.0 0.5 0.0
    // 0.5 0.0 0.5
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.titleLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
