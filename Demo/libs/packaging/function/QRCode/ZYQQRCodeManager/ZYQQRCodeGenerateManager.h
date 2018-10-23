//
//  ZYQQRCodeGenerateManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYQQRCodeGenerateManager : NSObject

/**
 创建一张二维码图片
 
 @param data  二维码数据
 @param sizeWidth  图片宽度
 @return  二维码图片
 */
+ (UIImage *)ZYQ_generateQRCodeWithData:(NSData *)data
                             sizeWidth:(CGFloat)sizeWidth;

/**
  创建一张二维码图片

 @param str 二维码数据
 @param sizeWidth 图片宽度
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateQRCodeWithStr:(NSString *)str
                            sizeWidth:(CGFloat)sizeWidth;
/**
 创建一张带logo图片的二维码图片

 @param str 二维码数据
 @param logoImageName 图片名称
 @param logoScaleToSuperView 相对于父视图的缩放比取值范围0以上；0，不显示，如果超出扫描区域，默认在扫描区域内;
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateQRCodeWithLogoStr:(NSString *)str
                            logoImageName:(NSString *)logoImageName
                     logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/**
 创建一张带logo图片的二维码图片
 
 @param data 二维码数据
 @param logoImageName 图片名称
 @param logoScaleToSuperView 相对于父视图的缩放比取值范围0以上；0，不显示，如果超出扫描区域，默认在扫描区域内;
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateQRCodeWithLogoData:(NSData *)data
                            logoImageName:(NSString *)logoImageName
                     logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/**
 生成一张彩色的二维码

 @param str 二维码数据
 @param backgroundColor 背景颜色
 @param mainColor 主颜色
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateWithColorQRCodeStr:(NSString *)str
                           backgroundColor:(CIColor *)backgroundColor
                                 mainColor:(CIColor *)mainColor;
/**
 生成一张彩色的二维码
 
 @param data 二维码数据
 @param backgroundColor 背景颜色
 @param mainColor 主颜色
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateWithColorQRCodeData:(NSData *)data
                           backgroundColor:(CIColor *)backgroundColor
                                 mainColor:(CIColor *)mainColor;
/**
  创建一张带logo图片的彩色二维码图片
 @param str 二维码数据
 @param logoImageName 图片名称
 @param logoScaleToSuperView 相对于父视图的缩放比取值范围0以上；0，不显示，如果超出扫描区域，默认在扫描区域内;
 @param backgroundColor 背景颜色
 @param mainColor 主颜色
 @return 二维码图片
 */
+ (UIImage *)ZYQ_generateQRCodeWithLogoStr:(NSString *)str
                            logoImageName:(NSString *)logoImageName
                     logoScaleToSuperView:(CGFloat)logoScaleToSuperView
                          backgroundColor:(CIColor *)backgroundColor
                                mainColor:(CIColor *)mainColor;

@end
