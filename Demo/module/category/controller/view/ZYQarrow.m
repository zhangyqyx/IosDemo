//
//  ZYQarrow.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/13.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQarrow.h"

@implementation ZYQarrow

- (void)drawRect:(CGRect)rect {
    CGFloat width = self.frame.size.width;
    CGFloat heigth = self.frame.size.height;
     CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.isCrosswise) {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 2.5);
        //第一个箭头
        CGContextMoveToPoint(context, 9.5, 2.5);
        CGContextAddLineToPoint(context, 2.5, (heigth-2.5) * 0.5);
        CGContextAddLineToPoint(context, 9.5, heigth -5);
        //直线
        CGContextMoveToPoint(context, 2.5, (heigth-2.5) * 0.5);
        CGContextAddLineToPoint(context, width - 5, (heigth-2.5) * 0.5);
        //第二个箭头
        CGContextMoveToPoint(context, width-7-2.5, 2.5);
        CGContextAddLineToPoint(context, width - 2.5, (heigth-2.5) * 0.5);
        CGContextAddLineToPoint(context, width-7-2.5, heigth -5);
        CGContextStrokePath(context);
        CGContextClip(context);
    }else {
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 2.5);
        //第一个箭头
        CGContextMoveToPoint(context, 2.5, 9.5);
        CGContextAddLineToPoint(context,(width-2.5) * 0.5 ,2.5 );
        CGContextAddLineToPoint(context, width -5, 9.5);
        //直线
        CGContextMoveToPoint(context, (width-2.5) * 0.5, 2.5);
        CGContextAddLineToPoint(context,(width-2.5) * 0.5 , heigth - 5);
        //第二个箭头
        CGContextMoveToPoint(context,2.5 , heigth-7-2.5);
        CGContextAddLineToPoint(context,(width-2.5) * 0.5 , heigth - 2.5);
        CGContextAddLineToPoint(context,width - 5 , heigth-7-2.5);
        CGContextStrokePath(context);
        CGContextClip(context);
        
    }
 
}


@end
