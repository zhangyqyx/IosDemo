//
//  UIView+TFSetSize.m
//  封装
//
//  Created by 张永强 on 17/4/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIView+TFSetSize.h"

@implementation UIView (TFSetSize)
#pragma mark -- setupFrame
- (void)setTF_viewOrign:(CGPoint)TF_viewOrign {
    CGRect newFrame     = self.frame;
    newFrame.origin     = TF_viewOrign;
    self.frame          = newFrame;
}
- (CGPoint)TF_viewOrign {
    return self.frame.origin;
}
- (void)setTF_viewSize:(CGSize)TF_viewSize {
    CGRect newFrame     = self.frame;
    newFrame.size       = TF_viewSize;
    self.frame          = newFrame;
}
- (CGSize)TF_viewSize {
    return self.frame.size;
}

#pragma mark --setupPoint
- (void)setTF_viewX:(CGFloat)TF_viewX {
    CGRect newFrame     = self.frame;
    newFrame.origin.x   = TF_viewX;
    self.frame          = newFrame;
}
- (CGFloat)TF_viewX {
    return self.frame.origin.x;
}
- (void)setTF_viewY:(CGFloat)TF_viewY {
    CGRect newFrame     = self.frame;
    newFrame.origin.y   = TF_viewY;
    self.frame          = newFrame;
}
- (CGFloat)TF_viewY {
    return self.frame.origin.y;
}
- (void)setTF_viewWidth:(CGFloat)TF_viewWidth {
    CGRect newFrame     = self.frame;
    newFrame.size.width = TF_viewWidth;
    self.frame          = newFrame;
}
- (CGFloat)TF_viewWidth{
    return self.frame.size.width;
}
- (void)setTF_viewHeight:(CGFloat)TF_viewHeight {
    CGRect newFrame     = self.frame;
    newFrame.size.height = TF_viewHeight;
    self.frame          = newFrame;
}
- (CGFloat)TF_viewHeight {
    return self.frame.size.height;
}

- (void)setTF_viewCenterX:(CGFloat)TF_viewCenterX {
    CGPoint center = self.center;
    center.x = TF_viewCenterX;
    self.center = center;
}
- (CGFloat)TF_viewCenterX {
    return self.center.x;
}
- (void)setTF_viewCenterY:(CGFloat)TF_viewCenterY {
    CGPoint center = self.center;
    center.y = TF_viewCenterY;
    self.center = center;
}
- (CGFloat)TF_viewCenterY {
    return self.center.y;
}

#pragma mark -- setupbottom、right
- (void)setTF_viewRight:(CGFloat)TF_viewRight {
    self.TF_viewX = TF_viewRight - self.TF_viewWidth;
}

- (CGFloat)TF_viewRight {
    return CGRectGetMaxX(self.frame);
}
- (void)setTF_viewBottom:(CGFloat)TF_viewBottom {
    self.TF_viewY = TF_viewBottom - self.TF_viewHeight;
}
- (CGFloat)TF_viewBottom {
    return CGRectGetMaxY(self.frame);
}


#pragma mark -- 截屏
- (UIImage *)TF_capturedImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    UIImage *result = nil;
    if ([self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES]) {
        result = UIGraphicsGetImageFromCurrentImageContext();
    }
    
    UIGraphicsEndImageContext();
    
    return result;
}


@end
