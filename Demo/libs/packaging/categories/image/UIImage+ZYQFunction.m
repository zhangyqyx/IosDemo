//
//  UIImage+ZYQFunction.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIImage+ZYQFunction.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (ZYQFunction)

- (nullable UIColor *)ZYQ_colorAtPoint:(CGPoint)point {
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    NSInteger pointX                = trunc(point.x);
    NSInteger pointY                = trunc(point.y);
    CGImageRef cgImage              = self.CGImage;
    NSUInteger width                = self.size.width;
    NSUInteger height               = self.size.height;
    CGColorSpaceRef colorSpece      = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel               = 4;
    int bytesPerRow                 = bytesPerPixel * 1;
    NSUInteger bitesPerComponent    = 8;
    unsigned char pixelData[4]      = {0,0,0,0};
    CGContextRef context            = CGBitmapContextCreate(pixelData,
                                                            1,
                                                            1,
                                                            bitesPerComponent,
                                                            bytesPerRow,
                                                            colorSpece,
                                                            kCGImageAlphaPremultipliedLast
                                                            | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpece);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red                     = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green                   = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue                    = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha                   = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)ZYQ_singleDotImageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), YES, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, 1, 1));
    UIImage *image                  =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark -- 水印图片
+ (instancetype)ZYQ_waterImageWithBg:(NSString *)bg
                               logo:(NSString *)logo
                              scale:(CGFloat)scale
                             margin:(CGFloat)margin {
    UIImage *bgImage                = [UIImage imageNamed:bg];
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    //画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    //画右下角水印
    UIImage *logoImage              = [UIImage imageNamed:logo];
    CGFloat logoW                   = logoImage.size.width * scale;
    CGFloat logoH                   = logoImage.size.height * scale;
    CGFloat logoX                   = bgImage.size.width - logoW - margin;
    CGFloat logoY                   = bgImage.size.height - logoH - margin;
    CGRect rect                     = CGRectMake(logoX, logoY, logoW, logoH);
    [logoImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark -- 裁剪图片
+ (nonnull UIImage *)ZYQ_circleImageWithImage:(nullable UIImage *)sourceImage
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor *)borderColor {
   
    CGFloat imageSizeMin            = MIN(sourceImage.size.width, sourceImage.size.height);
    return [UIImage ZYQ_circleImageWithImage:sourceImage imageSize:imageSizeMin isExistBorder:isExistBorder borderWidth:borderWidth borderColor:borderColor];
}
+ (UIImage *)ZYQ_circleImageWithImageStr:(NSString *)sourceImageStr imageSize:(CGFloat)imageSize isExistBorder:(BOOL)isExistBorder borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    return [UIImage ZYQ_circleImageWithImage:[UIImage imageNamed:sourceImageStr] imageSize:imageSize isExistBorder:isExistBorder borderWidth:borderWidth borderColor:borderColor];
}
+ (nonnull UIImage *)ZYQ_circleImageWithImage:(nullable UIImage *)sourceImage
                                   imageSize:(CGFloat)imageSize
                               isExistBorder:(BOOL)isExistBorder
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nonnull UIColor*)borderColor{
    CGFloat imageSizeMin;
    if (isExistBorder) {
        imageSizeMin               = imageSize + borderWidth;
    }else {
        imageSizeMin               = imageSize;
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSizeMin, imageSizeMin), NO, 2.0);
    //3. 获取当前上下文
    UIGraphicsGetCurrentContext();
    //4. 画圆圈
    UIBezierPath *bezierPath        = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageSizeMin * 0.5, imageSizeMin * 0.5) radius:(imageSizeMin-borderWidth) *0.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    if (isExistBorder) {
        bezierPath.lineWidth        = borderWidth;
        [borderColor setStroke];
        [bezierPath stroke];
    }
    //5. 使用bezierPath进行剪切
    [bezierPath addClip];
    //6. 画图
    [sourceImage drawInRect:CGRectMake(0, 0, imageSizeMin, imageSizeMin)];
    //7. 从内存中创建新图片对象
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //8. 结束上下文
    UIGraphicsEndImageContext();
     return image;
}
#pragma mark -- 图片变模糊
+ (nonnull UIImage *)ZYQ_blurImage:(nonnull UIImage *)src
                         argument:(CGFloat)argument
{
    if (argument < 0.0 || argument > 1.0) {
        argument        = 0.5;
    }
    int boxSize         = (int)(argument * 40);
    boxSize             = boxSize - (boxSize % 2) + 1;
    CGImageRef img      = src.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider    = CGImageGetDataProvider(img);
    CFDataRef inBitmapData          = CGDataProviderCopyData(inProvider);
    inBuffer.width                  = CGImageGetWidth(img);
    inBuffer.height                 = CGImageGetHeight(img);
    inBuffer.rowBytes               = CGImageGetBytesPerRow(img);
    inBuffer.data                   = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer                     = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data                  = pixelBuffer;
    outBuffer.width                 = CGImageGetWidth(img);
    outBuffer.height                = CGImageGetHeight(img);
    outBuffer.rowBytes              = CGImageGetBytesPerRow(img);
    error                           = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    CGColorSpaceRef colorSpace      = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx                = CGBitmapContextCreate(outBuffer.data,
                                                            outBuffer.width,
                                                            outBuffer.height,
                                                            8,
                                                            outBuffer.rowBytes,
                                                            colorSpace,
                                                            (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef             = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage            = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
+ (nonnull UIView *)ZYQ_blurVisualEffectImage:(nonnull UIImageView *)src
                           frame:(CGRect )frame
                           style:(UIBlurEffectStyle)style {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    [src addSubview:effectView];
    return effectView;
}
#pragma mark -- 裁剪图片
+ (nonnull UIImage *)ZYQ_image:(nonnull UIImage*)image
                 scaledToSize:(CGSize)newSize
{
     UIGraphicsBeginImageContextWithOptions(newSize, NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (nonnull UIImage *)ZYQ_handleImage:(nonnull UIImage *)originalImage
                            withframe:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGSize originalSize = [originalImage size];
    if (width > originalSize.width) {
        width = originalSize.width;
    }
    if (height > originalSize.height) {
        height = originalSize.height;
    }
    frame = CGRectMake(frame.origin.x, frame.origin.y, width, height);
    CGImageRef imgRef = CGImageCreateWithImageInRect(originalImage.CGImage, frame);
    CGFloat deviceScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(frame.size, 0, deviceScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, frame.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, frame.size.width, frame.size.height), imgRef);
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(imgRef);
    UIGraphicsEndImageContext();
    return newImg;
}



@end
