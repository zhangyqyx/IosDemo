//
//  ZYQPopOver.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/12.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQPopOver.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ZYQPopOver()
/** 顶点 */
@property(nonatomic , assign)CGPoint origin;
/** 宽 */
@property (nonatomic, assign) CGFloat height;
/** 高 */
@property (nonatomic, assign) CGFloat width;
/** 方向 */
@property (nonatomic, assign) ZYQArrowDirection direction;


@end

@implementation ZYQPopOver

- (instancetype)initWithOrigin:(CGPoint)origin
                         width:(CGFloat)width
                        height:(CGFloat)height
                     direction:(ZYQArrowDirection)direction {
    if (self == [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        //背景颜色为无色
        self.backgroundColor=[UIColor clearColor];
        
        //定义显示视图的参数
        self.origin = origin;
        self.height = height;
        self.width = width;
        self.direction = direction;
        self.arrowSize = self.arrowSize;
        self.arrowColor = self.backgroundColor;
        self.arrowMargin = 20;
        
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        self.alertView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
        [self addSubview:self.alertView];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    switch (_direction) {
        case ZYQArrowDirectionLeftUp|ZYQArrowDirectionLeftCenter|ZYQArrowDirectionLeftBottom:
            {
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, startX+self.arrowSize, startY -self.arrowSize);
            CGContextAddLineToPoint(context, startX +self.arrowSize, startY +self.arrowSize);
            }
            break;
        case ZYQArrowDirectionRightUp|
            ZYQArrowDirectionRightCenter|
            ZYQArrowDirectionRightBottom:
        {
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, startX-self.arrowSize, startY -self.arrowSize);
            CGContextAddLineToPoint(context, startX -self.arrowSize, startY +self.arrowSize);
        }
            break;
        case ZYQArrowDirectionDownLeft|
            ZYQArrowDirectionDownRight|
            ZYQArrowDirectionDownCenter:
        {
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, startX-self.arrowSize, startY -self.arrowSize);
            CGContextAddLineToPoint(context, startX +self.arrowSize, startY -self.arrowSize);
        }
        break;
        default:
           {
            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, startX-self.arrowSize, startY +self.arrowSize);
            CGContextAddLineToPoint(context, startX+self.arrowSize, startY +self.arrowSize);
          }
        break;
    }
    [self.arrowColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextClosePath(context);
}






#pragma mark - 弹出视图
- (void)popView {
    NSArray *result=[self.alertView subviews];
    for (UIView *view in result) {
        view.hidden=YES;
    }
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
   
    if ([self setupLeft]) {return;}
    if ([self setupRight]) {return;}
    if ([self setupUp]) {return;}
    if ([self setupBottom]) {return;}

    
    
}

- (BOOL)setupLeft {
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    CGFloat width = self.width;
    CGFloat heigt = self.height;
    if (_direction == ZYQArrowDirectionLeftUp) {
        [self showAnimation:CGRectMake(startX+self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX+self.arrowSize, startY - self.arrowMargin, width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionLeftCenter) {
        [self showAnimation:CGRectMake(startX+self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX+self.arrowSize, startY - heigt * 0.5, width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionLeftBottom) {
        [self showAnimation:CGRectMake(startX+self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX+self.arrowSize, startY - heigt + self.arrowMargin, width, heigt) duration:0.2];
        return true;
    }
    return false;
}
- (BOOL)setupRight {
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    CGFloat width = self.width;
    CGFloat heigt = self.height;
    if (_direction == ZYQArrowDirectionRightUp) {
        [self showAnimation:CGRectMake(startX-self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX-self.arrowSize, startY - self.arrowMargin, -width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionRightCenter) {
        [self showAnimation:CGRectMake(startX-self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX-self.arrowSize, startY - heigt * 0.5, -width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionRightBottom) {
        [self showAnimation:CGRectMake(startX-self.arrowSize, startY, 0, 0) targetFrame:CGRectMake(startX-self.arrowSize, startY - heigt + self.arrowMargin, -width, heigt) duration:0.2];
        return true;
    }
    return false;
}

- (BOOL)setupUp {
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    CGFloat width = self.width;
    CGFloat heigt = self.height;
    if (_direction == ZYQArrowDirectionUpLeft) {
        [self showAnimation:CGRectMake(startX, startY+self.arrowSize, 0, 0) targetFrame:CGRectMake(startX - self.arrowMargin, startY+self.arrowSize, width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionUpCenter) {
      [self showAnimation:CGRectMake(startX, startY+self.arrowSize, 0, 0) targetFrame:CGRectMake(startX - width * 0.5, startY+self.arrowSize, width, heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionUpRight) {
       [self showAnimation:CGRectMake(startX, startY+self.arrowSize, 0, 0) targetFrame:CGRectMake(startX-width + self.arrowMargin, startY+self.arrowSize, width, heigt) duration:0.2];
        return true;
    }
    return false;
}
- (BOOL)setupBottom {
    CGFloat startX = self.origin.x;
    CGFloat startY = self.origin.y;
    CGFloat width = self.width;
    CGFloat heigt = self.height;
    if (_direction == ZYQArrowDirectionDownLeft) {
        [self showAnimation:CGRectMake(startX, startY-self.arrowSize, 0, 0) targetFrame:CGRectMake(startX - self.arrowMargin, startY-self.arrowSize, width, -heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionDownCenter) {
        [self showAnimation:CGRectMake(startX - width * 0.5, startY-self.arrowSize, 0, 0) targetFrame:CGRectMake(startX - width * 0.5, startY-self.arrowSize, width, -heigt) duration:0.2];
        return true;
    }
    if (_direction == ZYQArrowDirectionDownRight) {
        [self showAnimation:CGRectMake(startX, startY-self.arrowSize, 0, 0) targetFrame:CGRectMake(startX-width + self.arrowMargin, startY-self.arrowSize, width, -heigt) duration:0.2];
        return true;
    }
    return false;
}

- (void)showAnimation:(CGRect)sourceFrame
          targetFrame:(CGRect)targetFrame
             duration:(CGFloat)duration {
    //动画效果弹出
    self.alpha = 0;
    self.alertView.frame = sourceFrame;
    [UIView animateWithDuration:duration animations:^{
        self.alpha =1;
        self.alertView.frame = targetFrame;
    } completion:^(BOOL finished) {
        NSArray *result=[self.alertView subviews];
        for (UIView *view in result) {
            
            view.hidden=NO;
            
        }
    }];
}



#pragma mark - 视图消失
- (void)dissmissView {
    NSArray *result=[self.alertView subviews];
    for (UIView *view in result) {
        [view removeFromSuperview];
    }
    //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.alertView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.alertView]) {
        [self dissmissView];
    }
}






@end
