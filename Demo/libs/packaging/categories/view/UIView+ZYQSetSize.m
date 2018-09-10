//
//  UIView+ZYQSetSize.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIView+ZYQSetSize.h"

@implementation UIView (ZYQSetSize)
#pragma mark -- setupFrame
- (void)setZYQ_viewOrign:(CGPoint)ZYQ_viewOrign {
    CGRect newFrame     = self.frame;
    newFrame.origin     = ZYQ_viewOrign;
    self.frame          = newFrame;
}
- (CGPoint)ZYQ_viewOrign {
    return self.frame.origin;
}
- (void)setZYQ_viewSize:(CGSize)ZYQ_viewSize {
    CGRect newFrame     = self.frame;
    newFrame.size       = ZYQ_viewSize;
    self.frame          = newFrame;
}
- (CGSize)ZYQ_viewSize {
    return self.frame.size;
}

#pragma mark --setupPoint
- (void)setZYQ_viewX:(CGFloat)ZYQ_viewX {
    CGRect newFrame     = self.frame;
    newFrame.origin.x   = ZYQ_viewX;
    self.frame          = newFrame;
}
- (CGFloat)ZYQ_viewX {
    return self.frame.origin.x;
}
- (void)setZYQ_viewY:(CGFloat)ZYQ_viewY {
    CGRect newFrame     = self.frame;
    newFrame.origin.y   = ZYQ_viewY;
    self.frame          = newFrame;
}
- (CGFloat)ZYQ_viewY {
    return self.frame.origin.y;
}
- (void)setZYQ_viewWidth:(CGFloat)ZYQ_viewWidth {
    CGRect newFrame     = self.frame;
    newFrame.size.width = ZYQ_viewWidth;
    self.frame          = newFrame;
}
- (CGFloat)ZYQ_viewWidth{
    return self.frame.size.width;
}
- (void)setZYQ_viewHeight:(CGFloat)ZYQ_viewHeight {
    CGRect newFrame     = self.frame;
    newFrame.size.height = ZYQ_viewHeight;
    self.frame          = newFrame;
}
- (CGFloat)ZYQ_viewHeight {
    return self.frame.size.height;
}

- (void)setZYQ_viewCenterX:(CGFloat)ZYQ_viewCenterX {
    CGPoint center = self.center;
    center.x = ZYQ_viewCenterX;
    self.center = center;
}
- (CGFloat)ZYQ_viewCenterX {
    return self.center.x;
}
- (void)setZYQ_viewCenterY:(CGFloat)ZYQ_viewCenterY {
    CGPoint center = self.center;
    center.y = ZYQ_viewCenterY;
    self.center = center;
}
- (CGFloat)ZYQ_viewCenterY {
    return self.center.y;
}

#pragma mark -- setupbottom、right
- (void)setZYQ_viewRight:(CGFloat)ZYQ_viewRight {
    self.ZYQ_viewX = ZYQ_viewRight - self.ZYQ_viewWidth;
}

- (CGFloat)ZYQ_viewRight {
    return CGRectGetMaxX(self.frame);
}
- (void)setZYQ_viewBottom:(CGFloat)ZYQ_viewBottom {
    self.ZYQ_viewY = ZYQ_viewBottom - self.ZYQ_viewHeight;
}
- (CGFloat)ZYQ_viewBottom {
    return CGRectGetMaxY(self.frame);
}


#pragma mark -- 截屏
- (UIImage *)ZYQ_capturedImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    UIImage *result = nil;
    if ([self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]) {
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    
    UIGraphicsEndImageContext();
    
    return result;
}


@end
