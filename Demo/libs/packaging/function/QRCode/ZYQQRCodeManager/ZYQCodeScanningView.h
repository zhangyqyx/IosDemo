//
//  ZYQCodeScanningView.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ZYQCornerLocation) {
    //默认与边框线同中心点
    ZYQCornerLocationDefault,
    //在边框线内部
    ZYQCornerLocationInside,
    //在边框线外部
    ZYQCornerLocationOutside,
};

typedef NS_ENUM(NSUInteger , ZYQScanningAnimationType)  {
    //单线扫描模式
    ZYQScanningAnimationTypeDefault,
    //网格扫描样式
    ZYQScanningAnimationTypeGrid,
};

@interface ZYQCodeScanningView : UIView
/** 扫描样式 */
@property (nonatomic , assign)ZYQScanningAnimationType scnningType;

/** 扫描线名 */
@property (nonatomic, copy) NSString *scanningImageName;
/** 边框颜色，默认白色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 边角位置，默认 CornerLoactionDefault */
@property (nonatomic, assign) ZYQCornerLocation cornerLocation;
/** 边角颜色，默认微信颜色 */
@property (nonatomic, strong) UIColor *cornerColor;
/** 边角宽度，默认 2.f */
@property (nonatomic, assign) CGFloat cornerWidth;
/** 扫描区周边颜色的 alpha 值，默认 0.2f */
@property (nonatomic, assign) CGFloat backgroundAlpha;
/** 扫描线动画时间，默认 0.02 */
@property (nonatomic, assign) NSTimeInterval animationTimeInterval;
/** 设置扫描区域大小  */
@property (nonatomic , assign)CGSize scanSize;




/** 添加定时器 */
- (void)addTimer;
/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;


@end
