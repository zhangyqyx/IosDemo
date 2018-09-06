//
//  UIColor+ZYQColor.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIColor+ZYQColor.h"

@implementation UIColor (ZYQColor)
+ (nonnull instancetype)ZYQ_colorWithHex:(u_int32_t)hex {
    u_int8_t red        = (hex & 0xFF0000) >> 16;
    u_int8_t green      = (hex & 0x00FF00) >> 8;
    u_int8_t blue       = hex & 0x0000FF;
    return [UIColor ZYQ_colorWithRed:red green:green blue:blue alpha:1.0f];
}
+ (nonnull instancetype)ZYQ_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}
+ (nonnull instancetype)ZYQ_randomColor{
    u_int8_t red        = arc4random_uniform(256);
    u_int8_t green      = arc4random_uniform(256);
    u_int8_t blue       = arc4random_uniform(256);
    return [UIColor ZYQ_colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (nullable instancetype)ZYQ_gradientFromColor:(nullable UIColor *)fromColor toColor:(nullable UIColor *)toColor withSize:(CGSize)size{
    if (size.width < 1) {
        size.width  = 1;
    }
    if (size.height < 1) {
        size.height = 1;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context        = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace  = CGColorSpaceCreateDeviceRGB();
    NSArray *colors             = [NSArray arrayWithObjects:(__bridge id)fromColor.CGColor , (__bridge id)toColor.CGColor, nil];
    const CGFloat locations[]   = {0.0, 1.0};
    CGGradientRef grasient      = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, grasient, CGPointMake(0, 0), CGPointMake(size.width, size.height), 0);
    UIImage *image              = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(grasient);
    CGColorSpaceRelease(colorspace);
    UIGraphicsEndImageContext();
    return [UIColor colorWithPatternImage:image];
}
#pragma mark - 颜色值
- (u_int8_t)ZYQ_redColorValue {
    return [self getRGBComponents][0] * 255.0 / [self ZYQ_alphaValue];
}
- (u_int8_t)ZYQ_greenColorValue {
  return [self getRGBComponents][1] * 255.0 / [self ZYQ_alphaValue];
}
- (u_int8_t)ZYQ_blueColorValue {
  return [self getRGBComponents][2] * 255.0 / [self ZYQ_alphaValue];
}
- (CGFloat)ZYQ_alphaValue {
    return [self getRGBComponents][3];
}

- (const CGFloat *)getRGBComponents {
   static CGFloat components[4];
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context          = CGBitmapContextCreate(&resultingPixel,
                                                                        1,
                                                                        1,
                                                                        8,
                                                                        4,
                                                                        rgbColorSpace,
                                                                        (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 4; component++) {
        components[component]   = resultingPixel[component] / 255.0f;
    }
    return (const CGFloat *)components;
}


+ (nullable instancetype)ZYQ_getColor:(nullable NSString *)hexColor{
    NSString *string = [hexColor substringFromIndex:1];//去掉#号
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    /* 调用下面的方法处理字符串 */
    red = [self stringToInt:[string substringWithRange:range]];
    range.location = 2;
    green = [self stringToInt:[string substringWithRange:range]];
    range.location = 4;
    blue = [self stringToInt:[string substringWithRange:range]];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}
+ (int)stringToInt:(NSString *)string {
    unichar hex_char1 = [string characterAtIndex:0]; /* 两位16进制数中的第一位(高位*16) */
    int int_ch1;
    if (hex_char1 >= '0' && hex_char1 <= '9')
        int_ch1 = (hex_char1 - 48) * 16;   /* 0 的Ascll - 48 */
    else if (hex_char1 >= 'A' && hex_char1 <='F')
        int_ch1 = (hex_char1 - 55) * 16; /* A 的Ascll - 65 */
    else
        int_ch1 = (hex_char1 - 87) * 16; /* a 的Ascll - 97 */
    unichar hex_char2 = [string characterAtIndex:1]; /* 两位16进制数中的第二位(低位) */
    int int_ch2;
    if (hex_char2 >= '0' && hex_char2 <='9')
        int_ch2 = (hex_char2 - 48); /* 0 的Ascll - 48 */
    else if (hex_char1 >= 'A' && hex_char1 <= 'F')
        int_ch2 = hex_char2 - 55; /* A 的Ascll - 65 */
    else
        int_ch2 = hex_char2 - 87; /* a 的Ascll - 97 */
    return int_ch1+int_ch2;
}


@end
