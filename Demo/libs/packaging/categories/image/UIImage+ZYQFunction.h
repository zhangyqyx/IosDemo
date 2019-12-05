//
//  UIImage+ZYQFunction.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYQFunction)
/**
 *  此点区域的色值
 *
 *  @param point CGPoint
 *
 *  @return 色值
 */
- (nullable UIColor *)ZYQ_colorAtPoint:(CGPoint)point;
/**
 生成指定颜色的一个`点`的图像

 @param color 颜色
 @return 1 * 1 图像
 */
+ (nonnull UIImage *)ZYQ_singleDotImageWithColor:(nonnull UIColor *)color;
#pragma mark -- 水印图片

/**
 水印图片
 
 @param bg 背景图片名称
 @param logo logo图片名称
 @param scale logo图片在背景中的缩放比
 @param margin logo距离右下角的距离
 @return  图片
 */
+ (nonnull instancetype)ZYQ_waterImageWithBg:(nonnull NSString *)bg
                                       logo:(nonnull NSString *)logo
                                      scale:( CGFloat)scale
                                     margin:(CGFloat)margin;
#pragma mark -- 裁剪圆形图片
/**
 一张圆形图片
 @param sourceImage 放入的图片
 @param isExistBorder 是否加入圆形线
 @param borderWidth 线宽
 @param borderColor 线的颜色
 @return 圆形图片
 */
+ (nonnull UIImage *)ZYQ_circleImageWithImage:(nullable UIImage *)sourceImage
                            isExistBorder:(BOOL)isExistBorder
                              borderWidth:(CGFloat)borderWidth
                              borderColor:(nonnull UIColor*)borderColor;
/**
 一张圆形图片
 @param sourceImage 放入的图片
 @param imageSize 裁剪的图片大小
 @param isExistBorder 是否加入圆形线
 @param borderWidth 线宽
 @param borderColor 线的颜色
 @return 圆形图片
*/
+ (nonnull UIImage *)ZYQ_circleImageWithImage:(nullable UIImage *)sourceImage
                                   imageSize:(CGFloat)imageSize
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor*)borderColor;

/**
  一张圆形图片
 @param sourceImageStr 放入的图片名称
 @param imageSize 裁剪的图片大小
 @param isExistBorder 是否加入圆形线
 @param borderWidth 线宽
 @param borderColor 线的颜色
 @return 圆形图片
 */
+ (nonnull UIImage *)ZYQ_circleImageWithImageStr:(nullable NSString *)sourceImageStr
                                   imageSize:(CGFloat)imageSize
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor*)borderColor;

#pragma mark -- 图片变模糊
/**
  将一张图片变模糊

 @param src 传入的图片
 @param argument 模糊的参数 0~1 超过或者小于为0.5
 @return 模糊图片
 */
+ (nonnull UIImage *)ZYQ_blurImage:(nonnull UIImage *)src
                         argument:(CGFloat)argument;

/**
 给一张图片增加毛玻璃效果

 @param src 图片视图
 @param frame 增加效果的大小
 @param style 样式 
 @return 加上的模糊视图
 */
+ (nonnull UIView *)ZYQ_blurVisualEffectImage:(nonnull UIImageView *)src
                           frame:(CGRect )frame
                           style:(UIBlurEffectStyle)style;

#pragma mark -- 裁剪图片

/**
 裁剪一张图片

 @param image 原图片
 @param newSize 裁剪尺寸
 @return 裁剪后的图片
 */
+ (nonnull UIImage *)ZYQ_image:(nonnull UIImage*)image
                 scaledToSize:(CGSize)newSize;

/**
 裁剪一张指定区域的图片
 @param originalImage 原图片
 @param frame 要裁剪的区域
 @return 裁剪后的图片
 */
+ (nonnull UIImage *)ZYQ_handleImage:(nonnull UIImage *)originalImage
                           withframe:(CGRect)frame;


/**
 将两个图片生成一张图片

 @param firstImage 第一张图片
 @param secondImage 第二张图片
 @return 生成的图片
 */
+ (nonnull UIImage *)ZYQ_mergeImage:(nonnull UIImage *)firstImage
                          withImage:(nonnull UIImage *)secondImage;



//改变图片的颜色
- (nonnull UIImage *)ZYQ_imageWithTintColor:(nonnull UIColor *)tintColor;

//获得灰度图
- (nonnull UIImage *)ZYQ_convertToGrayImage;

#pragma mark - rotate

//纠正图片的方向
- (nonnull UIImage *)ZYQ_fixOrientation;

//按给定的方向旋转图片
- (nonnull UIImage *)ZYQ_rotate:(UIImageOrientation)orient;

//垂直翻转
- (nonnull UIImage *)ZYQ_flipVertical;

//水平翻转
- (nonnull UIImage *)ZYQ_flipHorizontal;

//将图片旋转degrees角度
- (nonnull UIImage *)ZYQ_imageRotatedByDegrees:(CGFloat)degrees;

//将图片旋转radians弧度
- (nonnull UIImage *)ZYQ_imageRotatedByRadians:(CGFloat)radians;

#pragma mark - gif

//用一个Gif生成UIImage，传入一个GIFData
+ (nonnull UIImage *)ZYQ_animatedImageWithAnimatedGIFData:(nonnull NSData *)data;

//用一个Gif生成UIImage，传入一个GIF路径
+ (nonnull UIImage *)ZYQ_animatedImageWithAnimatedGIFURL:(nonnull NSURL *)url;




@end
