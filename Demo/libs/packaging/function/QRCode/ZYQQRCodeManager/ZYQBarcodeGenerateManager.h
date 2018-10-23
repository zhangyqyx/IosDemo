//
//  ZYQBarcodeGenerateManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ZYQBarcodeGenerateManager : NSObject


/**
 生成彩色条形码
 
 @param str 条形码数据
 @param size 生成的大小
 @param red 红色
 @param green 绿
 @param blue 蓝
 @return 条形码图片
 */
+ (UIImage *)ZYQ_generateBarcodeWithStr:(NSString *)str
                       codeImageSize:(CGSize)size
                                 red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(CGFloat)blue;

/**
 生成条形码
 
 @param str 条形码数据
 @param size 图片尺寸
 @return 条形码图片
 */
+ (UIImage *)ZYQ_generateBarcodeWithStr:(NSString *)str
                         codeImageSize:(CGSize)size;
/**
生成最原始的条形码

 @param str 条形码数据
 @return 条形码图片
 */
+ (UIImage *)ZYQ_generateBarcodeWithStr:(NSString *)str;


@end
