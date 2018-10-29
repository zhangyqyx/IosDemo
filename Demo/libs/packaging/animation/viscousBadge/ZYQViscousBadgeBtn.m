//
//  ZYQViscousBadgeBtn.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQViscousBadgeBtn.h"

@interface ZYQViscousBadgeBtn()

/**小圆 */
@property(strong , nonatomic)UIView *smallCircelView;
/**小圆半径 */
@property(nonatomic,assign)CGFloat smallRadius;
/**layer */
@property(nonatomic,strong)CAShapeLayer *shapelayer;

/** 超过99显示的label */
@property(nonatomic,strong)UILabel *maxNumberLabel;


@end
@implementation ZYQViscousBadgeBtn

#pragma mark - 懒加载
- (UIView *)smallCircelView {
    if (!_smallCircelView) {
        _smallCircelView = [[UIView alloc] init];
        _smallCircelView.backgroundColor = self.backgroundColor;
        [self.superview insertSubview:_smallCircelView belowSubview:self];
    }
    return  _smallCircelView;
}
- (CAShapeLayer *)shapelayer {
    if (!_shapelayer) {
        _shapelayer = [CAShapeLayer layer];
        _shapelayer.fillColor = self.backgroundColor.CGColor;
        [self.superview.layer insertSublayer:_shapelayer below:self.layer];
    }
    return _shapelayer;
}
- (UILabel *)maxNumberLabel {
    if (!_maxNumberLabel) {
        _maxNumberLabel = [[UILabel alloc] init];
        _maxNumberLabel.text = @"99+";
        _maxNumberLabel.font = [UIFont systemFontOfSize:self.fontSize];
        _maxNumberLabel.textColor = self.titleColor;
        _maxNumberLabel.backgroundColor = self.backgroundColor;
        _maxNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self.superview addSubview:_maxNumberLabel];
    }
    return _maxNumberLabel;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initProperty];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setup];
        });
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self initProperty];
    [self setup];
}


#pragma mark - 初始化一些设置
- (void)setup {
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    _smallRadius = self.frame.size.width *0.5;
    [self setupValue];
    //添加拖拽手势
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:panG];
    [self setupSmallView];
}
- (void)initProperty {
    self.titleColor = [UIColor whiteColor];
    self.circleColor = [UIColor redColor];
    self.maxDistance =  60;
    self.fontSize = 12;
}
- (void)setupValue {
    self.backgroundColor = self.circleColor;
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
}


- (void)setupSmallView {
    self.smallCircelView.frame = self.bounds;
    _smallCircelView.center = self.center;
    _smallCircelView.layer.cornerRadius = self.frame.size.width * 0.5;
}


#pragma mark - 手势操作
- (void)pan:(UIPanGestureRecognizer *)panG {
    
    [self.superview insertSubview:_smallCircelView belowSubview:self];
    //获取手指偏移
    CGPoint panT = [panG translationInView:self];
    CGPoint center = self.center;
    center.x += panT.x;
    center.y += panT.y;
    self.center = center;
    [panG setTranslation:CGPointZero inView:self];
    //设置最大文字label的位置
    [self setupLabelCenter:center];
    
    CGFloat d = [self circleCenterDistanceWithBigCircleCenter:self.center smallCircleCenter:_smallCircelView.center];
    //根据两点之间的距离缩小小红点
    [self lessenSmallViewWithDistance:d];
    if (d > self.maxDistance) {
        //        _smallCircelView.hidden = true;
        // 移除不规则的矩形
        [self.shapelayer removeFromSuperlayer];
        self.shapelayer = nil;
    }else if (d > 0 && _smallCircelView.hidden == false){
        //设置路径
        [self setupBezierPathWithDistance:d];
    }
    
    //如果手指抬起，位置还原 ,如果手指位置超过了最大距离，消失
    if (panG.state == UIGestureRecognizerStateEnded) {
        if (d > self.maxDistance) {
            [self removeView];
            return;
        }
        [self resumeLocation];
    }
}
- (void)lessenSmallViewWithDistance:(CGFloat)distance {
    CGFloat smallRadius = _smallRadius - distance * 0.1;
    if (smallRadius < 0 || distance > self.maxDistance ) {
        smallRadius = 0;
    }
    _smallCircelView.bounds = CGRectMake(0, 0, smallRadius *2, smallRadius *2);
    _smallCircelView.layer.cornerRadius = smallRadius;
    
}

- (void)resumeLocation{
    [self.shapelayer removeFromSuperlayer];
    self.shapelayer = nil;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.center = self.smallCircelView.center;
        self.maxNumberLabel.center = self.smallCircelView.center;
    } completion:^(BOOL finished) {
        //        _smallCircelView.hidden = false;
    }];
}
- (void)removeView{
    
    [_maxNumberLabel removeFromSuperview];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d" , i + 1]];
        [images addObject:image];
    }
    imageView.animationImages = images;
    imageView.animationDuration = 0.5;
    imageView.animationRepeatCount = 1;
    
    [imageView startAnimating];
    [self addSubview:imageView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        [self.smallCircelView removeFromSuperview];
        if (self.block) {
            self.block(self);
        }
    });
}
- (void)setupLabelCenter:(CGPoint)center {
    self.maxNumberLabel.center = center;
}


#pragma mark - 计算两圆之间距离
- (CGFloat)circleCenterDistanceWithBigCircleCenter:(CGPoint)bigCircleCenter smallCircleCenter:(CGPoint)smallCircleCenter {
    CGFloat offsetX = bigCircleCenter.x - smallCircleCenter.x;
    CGFloat offsetY = bigCircleCenter.y - smallCircleCenter.y;
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}
#pragma mark - 设置路径
- (void)setupBezierPathWithDistance:(CGFloat)d {
    CGFloat x1 = _smallCircelView.center.x;
    CGFloat y1 = _smallCircelView.center.y;
    CGFloat r1 = _smallCircelView.frame.size.width * 0.5;
    
    CGFloat x2 = self.center.x;
    CGFloat y2 = self.center.y;
    CGFloat r2 = self.frame.size.width * 0.5;
    
    CGFloat cos = (y2 - y1) / d;
    CGFloat sin = (x2 - x1) / d;
    
    CGPoint pointA = CGPointMake(x1 - r1 * cos, y1 + r1 * sin);
    CGPoint pointB = CGPointMake(x1 + r1 * cos, y1 - r1 * sin);
    CGPoint pointC = CGPointMake(x2 + r2 * cos, y2 - r2 * sin);
    CGPoint pointD = CGPointMake(x2 - r2 * cos, y2 + r2 * sin);
    
    CGPoint pointO = CGPointMake(pointA.x + d/2 * sin, pointA.y + d/2 * cos);
    CGPoint pointP = CGPointMake(pointB.x + d/2 * sin, pointB.y + d/2 * cos);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:pointA];
    [bezierPath addLineToPoint:pointB];
    [bezierPath addQuadCurveToPoint:pointC controlPoint:pointP];
    [bezierPath addLineToPoint:pointD];
    [bezierPath addQuadCurveToPoint:pointA controlPoint:pointO];
    self.shapelayer.path = bezierPath.CGPath;
    
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    [self setupValue];
}
- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    [self setupValue];
}
- (void)setFontSize:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self setupValue];
}
- (void)setMaxDistance:(CGFloat)maxDistance {
    _maxDistance = maxDistance;
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    if ([title integerValue] > 99) {
        self.maxNumberLabel.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        self.maxNumberLabel.center = self.center;
        self.maxNumberLabel.layer.cornerRadius = self.frame.size.height * 0.5;
        self.maxNumberLabel.clipsToBounds = true;
        [self setTitle:@"" forState:UIControlStateNormal];
    }
    
}




@end
