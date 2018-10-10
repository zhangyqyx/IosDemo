//
//  UIView+ZYQBadge.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQBadgeProtocol.h"

@interface UIView (ZYQBadge)<ZYQBadgeProtocol>
/**
 显示红点
 */
- (void)ZYQ_showBadge;
/**
 显示红点
 
 @param style 类型
 @param value 值
 @param aniType 动画类型
 */
- (void)ZYQ_showBadgeWithStyle:(ZYQBadgeStyle)style
                        value:(NSInteger)value
                animationType:(ZYQBadgeAnimType)aniType;

/**
 显示红点

 @param value 值
 @param aniType 动画类型
 */
- (void)ZYQ_showNumberBadgeWithValue:(NSInteger)value
                   animationType:(ZYQBadgeAnimType)aniType;
/**
 显示红点

 @param value 值
 */
- (void)ZYQ_showNumberBadgeWithValue:(NSInteger)value;

/**
 清除红点
 */
- (void)ZYQ_clearBadge;

@end
