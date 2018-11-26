//
//  UIView+ZYQHollowMask.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZYQHollowMask)

/**
 设置镂空视图,如果视图的内容有更新，需要手动再调用setter方法
 @param hollowView 要设置的视图
 */
- (void)setHollowMaskView:(UIView *)hollowView;
/**
 获取镂空遮罩视图，用于动态修改遮罩的一些属性
 
 @return 遮罩视图
 */
- (UIView *)hollowMaskView;

@end

NS_ASSUME_NONNULL_END
