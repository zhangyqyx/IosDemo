//
//  ZYQWaterWaveView.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kBWaterWaveDefault = 0.6;

@interface ZYQWaterWaveView : UIView
/**
 设置颜色变化
 @param c1 开始的颜色
 @param c2 结束的颜色
 @param range 范围
 */
- (void)updateViewGradientFromColor:(UIColor*)c1
                            toColor:(UIColor*)c2
                          withRange:(int)range;
/**
 绘制波纹
 @param percent 比例 0-1
 */
- (void)drawWaterWavePath:(NSNumber *)percent;

/**
 显示波纹
 @param percent 比例 0-1
 */
- (void)showDripAnmin:(NSNumber *)percent;

@end

NS_ASSUME_NONNULL_END
