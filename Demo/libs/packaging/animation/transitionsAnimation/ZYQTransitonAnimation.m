//
//  ZYQTransitonAnimation.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQTransitonAnimation.h"


@interface ZYQTransitonAnimation ()<CAAnimationDelegate>{
    
    CGRect _anchorRect;
    
    NSObject<UIViewControllerContextTransitioning> *_transitionContext;
    
    CAShapeLayer *_maskLayer;
}

@end

@implementation ZYQTransitonAnimation
#pragma mark -- 初始化方法
- (nonnull instancetype)initWithAnchorRect:(CGRect)anchorRect {
    if (self = [super init]) {
        _anchorRect = anchorRect;
        _animationType = ZYQBgCircularAnimationType;
    }
    return self;
}
+ (nonnull instancetype)transitionWithRect:(CGRect)anchorRect {
    ZYQTransitonAnimation *transition = [[ZYQTransitonAnimation alloc] initWithAnchorRect:anchorRect];
    return transition;
}
#pragma mark -- 转场动画代理
//转场动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (_transitonType == ZYQTransitonAnimationTypeShow) {
        if (_animationType == ZYQBgCircularAnimationType) {
            [self showMaskAnimationTo:transitionContext];
            [self showScaleAnimationTo:transitionContext];
            return;
        }
        [self circularTypeTransition:transitionContext presenting:true];
    }else if (_transitonType == ZYQTransitonAnimationTypeHide) {
        if (_animationType == ZYQBgCircularAnimationType) {
            [self hideMaskAnimationTo:transitionContext];
            [self hideScaleAnimationTo:transitionContext];
            return;
        }
        [self circularTypeTransition:transitionContext presenting:false];
    }
}
#pragma mark - TLAnimatorTypeCircular
- (void)circularTypeTransition:(id<UIViewControllerContextTransitioning>)transitionContext presenting:(BOOL)isPresenting {
    _transitionContext      = transitionContext;
    CGPoint center = CGPointMake( _anchorRect.size.width * 0.5 +_anchorRect.origin.x  , _anchorRect.size.height * 0.5 +_anchorRect.origin.y);
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *traget = isPresenting ? toVC : fromVC;
    UIView *containerView = transitionContext.containerView;
    if(isPresenting) {
        [containerView addSubview:toVC.view];
    }
    if (!isPresenting ) {
        [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    }
    
    if (CGPointEqualToPoint(center, CGPointZero)) {
        center = traget.view.center;
    }
    
    CGFloat W = traget.view.frame.size.width;
    CGFloat H = traget.view.frame.size.height;
    
    CGFloat x = MAX(center.x, W - center.x);
    CGFloat y = MAX(center.y, H - center.y);
    CGFloat endRadius = sqrt(x * x + y * y);
    CGFloat startRadius =  MIN(_anchorRect.size.width, _anchorRect.size.height);
    
    CGFloat radius = isPresenting ? startRadius : endRadius;
    CGFloat radius2 = !isPresenting ? startRadius : endRadius;
    CGRect rect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2);
    CGRect rect2 = CGRectMake(center.x - radius2, center.y - radius2, radius2 * 2, radius2 * 2);
    CGPathRef path = CGPathCreateWithEllipseInRect(rect, nil);
    CGPathRef path2 = CGPathCreateWithEllipseInRect(rect2, nil);
    
    CABasicAnimation *anm = [CABasicAnimation animationWithKeyPath:@"path"];
    anm.fromValue =  (__bridge id _Nullable)(path);
    anm.toValue = (__bridge id _Nullable)(path2);
    anm.duration = [self transitionDuration:transitionContext];
    anm.delegate = self;
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    traget.view.layer.mask = mask;
    
    mask.path = path2;
    mask.fillRule = kCAFillRuleEvenOdd;
    [mask addAnimation:anm forKey:@"path"];
    [mask setNeedsDisplay];
   
}

#pragma mark -- 显示隐藏方法
//显示圆形放大动画
- (void)showMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext      = transitionContext;
    
    UIView *fromView        = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView          = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contView        = [transitionContext containerView];
    [contView addSubview:fromView];
    [contView addSubview:toView];
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.bounds        = fromView.layer.bounds;
    maskLayer.position      = fromView.layer.position;
    if (self.transitonColor) {
        maskLayer.fillColor     = self.transitonColor.CGColor;
    }else {
       maskLayer.fillColor     = toView.backgroundColor.CGColor;
    }
    [fromView.layer addSublayer:maskLayer];
    _maskLayer              = maskLayer;
    //开始的圆环
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:_anchorRect];
    //结束时候的圆环
    CGFloat radius          = [self radiusOfInView:toView startPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_anchorRect, -radius, -radius)];
    //图形放大动画
    maskLayer.path = finalPath.CGPath;
    CABasicAnimation *maskLayerAnimation    = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue            = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue              = (__bridge id)(finalPath.CGPath);
    maskLayerAnimation.duration             = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    maskLayerAnimation.delegate             = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}
//显示---位置和缩放效果
-(void)showScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView                      = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.layer.position               = CGPointMake(CGRectGetMidX(toView.bounds), CGRectGetMidY(toView.bounds));
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue         = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    positionAnimation.toValue           = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(toView.bounds), CGRectGetMidY(toView.bounds))];
    positionAnimation.duration          = [self transitionDuration:transitionContext];
    positionAnimation.timingFunction    = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:positionAnimation forKey:@"position"];
    
    toView.transform                    = CGAffineTransformMakeScale(1.0, 1.0);
    CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue            = @(0);
    scaleAnimation.toValue              = @(1);
    scaleAnimation.duration             = [self transitionDuration:transitionContext];
    scaleAnimation.timingFunction       = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:scaleAnimation forKey:@"scale"];
}
//隐藏--圆形放大动画
-(void)hideMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    _transitionContext              = transitionContext;
    UIView *fromView                = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView                  = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contView                = [transitionContext containerView];
    [contView addSubview:toView];
    [contView addSubview:fromView];
    
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer         = [CAShapeLayer layer];
    maskLayer.bounds                = toView.layer.bounds;
    maskLayer.position              = toView.layer.position;
    if (self.transitonColor) {
        maskLayer.fillColor     = self.transitonColor.CGColor;
    }else {
        maskLayer.fillColor     = toView.backgroundColor.CGColor;
    }
    //    fromView.layer.mask = maskLayer;
    [toView.layer addSublayer:maskLayer];
    _maskLayer                      = maskLayer;
    
    //结束圆环
    CGFloat radius                  = [self radiusOfInView:toView startPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    //开始的圆环
    UIBezierPath *startPath         =  [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_anchorRect, - radius, - radius)];
    UIBezierPath *finalPath         = [UIBezierPath bezierPathWithOvalInRect:_anchorRect];
    
    //放大动画
    //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.path                          = finalPath.CGPath;
    CABasicAnimation *maskLayerAnimation    = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue            = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue              = (__bridge id)((finalPath.CGPath));
    maskLayerAnimation.duration             = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction       = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}


//隐藏---位置和缩放效果
-(void)hideScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView                    = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //位移动画
    fromView.layer.position             = CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect));
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue         = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(fromView.bounds), CGRectGetMidY(fromView.bounds))];
    positionAnimation.toValue           = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(_anchorRect), CGRectGetMidY(_anchorRect))];
    positionAnimation.duration          = [self transitionDuration:transitionContext];
    positionAnimation.timingFunction    = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.delegate          = self;
    [fromView.layer addAnimation:positionAnimation forKey:@"position"];
    
    //缩放动画
    fromView.transform                  = CGAffineTransformMakeScale(0.0, 0.0);
    CABasicAnimation *scaleAnimation    = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue            = @(1);
    scaleAnimation.toValue              = @(0);
    scaleAnimation.duration             = [self transitionDuration:transitionContext];
    scaleAnimation.timingFunction       = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [fromView.layer addAnimation:scaleAnimation forKey:@"scale"];
}
#pragma mark -- 确定较长的半径
- (CGFloat)radiusOfInView:(UIView *)view startPoint:(CGPoint)startPoint {
    CGPoint point1          = CGPointMake(0, 0);
    CGPoint point2          = CGPointMake(view.bounds.size.width, 0);
    CGPoint point3          = CGPointMake(0 ,view.bounds.size.height);
    CGPoint point4          = CGPointMake(view.bounds.size.width,view.bounds.size.height);
    NSArray *pointArray     = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4]];
    //做一个排序获得最长的半径
    CGFloat radius          = 0;
    for (NSValue *value in pointArray) {
        CGPoint point       = [value CGPointValue];
        CGFloat apartX      = point.x - startPoint.x;
        CGFloat apartY      = point.y - startPoint.y;
       CGFloat maxRadius    = sqrt(apartX * apartX + apartY * apartY);
        if (maxRadius >= radius) {
            radius          = maxRadius;
        }
    }
    return radius;
}

#pragma mark -- 停止动画
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //通知上下文 动画结束
    [_transitionContext completeTransition:![_transitionContext transitionWasCancelled]];
     //移除遮罩layer
    [_maskLayer removeFromSuperlayer];
    _maskLayer = nil;
}

@end


























