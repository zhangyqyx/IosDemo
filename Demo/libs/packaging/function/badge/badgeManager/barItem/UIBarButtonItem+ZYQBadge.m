//
//  UIBarButtonItem+ZYQBadge.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIBarButtonItem+ZYQBadge.h"
#import <objc/runtime.h>

#define kActualView     [self getActualBadgeSuperView]
#define kZYQBadgeAfterTime      0.02

@implementation UIBarButtonItem (ZYQBadge)

#pragma mark -- public methods


- (void)ZYQ_showBadge
{
    [kActualView ZYQ_showBadge];
}


- (void)ZYQ_showBadgeWithStyle:(ZYQBadgeStyle)style
                     value:(NSInteger)value
             animationType:(ZYQBadgeAnimType)aniType
{
    [kActualView ZYQ_showBadgeWithStyle:style value:value animationType:aniType];
}


- (void)ZYQ_clearBadge
{
    [kActualView ZYQ_clearBadge];
}



#pragma mark -- private method


- (UIView *)getActualBadgeSuperView
{
    return [self valueForKeyPath:@"_view"];
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
