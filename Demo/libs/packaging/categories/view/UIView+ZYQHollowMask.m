//
//  UIView+ZYQHollowMask.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIView+ZYQHollowMask.h"

@implementation UIView (ZYQHollowMask)


- (void)setHollowMaskView:(UIView *)hollowView {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(),
                          hollowView.frame.origin.x,
                          hollowView.frame.origin.y);
    [hollowView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
     // 获取相反的遮罩图
    image = [self hollowMaskImageWithImage:image];
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = self.bounds;
    maskView.layer.contents = (__bridge id)(image.CGImage);
    self.maskView = maskView;
}

- (UIView *)hollowMaskView {
    return self.maskView;
}

#pragma mark - private methods
#define ROUND_UP(N, S) ((((N) + (S) - 1) / (S)) * (S))
- (UIImage *)hollowMaskImageWithImage:(UIImage *)image {
    CGImageRef originalMaskImage = [image CGImage];
    float width = CGImageGetWidth(originalMaskImage);
    float height = CGImageGetHeight(originalMaskImage);
    
    
    
    int strideLength = ROUND_UP(width * 1, 4);
    unsigned char * alphaData = calloc(strideLength * height, sizeof(unsigned char));
    CGContextRef alphaOnlyContext = CGBitmapContextCreate(alphaData,
                                                          width,
                                                          height,
                                                          8,
                                                          strideLength,
                                                          NULL,
                                                          kCGImageAlphaOnly);
    
    CGContextDrawImage(alphaOnlyContext, CGRectMake(0, 0, width, height), originalMaskImage);
    
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            unsigned char val = alphaData[y*strideLength + x];
            val = 255 - val;
            alphaData[y*strideLength + x] = val;
        }
    }
    
    CGImageRef alphaMaskImage = CGBitmapContextCreateImage(alphaOnlyContext);
    UIImage *result = [UIImage imageWithCGImage:alphaMaskImage];
    
    CGImageRelease(alphaMaskImage);
    CGContextRelease(alphaOnlyContext);
    free(alphaData);
    
    return result;
}


@end
