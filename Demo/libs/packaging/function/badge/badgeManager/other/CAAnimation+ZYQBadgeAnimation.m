//
//  CAAnimation+ZYQBadgeAnimation.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "CAAnimation+ZYQBadgeAnimation.h"
#import <UIKit/UIKit.h>

@implementation CAAnimation (ZYQBadgeAnimation)

+(CABasicAnimation *)ZYQ_opacityForever_Animation:(float)time {
    
    CABasicAnimation *animation     = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue            = [NSNumber numberWithFloat:1.0];
    animation.toValue              = [NSNumber numberWithFloat:0.1];
    animation.autoreverses           = YES;
    animation.duration              = time;
    animation.repeatCount           = FLT_MAX;
    animation.removedOnCompletion    = NO;
    animation.timingFunction         = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode              = kCAFillModeForwards;
    return animation;
    
}

+(CABasicAnimation *)ZYQ_opacityRepeatCount_Animation:(float)repeatCount
                                            durTimes:(float)time {
    CABasicAnimation *animation     = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue            = [NSNumber numberWithFloat:1.0];
    animation.toValue              = [NSNumber numberWithFloat:0.4];
    animation.repeatCount           = repeatCount;
    animation.duration              = time;
    animation.removedOnCompletion    = NO;
    animation.fillMode              = kCAFillModeForwards;
    animation.timingFunction         = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation.autoreverses           = YES;
    return  animation;
}

+(CABasicAnimation *)ZYQ_rotation:(float)dur
                          degree:(float)degree
                       direction:(ZYQAxis)axis
                     repeatCount:(int)repeatCount {
    
    CABasicAnimation* animation;
    NSArray *axisArr           = @[@"transform.rotation.x", @"transform.rotation.y", @"transform.rotation.z"];
    animation                 = [CABasicAnimation animationWithKeyPath:axisArr[axis]];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:degree];
    animation.duration           = dur;
    animation.autoreverses        = NO;
    animation.cumulative         = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode           = kCAFillModeForwards;
    animation.repeatCount        = repeatCount;
    return animation;
}

+(CABasicAnimation *)ZYQ_scaleFrom:(CGFloat)fromScale
                          toScale:(CGFloat)toScale
                         durTimes:(float)time
                      repeatCount:(float)repeatCount {
    CABasicAnimation *animation      = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue             = @(fromScale);
    animation.toValue               = @(toScale);
    animation.duration              = time;
    animation.autoreverses            = YES;
    animation.repeatCount         = repeatCount;
    animation.removedOnCompletion    = NO;
    animation.fillMode              = kCAFillModeForwards;
    return animation;
    
    
}

+(CAKeyframeAnimation *)ZYQ_shake_AnimationRepeatCount:(float)repeatCount
                                             durTimes:(float)time
                                               forObj:(id)obj {
    NSAssert([obj isKindOfClass:[CALayer class]] , @"invalid target");
    CGPoint originPos = CGPointZero;
    CGSize originSize = CGSizeZero;
    if ([obj isKindOfClass:[CALayer class]]) {
        originPos    = [(CALayer *)obj position];
        originSize   = [(CALayer *)obj bounds].size;
    }
    CGFloat hOffset   = originSize.width / 4;
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animation];
    anim.keyPath      = @"position";
    anim.values       = @[
                      [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                      [NSValue valueWithCGPoint:CGPointMake(originPos.x-hOffset, originPos.y)],
                      [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                      [NSValue valueWithCGPoint:CGPointMake(originPos.x+hOffset, originPos.y)],
                      [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)]
                      ];
    anim.repeatCount   = repeatCount;
    anim.duration     = time;
    anim.fillMode     = kCAFillModeForwards;
    return anim;
}


+(CAKeyframeAnimation *)ZYQ_bounce_AnimationRepeatCount:(float)repeatCount
                                              durTimes:(float)time
                                                forObj:(id)obj {
    NSAssert([obj isKindOfClass:[CALayer class]] , @"invalid target");
    CGPoint originPos   = CGPointZero;
    CGSize originSize   = CGSizeZero;
    if ([obj isKindOfClass:[CALayer class]]) {
        originPos      = [(CALayer *)obj position];
        originSize     = [(CALayer *)obj bounds].size;
    }
    CGFloat hOffset     = originSize.height / 4;
    CAKeyframeAnimation* anim = [CAKeyframeAnimation animation];
    anim.keyPath        = @"position";
    anim.values         = @[
                          [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                          [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y-hOffset)],
                          [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)],
                          [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y+hOffset)],
                          [NSValue valueWithCGPoint:CGPointMake(originPos.x, originPos.y)]
                          ];
    anim.repeatCount    = repeatCount;
    anim.duration      = time;
    anim.fillMode      = kCAFillModeForwards;
    return anim;
}




@end
