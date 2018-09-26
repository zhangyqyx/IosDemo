//
//  ZYQMusicAnimation.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQMusicAnimation.h"



@interface ZYQMusicAnimation ()

@property CALayer *barLayer;

@end

@implementation ZYQMusicAnimation
- (void)configAnimationAtLayer:(CALayer *)layer{
    CGSize size = layer.bounds.size;
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, size.width, size.height);
    replicatorLayer.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    replicatorLayer.instanceCount = 9;
    replicatorLayer.instanceDelay = 0.1;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(size.width*1/5, 0.f, 0.f);
    replicatorLayer.masksToBounds = YES;
    [self addMusicBarAnimationLayerAtLayer:replicatorLayer withSize:size];
     [layer addSublayer:replicatorLayer];
 
}

- (void)addMusicBarAnimationLayerAtLayer:(CALayer *)layer withSize:(CGSize)size {
    CGFloat width = size.width/9;
    CGFloat height = size.height;
    self.barLayer = [CALayer layer];
    self.barLayer.bounds = CGRectMake(0, 0, width, height);
    self.barLayer.position = CGPointMake(width, size.height);
    self.barLayer.cornerRadius = 5.0f;
    self.barLayer.masksToBounds = YES;
    self.barLayer.backgroundColor = [self ZYQ_colorWithHex:0x236dad].CGColor;
    CABasicAnimation *animationY = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animationY.fromValue = @(self.barLayer.position.y);
    animationY.toValue = @(self.barLayer.position.y - self.barLayer.bounds.size.height/2 + 5);
    CABasicAnimation *animationColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animationColor.fromValue = (__bridge id _Nullable)([self ZYQ_colorWithHex:0x236dad].CGColor);
    animationColor.toValue =  (__bridge id _Nullable)([self ZYQ_colorWithHex:0x3396ff].CGColor);
    CAAnimationGroup * animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[animationY, animationColor];
    animationGroup.duration = 0.5;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = CGFLOAT_MAX;
    [self.barLayer addAnimation:animationGroup forKey:@"animation"];
    
    [layer addSublayer:self.barLayer];
}

- (void)removeAnimation{
    [self.barLayer removeAnimationForKey:@"animation"];
}

- (UIColor *)ZYQ_colorWithHex:(u_int32_t)hex {
    u_int8_t red        = (hex & 0xFF0000) >> 16;
    u_int8_t green      = (hex & 0x00FF00) >> 8;
    u_int8_t blue       = hex & 0x0000FF;
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
}

@end
