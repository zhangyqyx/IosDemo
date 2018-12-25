//
//  ZYQSphereView.m
//  SphereTagDemo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQSphereView.h"
#import "ZYQMatrix.h"
@interface ZYQSphereView ()<UIGestureRecognizerDelegate>{
    NSMutableArray *tags;
    NSMutableArray *coordinate;
    ZYQPoint normalDirection;
    CGPoint last;
    CGFloat velocity;
    CADisplayLink *timer;
    CADisplayLink *inertia;
    
}

@end

@implementation ZYQSphereView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sphereType = ZYQSphereDefaultType;
        self.size = 80;
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:gesture];
    }
    return self;
}
#pragma mark - shetupItem
- (void)createItem:(NSArray<ZYQSphereModel *> *)arrays  {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    tags = [NSMutableArray arrayWithCapacity:arrays.count];
    coordinate = [NSMutableArray array];
    for (ZYQSphereModel *model in arrays) {
        UIButton *btn = [self createBtnWithModel:model];
        [tags addObject:btn];
    }
    CGFloat p1 = M_PI * (3 - sqrt(5));
    CGFloat p2 = 2.0 / tags.count;
    
    for (NSInteger i = 0; i < tags.count; i ++) {
        
        CGFloat y = i * p2 - 1 + (p2 / 2);
        CGFloat r = sqrt(1 - y * y);
        CGFloat p3 = i * p1;
        CGFloat x = cos(p3) * r;
        CGFloat z = sin(p3) * r;
        
        
        ZYQPoint point = ZYQPointMake(x, y, z);
        NSValue *value = [NSValue value:&point withObjCType:@encode(ZYQPoint)];
        [coordinate addObject:value];
        
        CGFloat time = (arc4random() % 10 + 10.) / 20.;
        [UIView animateWithDuration:time delay:0. options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self setTagOfPoint:point andIndex:i];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    NSInteger a =  arc4random() % 10 - 5;
    NSInteger b =  arc4random() % 10 - 5;
    normalDirection = ZYQPointMake(a, b, 0);
    [self startAnimation];
}

- (void)setTagOfPoint: (ZYQPoint)point andIndex:(NSInteger)index
{
    UIView *view = [tags objectAtIndex:index];
    view.center = CGPointMake((point.x + 1) * (self.frame.size.width / 2.), (point.y + 1) * self.frame.size.width / 2.);
    
    CGFloat transform = (point.z + 2) / 3;
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, transform, transform);
    view.layer.zPosition = transform;
    view.alpha = transform;
    if (point.z < 0) {
        view.userInteractionEnabled = NO;
    }else {
        view.userInteractionEnabled = YES;
    }
}


- (UIButton *)createBtnWithModel:(ZYQSphereModel *)model {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:model.title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:model.imageStr] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255. green:arc4random_uniform(255)/255. blue:arc4random_uniform(255)/255. alpha:1.];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20.];
    CGFloat width = self.size;
    if (self.sphereType == ZYQSphereRandomType) {
        width = 40 + arc4random_uniform(80);
    }
    btn.frame = CGRectMake(0, 0, width, width);
    btn.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    btn.layer.cornerRadius = width * 0.5;
    btn.clipsToBounds = YES;
    btn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
    [self addSubview:btn];
    btn.highlighted = false;
    return btn;
}



#pragma mark -  开始动画
- (void)startAnimation {
    timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoTurnRotation)];
    [timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
- (void)autoTurnRotation{
    for (NSInteger i = 0; i < tags.count; i ++) {
        [self updateFrameOfPoint:i direction:normalDirection andAngle:0.002];
    }
    
}

- (void)updateFrameOfPoint:(NSInteger)index direction:(ZYQPoint)direction andAngle:(CGFloat)angle{
    NSValue *value = [coordinate objectAtIndex:index];
    ZYQPoint point;
    [value getValue:&point];
    
    ZYQPoint rPoint = ZYQPointMakeRotation(point, direction, angle);
    value = [NSValue value:&rPoint withObjCType:@encode(ZYQPoint)];
    coordinate[index] = value;
    [self setTagOfPoint:rPoint andIndex:index];
}

- (void)stopAnimation {
    [timer invalidate];
    timer = nil;
}


#pragma mark - 按钮点击

- (void)buttonPressed:(UIButton *)btn{
     [self stopAnimation];
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2., 2.);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            if (self.delegate) {
                [self.delegate ZYQSphereView:self touchView:btn];
            }else {
                  [self startAnimation];
            }
        }];
    }];
}
- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}

#pragma mark - 触摸

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        last = [gesture locationInView:self];
        [self stopAnimation];
        [self inertiaStop];
        
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint current = [gesture locationInView:self];
        ZYQPoint direction = ZYQPointMake(last.y - current.y, current.x - last.x, 0);
        
        CGFloat distance = sqrt(direction.x * direction.x + direction.y * direction.y);
        
        CGFloat angle = distance / (self.frame.size.width / 2.);
        
        for (NSInteger i = 0; i < tags.count; i ++) {
            [self updateFrameOfPoint:i direction:direction andAngle:angle];
        }
        normalDirection = direction;
        last = current;
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocityP = [gesture velocityInView:self];
        velocity = sqrt(velocityP.x * velocityP.x + velocityP.y * velocityP.y);
        [self inertiaStart];
        
    }
}

- (void)inertiaStart{
    [self stopAnimation];
    inertia = [CADisplayLink displayLinkWithTarget:self selector:@selector(inertiaStep)];
    [inertia addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)inertiaStop{
    [inertia invalidate];
    inertia = nil;
    [self startAnimation];
}

- (void)inertiaStep{
    if (velocity <= 0) {
        [self inertiaStop];
    }else {
        velocity -= 70.;
        CGFloat angle = velocity / self.frame.size.width * 2. * inertia.duration;
        for (NSInteger i = 0; i < tags.count; i ++) {
            [self updateFrameOfPoint:i direction:normalDirection andAngle:angle];
        }
    }
    
}


@end
