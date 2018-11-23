//
//  ZYQDripView.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQDripView.h"

@interface ZYQDripView ()
@property (nonatomic, strong) UIColor *color;
@end

@implementation ZYQDripView

- (instancetype)initWithColor:(UIColor *)color;
{
    self = [super init];
    if (self) {
        _color = color;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, self.bounds.size.width * 0.5f, 0);
    
    [[UIColor clearColor] set];
    CGContextSetLineWidth(context, 1.0);
    CGContextAddCurveToPoint(context,
                             0,
                             self.bounds.size.height,
                             self.bounds.size.width,
                             self.bounds.size.height,
                             self.bounds.size.width * 0.5f,
                             0);
    CGContextSetFillColorWithColor(context,self.color.CGColor);
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
    
}


@end
