//
//  ZYQTransitonAnimation.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ZYQTransitonAnimationType) {
    ZYQTransitonAnimationTypeShow = 0,
    ZYQTransitonAnimationTypeHide,
};

typedef NS_ENUM(NSInteger , ZYQAnimationType) {
    ZYQBgCircularAnimationType = 0,//带背景动画,默认
    ZYQCircularAnimationType,//不带背景动画
};

@interface ZYQTransitonAnimation : NSObject<UIViewControllerAnimatedTransitioning>

/** 转场方式 显示-隐藏 */
@property (nonatomic , assign)ZYQTransitonAnimationType transitonType;

/**转场动画的颜色 */
@property (nonatomic , strong , nullable)UIColor *transitonColor;

/** 转场动画类型 */
@property(nonatomic , assign)ZYQAnimationType animationType;



- (nonnull instancetype)initWithAnchorRect:(CGRect)anchorRect;
+ (nonnull instancetype)transitionWithRect:(CGRect)anchorRect;


@end
