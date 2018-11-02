//
//  ZYQEmitterView.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , ZYQEmitterType) {
    ZYQRedPacketEmitterType,//红包雨
    ZYQSnowflakeEmitterType,//下雪
    ZYQRainEmitterType,//下雨
    ZYQBallEmitterType,//小球喷射效果
    ZYQLoveEmitterType,//爱心效果
    ZYQRibbonEmitterType,//彩带效果
    ZYQFireEmitterType//火焰效果
};

@interface ZYQEmitterView : UIView

/**
 创建粒子动画
 @param type 动画类
 @param superView 父视图
 */
- (void)createEmitterAnimation:(ZYQEmitterType)type
                     superView:(UIView *)superView;

/**
 开始动画效果
 */
- (void)startEmitterAnimation;
/**
 结束动画效果
 */
- (void)endEmitterAnimation;

/** 下雨模式 -雨越下越大 */
- (void)magnifyRain;
/** 下雨模式 -雨越下越小 */
- (void)minishRain;

/** 移动发射源到某个点上 */
- (void)setBallInPsition:(CGPoint)position;


/**
 * 设置火花的数量
 * ration: 比例系数 0 到 1之间
 */
- (void)setFireCount:(float)ratio;


@end

NS_ASSUME_NONNULL_END
