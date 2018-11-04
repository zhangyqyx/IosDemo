//
//  UIColor+TFColor.h
//  封装
//
//  Created by 张永强 on 17/4/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TFColor)
/**
 颜色
 @param hex 十六进制的颜色值
 @return UIColor
 */
+ (nonnull instancetype)TF_colorWithHex:(u_int32_t)hex;

/**
  颜色

 @param hex 十六进制的颜色值
 @param alpha 透明度
 @return UIColor
 */
+ (nonnull instancetype)TF_colorWithHex:(u_int32_t)hex alpha:(CGFloat)alpha;

/**
 生成指定r/g/b 数值的颜色
 @param red 红色值   0 ~ 255.0f
 @param green 绿色值 0 ~ 255.0f
 @param blue 蓝色值  0 ~ 255.0f
 @param alpha 透明度 0 ~ 1f
 @return 颜色
 */
+ (nonnull instancetype)TF_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue alpha:(CGFloat)alpha;
/**
 生成一个随机的颜色
 @return 随机的颜色，不透明的
 */
+ (nonnull instancetype)TF_randomColor;

/**
 渐变颜色
 
 @param fromColor 开始时候的颜色
 @param toColor 结束时候的颜色
 @param size 渐变尺寸  CGSizeMake(50, 1)---左右渐变  CGSizeMake(1, 50)--上下渐变
 @return 渐变颜色
 */
+ (nullable instancetype)TF_gradientFromColor:(nullable UIColor *)fromColor toColor:(nullable UIColor *)toColor withSize:(CGSize)size;
#pragma mark - 颜色值

/**
 返回当前颜色的红色值 
 @return 红色数值  0 ~ 255.0
 */
- (u_int8_t)TF_redColorValue;
/**
 返回当前颜色的绿色值
 @return 绿色数值  0 ~ 255.0
 */
- (u_int8_t)TF_greenColorValue;
/**
 返回当前颜色的蓝色值
 @return 蓝色数值  0 ~ 255.0
 */
- (u_int8_t)TF_blueColorValue;
/**
 返回当前颜色的透明度值
 @return 透明数值  0 ~ 1.0
 */
- (CGFloat)TF_alphaValue;
#pragma mark -- 字符串转换成颜色

/**
 通过一个16进制的字符串转换成颜色
 @param hexColor 16进制字符串 是 #00ff0b 或者 00ff0b 这种格式
 @return 颜色
 */
+ (nullable instancetype)TF_getColor:(nullable NSString *)hexColor;

/**
 通过一个16进制的字符串转换成颜色
 
 @param hexColor  16进制字符串 是 #00ff0b  或者00ff0b 这种格式
 @param alpha 透明度值
 @return 颜色
 */
+ (nullable instancetype)TF_getColor:(nullable NSString *)hexColor alpha:(CGFloat)alpha;

@end
