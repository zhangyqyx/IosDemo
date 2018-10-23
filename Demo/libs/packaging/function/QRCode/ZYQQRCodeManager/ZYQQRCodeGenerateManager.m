//
//  ZYQQRCodeGenerateManager.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import "ZYQQRCodeGenerateManager.h"

@implementation ZYQQRCodeGenerateManager
#pragma mark - 生成简单二维码图片
+ (UIImage *)ZYQ_generateQRCodeWithData:(NSData *)data
                             sizeWidth:(CGFloat)sizeWidth {
    //获得滤镜输出的图像
    CIImage *outputImage = [self getCIImageWithData:data];
    return [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:sizeWidth];
}
/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image
                                            withSize:(CGFloat)size {
    CGRect extent               = CGRectIntegral(image.extent);
    CGFloat scale               = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width                 = CGRectGetWidth(extent) * scale;
    size_t height                = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs            = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef       = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context           = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage      = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage      = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)ZYQ_generateQRCodeWithStr:(NSString *)str
                            sizeWidth:(CGFloat)sizeWidth {
    NSData *infoData = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [self ZYQ_generateQRCodeWithData:infoData sizeWidth:sizeWidth];
}

#pragma mark - 带logo的二维码图片o

+ (UIImage *)ZYQ_generateQRCodeWithLogoStr:(NSString *)str
                            logoImageName:(NSString *)logoImageName
                     logoScaleToSuperView:(CGFloat)logoScaleToSuperView {
    return [self ZYQ_generateQRCodeWithLogoData:[str dataUsingEncoding:NSUTF8StringEncoding]
                                 logoImageName:logoImageName
                          logoScaleToSuperView:logoScaleToSuperView];
}

+ (UIImage *)ZYQ_generateQRCodeWithLogoData:(NSData *)data
                             logoImageName:(NSString *)logoImageName
                      logoScaleToSuperView:(CGFloat)logoScaleToSuperView {
    // 获得滤镜输出的图像
    CIImage *outputImage = [self getCIImageWithData:data];
    // 我们需要对图片进行放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    // 将CIImage类型转成UIImage类型
    UIImage *start_image = [UIImage imageWithCIImage:outputImage];
    //开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    // 再把小图片画上去
    NSString *icon_imageName     = logoImageName;
    UIImage *icon_image         = [UIImage imageNamed:icon_imageName];
    CGFloat icon_imageW         = start_image.size.width * logoScaleToSuperView;
    if (icon_imageW > start_image.size.width * 0.33) {
        icon_imageW = start_image.size.width * 0.33;
    }
    CGFloat icon_imageX         = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY         = (start_image.size.height - icon_imageW) * 0.5;
    [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageW)];
    // 获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}


#pragma mark - 带颜色的二维码图片
+ (UIImage *)ZYQ_generateWithColorQRCodeStr:(NSString *)str
                           backgroundColor:(CIColor *)backgroundColor
                                 mainColor:(CIColor *)mainColor {
    return   [self  ZYQ_generateWithColorQRCodeData:[str dataUsingEncoding:NSUTF8StringEncoding] backgroundColor:backgroundColor mainColor:mainColor];
}
+ (UIImage *)ZYQ_generateWithColorQRCodeData:(NSData *)data
                            backgroundColor:(CIColor *)backgroundColor
                                  mainColor:(CIColor *)mainColor {
    // 获得滤镜输出的图像
    CIImage *outputImage = [self getCIImageWithData:data];
    // 我们需要对图片进行放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    // 创建彩色过滤器(彩色的用的不多)
    CIFilter * color_filter = [CIFilter filterWithName:@"CIFalseColor"];
    // 设置默认值
    [color_filter setDefaults];
    // 5、KVC 给私有属性赋值
    [color_filter setValue:outputImage forKey:@"inputImage"];
    // 6、需要使用 CIColor
    [color_filter setValue:backgroundColor forKey:@"inputColor0"];
    [color_filter setValue:mainColor forKey:@"inputColor1"];
    // 7、设置输出
    CIImage *colorImage = [color_filter outputImage];
    return [UIImage imageWithCIImage:colorImage];
}

#pragma mark - 颜色加logo的二维码图片
+ (UIImage *)ZYQ_generateQRCodeWithLogoStr:(NSString *)str
                            logoImageName:(NSString *)logoImageName
                     logoScaleToSuperView:(CGFloat)logoScaleToSuperView
                          backgroundColor:(CIColor *)backgroundColor
                                mainColor:(CIColor *)mainColor {
    CIImage *outputImage = [self getCIImageWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    // 我们需要对图片进行放大
    outputImage = [outputImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    // 创建彩色过滤器(彩色的用的不多)
    CIFilter * color_filter = [CIFilter filterWithName:@"CIFalseColor"];
    // 设置默认值
    [color_filter setDefaults];
    // 5、KVC 给私有属性赋值
    [color_filter setValue:outputImage forKey:@"inputImage"];
    // 6、需要使用 CIColor
    [color_filter setValue:backgroundColor forKey:@"inputColor0"];
    [color_filter setValue:mainColor forKey:@"inputColor1"];
    // 7、设置输出
    CIImage *colorImage = [color_filter outputImage];
    // 我们需要对图片进行放大
    colorImage = [colorImage imageByApplyingTransform:CGAffineTransformMakeScale(10, 10)];
    // 将CIImage类型转成UIImage类型
    UIImage *start_image = [UIImage imageWithCIImage:colorImage];
    //开启绘图, 获取图形上下文 (上下文的大小, 就是二维码的大小)
    UIGraphicsBeginImageContext(start_image.size);
    // 把二维码图片画上去 (这里是以图形上下文, 左上角为(0,0)点
    [start_image drawInRect:CGRectMake(0, 0, start_image.size.width, start_image.size.height)];
    // 再把小图片画上去
    NSString *icon_imageName     = logoImageName;
    UIImage *icon_image         = [UIImage imageNamed:icon_imageName];
    CGFloat icon_imageW         = start_image.size.width * logoScaleToSuperView;
    if (icon_imageW > start_image.size.width * 0.33) {
        icon_imageW = start_image.size.width * 0.33;
    }
    CGFloat icon_imageX         = (start_image.size.width - icon_imageW) * 0.5;
    CGFloat icon_imageY         = (start_image.size.height - icon_imageW) * 0.5;
    [icon_image drawInRect:CGRectMake(icon_imageX, icon_imageY, icon_imageW, icon_imageW)];
    // 获取当前画得的这张图片
    UIImage *final_image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return final_image;
}



+ (CIImage *)getCIImageWithData:(NSData *)data {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 设置过滤器的输入值, KVC赋值
    [filter setValue:data forKey:@"inputMessage"];
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}


@end
