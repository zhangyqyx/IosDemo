//
//  UITabBarItem+ZYQBadge.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UITabBarItem+ZYQBadge.h"

#define kActualView     [self getActualBadgeSuperView]
#define kZYQBadgeAfterTime      0.02
@implementation UITabBarItem (ZYQBadge)

#pragma mark -- public methods

- (void)ZYQ_showBadge
{
  
    [kActualView ZYQ_showBadge];
}


- (void)ZYQ_showBadgeWithStyle:(ZYQBadgeStyle)style
                     value:(NSInteger)value
             animationType:(ZYQBadgeAnimType)aniType{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZYQBadgeAfterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [kActualView ZYQ_showBadgeWithStyle:style value:value animationType:aniType];
    });
   
}

- (void)ZYQ_clearBadge
{
    [kActualView ZYQ_clearBadge];
}

#pragma mark -- 获取视图

- (UIView *)getActualBadgeSuperView
{
    UIView *bottomView = [self valueForKeyPath:@"_view"];
    
    UIView *actualSuperView = nil;
    if (bottomView) {
        actualSuperView = [self find:bottomView firstSubviewWithClass:NSClassFromString(@"UITabBarSwappableImageView")];
    }
    
    return actualSuperView;
}

- (UIView *)find:(UIView *)view firstSubviewWithClass:(Class)cls
{
    __block UIView *targetView = nil;
    [view.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subview isKindOfClass:cls]) {
            targetView = subview;
            *stop = YES;
        }
    }];
    return targetView;
}

#pragma mark -- setter/getter
- (UILabel *)badge
{
    return kActualView.badge;
}

- (void)setBadge:(UILabel *)label
{
    [kActualView setBadge:label];
}

- (UIFont *)badgeFont
{
	return kActualView.badgeFont;
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
	[kActualView setBadgeFont:badgeFont];
}

- (UIColor *)badgeBgColor
{
    return [kActualView badgeBgColor];
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor
{
    [kActualView setBadgeBgColor:badgeBgColor];
}

- (UIColor *)badgeTextColor
{
    return [kActualView badgeTextColor];
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    [kActualView setBadgeTextColor:badgeTextColor];
}

- (ZYQBadgeAnimType)aniType
{
    return [kActualView aniType];
}

- (void)setAniType:(ZYQBadgeAnimType)aniType
{
    [kActualView setAniType:aniType];
}

- (CGRect)badgeFrame
{
    return [kActualView badgeFrame];
}

- (void)setBadgeFrame:(CGRect)badgeFrame
{
    [kActualView setBadgeFrame:badgeFrame];
}

- (CGPoint)badgeCenterOffset
{
    return [kActualView badgeCenterOffset];
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOffset
{
    [kActualView setBadgeCenterOffset:badgeCenterOffset];
}

- (NSInteger)badgeMaximumBadgeNumber
{
    return [kActualView badgeMaximumBadgeNumber];
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber
{
    [kActualView setBadgeMaximumBadgeNumber:badgeMaximumBadgeNumber];
}

@end
