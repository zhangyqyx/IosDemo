//
//  CAAnimation+ZYQBadgeAnimation.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, ZYQAxis){
    ZYQAxisX = 0,
    ZYQAxisY,
    ZYQAxisZ
};
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
@interface CAAnimation (ZYQBadgeAnimation)

/**
 若隐若现

 @param time 时间
 @return 动画
 */
+(CABasicAnimation *)ZYQ_opacityForever_Animation:(float)time;

/**
  若隐若现

 @param repeatCount 重复次数
 @param time 持续时间
 @return 动画
 */
+(CABasicAnimation *)ZYQ_opacityRepeatCount_Animation:(float)repeatCount
                                         durTimes:(float)time;

/**
 旋转

 @param dur 持续时间
 @param degree 弧度
 @param axis 轴
 @param repeatCount 重复次数
 @return 动画
 */
+(CABasicAnimation *)ZYQ_rotation:(float)dur
                       degree:(float)degree
                    direction:(ZYQAxis)axis
                  repeatCount:(int)repeatCount;

/**
 缩放

 @param fromScale 从多少
 @param toScale 到多少
 @param time 时间
 @param repeatCount 重复次数
 @return 动画
 */
+(CABasicAnimation *)ZYQ_scaleFrom:(CGFloat)fromScale
                       toScale:(CGFloat)toScale
                      durTimes:(float)time
                   repeatCount:(float)repeatCount;

/**
 摇动

 @param repeatCount 重复次数
 @param time 时间
 @param obj CALayer对象
 @return 动画
 */
+(CAKeyframeAnimation *)ZYQ_shake_AnimationRepeatCount:(float)repeatCount
                                          durTimes:(float)time
                                            forObj:(id)obj;

/**
 反弹
 @param repeatCount 重复次数
 @param time 时间
 @param obj CALayer对象
 @return 动画
 */
+(CAKeyframeAnimation *)ZYQ_bounce_AnimationRepeatCount:(float)repeatCount
                                           durTimes:(float)time
                                            forObj:(id)obj;

@end
