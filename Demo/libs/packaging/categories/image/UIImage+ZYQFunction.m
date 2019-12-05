//
//  UIImage+ZYQFunction.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIImage+ZYQFunction.h"
#import <Accelerate/Accelerate.h>

//由角度转换弧度
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
//由弧度转换角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)

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
/**
 将两个图片生成一张图片
 
 @param firstImage 第一张图片
 @param secondImage 第二张图片
 @return 生成的图片
 */
+ (nonnull UIImage *)ZYQ_mergeImage:(nonnull UIImage *)firstImage
                          withImage:(nonnull UIImage *)secondImage {
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//改变图片的颜色
- (nonnull UIImage *)ZYQ_imageWithTintColor:(nonnull UIColor *)tintColor{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

//获得灰度图
- (nonnull UIImage *)ZYQ_convertToGrayImage{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

#pragma mark - rotate

/** 纠正图片的方向 */
- (nonnull UIImage *)ZYQ_fixOrientation {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

/** 按给定的方向旋转图片 */
- (nonnull UIImage *)ZYQ_rotate:(UIImageOrientation)orient{
    CGRect bnds = CGRectZero;
    UIImage *copy = nil;
    CGContextRef ctxt = nil;
    CGImageRef imag = self.CGImage;
    CGRect rect = CGRectZero;
    CGAffineTransform tran = CGAffineTransformIdentity;
    
    rect.size.width = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient) {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            return self;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

/** 垂直翻转 */
- (nonnull UIImage *)ZYQ_flipVertical {
    return [self ZYQ_rotate:UIImageOrientationDownMirrored];
}

/** 水平翻转 */
- (nonnull UIImage *)ZYQ_flipHorizontal {
    return [self ZYQ_rotate:UIImageOrientationUpMirrored];
}

/** 将图片旋转弧度radians */
- (nonnull UIImage *)ZYQ_imageRotatedByRadians:(CGFloat)radians {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 将图片旋转角度degrees */
- (nonnull UIImage *)ZYQ_imageRotatedByDegrees:(CGFloat)degrees {
    return [self ZYQ_imageRotatedByRadians:kDegreesToRadian(degrees)];
}

/** 交换宽和高 */
static CGRect swapWidthAndHeight(CGRect rect) {
    CGFloat swap = rect.size.width;
    
    rect.size.width = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}

#pragma mark - gif

static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = (__bridge id) CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = (__bridge id) CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) {
                delayCentiseconds = (int) lrint([number doubleValue] * 100);
            }
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}

static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}

static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}

static int pairGCD(int a, int b) {
    if (a < b) {
        return pairGCD(b, a);
    }
    
    while (YES) {
        int const r = a % b;
        if (r == 0) {
            return b;
        }
        a = b;
        b = r;
    }
}

static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}

static NSArray *frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}

static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage *animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count]; // in centiseconds
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval) totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage *animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    } else {
        return nil;
    }
}

+ (nonnull UIImage *)ZYQ_animatedImageWithAnimatedGIFData:(nonnull NSData *)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData((__bridge CFTypeRef) data, NULL));
}

+ (nonnull UIImage *)ZYQ_animatedImageWithAnimatedGIFURL:(nonnull NSURL *)url{
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL((__bridge CFTypeRef) url, NULL));
}


@end
