//
//  ZYQBadgeProtocol.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -- 类型

#define kBadgeBreatheAniKey     @"breathe"
#define kBadgeRotateAniKey      @"rotate"
#define kBadgeShakeAniKey       @"shake"
#define kBadgeScaleAniKey       @"scale"
#define kBadgeBounceAniKey      @"bounce"

static char badgeLabelKey;
static char badgeBgColorKey;
static char badgeFontKey;
static char badgeTextColorKey;
static char badgeAniTypeKey;
static char badgeFrameKey;
static char badgeCenterOffsetKey;
static char badgeMaximumBadgeNumberKey;
static char badgeRadiusKey;
typedef NS_ENUM(NSUInteger, ZYQBadgeStyle)
{
    ZYQBadgeStyleRedDot = 0,          //红点
    ZYQBadgeStyleNumber,              //数量
    ZYQBadgeStyleNew                  //new文字
};

typedef NS_ENUM(NSUInteger, ZYQBadgeAnimType)
{
    ZYQBadgeAnimTypeNone = 0,         //默认无动画
    ZYQBadgeAnimTypeScale,            //缩放动画
    ZYQBadgeAnimTypeShake,            //摇动
    ZYQBadgeAnimTypeBounce,           // 反弹
    ZYQBadgeAnimTypeBreathe           // 若隐若现
};



@protocol ZYQBadgeProtocol <NSObject>

@property (nonatomic, strong) UILabel *badge;                       //红点
@property (nonatomic, strong) UIFont *badgeFont;                    //字体
@property (nonatomic, strong) UIColor *badgeBgColor;                //颜色
@property (nonatomic, strong) UIColor *badgeTextColor;              //文字颜色
@property (nonatomic, assign) CGRect badgeFrame;                    //尺寸

@property (nonatomic, assign) CGPoint  badgeCenterOffset;          //红点的位置

@property (nonatomic, assign) ZYQBadgeAnimType aniType;               //动画类型

@property (nonatomic, assign) NSInteger badgeMaximumBadgeNumber;    //最大值


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
 清除红点
 */
- (void)ZYQ_clearBadge;

@end
