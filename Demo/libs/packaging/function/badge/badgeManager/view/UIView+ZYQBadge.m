//
//  UIView+ZYQBadge.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIView+ZYQBadge.h"
#import "CAAnimation+ZYQBadgeAnimation.h"
#import <objc/runtime.h>

#define kZYQBadgeDefaulZYQont                ([UIFont boldSystemFontOfSize:9])

#define kZYQBadgeDefaultMaximumBadgeNumber                     99
#define kZYQBadgeAfterTime      0.02

static const CGFloat kZYQBadgeDefaultRedDotRadius = 4.f;

@implementation UIView (ZYQBadge)

- (void)ZYQ_showBadge {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZYQBadgeAfterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self ZYQ_showBadgeWithStyle:ZYQBadgeStyleRedDot value:0 animationType:ZYQBadgeAnimTypeNone];
    });
    
}



- (void)ZYQ_showBadgeWithStyle:(ZYQBadgeStyle)style
                        value:(NSInteger)value
                animationType:(ZYQBadgeAnimType)aniType {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZYQBadgeAfterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.aniType = aniType;
        switch (style) {
            case ZYQBadgeStyleRedDot:
                [self ZYQ_showRedDotBadge];
                break;
            case ZYQBadgeStyleNumber:
                [self ZYQ_showNumberBadgeWithValue:value];
                break;
            case ZYQBadgeStyleNew:
                [self ZYQ_showNewBadge];
                break;
                
            default:
                break;
        }
        if (aniType != ZYQBadgeAnimTypeNone) {
            [self beginAnimation];
        }
    });
}

#pragma mark - 实现方法
- (void)ZYQ_showRedDotBadge {
    [self badgeInit];
    if (self.badge.tag != ZYQBadgeStyleRedDot) {
        self.badge.text = @"";
        self.badge.tag = ZYQBadgeStyleRedDot;
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
    }
     self.badge.hidden = NO;
    
}


- (void)ZYQ_showNewBadge {
    [self badgeInit];
    if (self.badge.tag != ZYQBadgeStyleNew) {
        self.badge.text = @"new";
        self.badge.tag = ZYQBadgeStyleNew;
        
        CGRect frame = self.badge.frame;
        frame.size.width = 22;
        frame.size.height = 13;
        self.badge.frame = frame;
        
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.font = kZYQBadgeDefaulZYQont;
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 3;
    }
    self.badge.hidden = NO;
}
- (void)ZYQ_showNumberBadgeWithValue:(NSInteger)value {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZYQBadgeAfterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (value < 0) {
            return;
        }
        [self badgeInit];
        self.badge.hidden = (value == 0);
        self.badge.tag = ZYQBadgeStyleNumber;
        self.badge.font = self.badgeFont;
        self.badge.text = (value > self.badgeMaximumBadgeNumber ?
                           [NSString stringWithFormat:@"%@+", @(self.badgeMaximumBadgeNumber)] :
                           [NSString stringWithFormat:@"%@", @(value)]);
        [self adjustLabelWidth:self.badge];
        CGRect frame = self.badge.frame;
        frame.size.width += 4;
        frame.size.height += 4;
        if(CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
            frame.size.width = CGRectGetHeight(frame);
        }
        self.badge.frame = frame;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
    });
}
- (void)ZYQ_showNumberBadgeWithValue:(NSInteger)value animationType:(ZYQBadgeAnimType)aniType {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kZYQBadgeAfterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.aniType = aniType;
        [self ZYQ_showNumberBadgeWithValue:value];
        if (aniType != ZYQBadgeAnimTypeNone) {
            [self beginAnimation];
        }
    });
}
- (void)ZYQ_clearBadge{
    self.badge.hidden = YES;
}
- (void)beginAnimation{
    switch(self.aniType) {
        case ZYQBadgeAnimTypeBreathe:
            
            [self.badge.layer addAnimation:[CAAnimation ZYQ_opacityForever_Animation:1.4]
                                    forKey:kBadgeBreatheAniKey];
            break;
        case ZYQBadgeAnimTypeShake:
            
            [self.badge.layer addAnimation:[CAAnimation ZYQ_shake_AnimationRepeatCount:CGFLOAT_MAX
                                                                             durTimes:1
                                                                               forObj:self.badge.layer]
                                    forKey:kBadgeShakeAniKey];
            break;
        case ZYQBadgeAnimTypeScale:
            
            [self.badge.layer addAnimation:[CAAnimation ZYQ_scaleFrom:1.4 toScale:0.6 durTimes:1 repeatCount:MAXFLOAT]
                                    forKey:kBadgeScaleAniKey];
            break;
        case ZYQBadgeAnimTypeBounce:
            
            [self.badge.layer addAnimation:[CAAnimation ZYQ_bounce_AnimationRepeatCount:CGFLOAT_MAX durTimes:1 forObj:self.badge.layer]
                                    forKey:kBadgeBounceAniKey];
            break;
        case ZYQBadgeAnimTypeNone:
        default:
            break;
    }
}


- (void)removeAnimation
{
    if (self.badge) {
        [self.badge.layer removeAllAnimations];
    }
}




- (void)badgeInit
{
    if (self.badgeBgColor == nil) {
        self.badgeBgColor = [UIColor redColor];
    }
    if (self.badgeTextColor == nil) {
        self.badgeTextColor = [UIColor whiteColor];
    }
    
    if (nil == self.badge) {
        CGFloat redotWidth = kZYQBadgeDefaultRedDotRadius * 2;
        CGRect frm = CGRectMake(CGRectGetWidth(self.frame), -redotWidth, redotWidth, redotWidth);
        self.badge = [[UILabel alloc] initWithFrame:frm];
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + self.badgeCenterOffset.x, self.badgeCenterOffset.y);
        self.badge.backgroundColor = self.badgeBgColor;
        self.badge.textColor = self.badgeTextColor;
        self.badge.text = @"";
        self.badge.tag = ZYQBadgeStyleRedDot;
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame) / 2;
        self.badge.layer.masksToBounds = YES;//very important
        self.badge.hidden = NO;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }
}
- (void)adjustLabelWidth:(UILabel *)label
{
    [label setNumberOfLines:0];
    NSString *s = label.text;
    UIFont *font = [label font];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize;
    
    if (![s respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
        
    } else {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [style setLineBreakMode:NSLineBreakByWordWrapping];
        
        labelsize = [s boundingRectWithSize:size
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                 attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName : style}
                                    context:nil].size;
    }
    CGRect frame = label.frame;
    frame.size = CGSizeMake(ceilf(labelsize.width), ceilf(labelsize.height));
    [label setFrame:frame];
}

#pragma mark - setter/getter
- (UILabel *)badge
{
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadge:(UILabel *)label
{
    objc_setAssociatedObject(self, &badgeLabelKey, label, OBJC_ASSOCIATION_RETAIN);
}

- (UIFont *)badgeFont
{
    id font = objc_getAssociatedObject(self, &badgeFontKey);
    return font == nil ? kZYQBadgeDefaulZYQont : font;
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.font = badgeFont;
}

- (UIColor *)badgeBgColor
{
    return objc_getAssociatedObject(self, &badgeBgColorKey);
}

- (void)setBadgeBgColor:(UIColor *)badgeBgColor
{
    objc_setAssociatedObject(self, &badgeBgColorKey, badgeBgColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.backgroundColor = badgeBgColor;
}

- (UIColor *)badgeTextColor
{
    return objc_getAssociatedObject(self, &badgeTextColorKey);
}

- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.textColor = badgeTextColor;
}

- (ZYQBadgeAnimType)aniType
{
    id obj = objc_getAssociatedObject(self, &badgeAniTypeKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return ZYQBadgeAnimTypeNone;
}

- (void)setAniType:(ZYQBadgeAnimType)aniType
{
    NSNumber *numObj = @(aniType);
    objc_setAssociatedObject(self, &badgeAniTypeKey, numObj, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    [self removeAnimation];
    [self beginAnimation];
}

- (CGRect)badgeFrame
{
    id obj = objc_getAssociatedObject(self, &badgeFrameKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 4) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        CGFloat width = [obj[@"width"] floatValue];
        CGFloat height = [obj[@"height"] floatValue];
        return  CGRectMake(x, y, width, height);
    } else
        return CGRectZero;
}

- (void)setBadgeFrame:(CGRect)badgeFrame
{
    NSDictionary *frameInfo = @{@"x" : @(badgeFrame.origin.x), @"y" : @(badgeFrame.origin.y),
                                @"width" : @(badgeFrame.size.width), @"height" : @(badgeFrame.size.height)};
    objc_setAssociatedObject(self, &badgeFrameKey, frameInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.frame = badgeFrame;
}

- (CGPoint)badgeCenterOffset
{
    id obj = objc_getAssociatedObject(self, &badgeCenterOffsetKey);
    if (obj != nil && [obj isKindOfClass:[NSDictionary class]] && [obj count] == 2) {
        CGFloat x = [obj[@"x"] floatValue];
        CGFloat y = [obj[@"y"] floatValue];
        return CGPointMake(x, y);
    } else
        return CGPointZero;
}

- (void)setBadgeCenterOffset:(CGPoint)badgeCenterOff
{
    NSDictionary *cenerInfo = @{@"x" : @(badgeCenterOff.x), @"y" : @(badgeCenterOff.y)};
    objc_setAssociatedObject(self, &badgeCenterOffsetKey, cenerInfo, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
    self.badge.center = CGPointMake(CGRectGetWidth(self.frame) + 2 + badgeCenterOff.x, badgeCenterOff.y);
}


- (NSInteger)badgeMaximumBadgeNumber {
    id obj = objc_getAssociatedObject(self, &badgeMaximumBadgeNumberKey);
    if(obj != nil && [obj isKindOfClass:[NSNumber class]])
    {
        return [obj integerValue];
    }
    else
        return kZYQBadgeDefaultMaximumBadgeNumber;
}

- (void)setBadgeMaximumBadgeNumber:(NSInteger)badgeMaximumBadgeNumber {
    NSNumber *numObj = @(badgeMaximumBadgeNumber);
    objc_setAssociatedObject(self, &badgeMaximumBadgeNumberKey, numObj, OBJC_ASSOCIATION_RETAIN);
    if (!self.badge) {
        [self badgeInit];
    }
}





@end
