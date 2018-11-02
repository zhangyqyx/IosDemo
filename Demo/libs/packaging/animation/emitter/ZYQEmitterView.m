//
//  ZYQEmitterView.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQEmitterView.h"

@interface ZYQEmitterView()
/** 动画 */
@property (nonatomic, strong) CAEmitterLayer *emitterlayer;
/** type */
@property(nonatomic , assign)ZYQEmitterType type;



@end

@implementation ZYQEmitterView
/**
 创建粒子动画
 @param type 动画类
 @param superView 父视图
 */
- (void)createEmitterAnimation:(ZYQEmitterType)type
                             superView:(UIView *)superView {
    self.type = type;
    if (type == ZYQRedPacketEmitterType) {
        [self createRedPacketSuperView:superView];
    }
    if (type == ZYQSnowflakeEmitterType) {
        [self createSnowflakeSuperView:superView];
    }
    if (type == ZYQRainEmitterType) {
        [self createRainSuperView:superView];
    }
    if (type == ZYQBallEmitterType) {
        [self createBallSuperView:superView];
    }
    if (type == ZYQLoveEmitterType) {
        [self createLoveSuperView:superView];
    }
    if (type == ZYQRibbonEmitterType) {
        [self createRibbonSuperView:superView];
    }
    if (type == ZYQFireEmitterType) {
        [self createFireSuperView:superView];
    }
    
}
#pragma mark - 动画效果
//下红包雨
- (void)createRedPacketSuperView:(UIView *)superView {
    //设置EmitterLayer
    CAEmitterLayer *redPacketLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:redPacketLayer];
    self.emitterlayer = redPacketLayer;
    redPacketLayer.emitterShape = kCAEmitterLayerLine;// 发射源的形状
    redPacketLayer.emitterMode = kCAEmitterLayerSurface;//发射模式
    redPacketLayer.emitterSize = superView.frame.size;//发射源的size 决定了发射源的大小
    redPacketLayer.emitterPosition = CGPointMake(superView.frame.size.width * 0.5, superView.frame.origin.y);//发射源的位置
    redPacketLayer.birthRate = 0.0f; // 每秒产生的粒子数量的系数
    //配置EmitterCell
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/red_packet.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    emitterCell.contents = (id)[[UIImage imageWithData:data] CGImage];// 粒子的内容 是CGImageRef类型
    emitterCell.birthRate = 10.0f;// 每秒产生的粒子数量
    emitterCell.lifetime = 20.0f;// 粒子的生命周期
    emitterCell.velocity = 8.f;  // 粒子的速度
    emitterCell.yAcceleration = 1000.f; // 粒子再y方向的加速的
    emitterCell.scale = 0.8;  // 粒子的缩放比例
    
    redPacketLayer.emitterCells = @[emitterCell];
}
//下雪
- (void)createSnowflakeSuperView:(UIView *)superView {
    CAEmitterLayer *snowflakeLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:snowflakeLayer];
    self.emitterlayer = snowflakeLayer;
    snowflakeLayer.emitterShape = kCAEmitterLayerLine;
    snowflakeLayer.emitterMode = kCAEmitterLayerSurface;
    snowflakeLayer.emitterSize = superView.frame.size;
    snowflakeLayer.emitterPosition = CGPointMake(superView.frame.size.width * 0.5, superView.frame.origin.y);
    
    snowflakeLayer.birthRate = 0.f;
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/snow_white.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    emitterCell.contents = (id)[[UIImage imageWithData:data] CGImage];
    emitterCell.birthRate = 1.f;
    emitterCell.lifetime = 150.f;
    emitterCell.speed = 10.f;
    emitterCell.velocity = 2.0f;
    emitterCell.velocityRange = 10.f;//速度范围
    emitterCell.yAcceleration = 15.f;
    
    emitterCell.scale = 0.5f;
    emitterCell.scaleRange = 0.2f;
    
    emitterCell.emissionLongitude = M_PI_2;// 指定经度,经度角代表了在x-y轴平面坐标系中与x轴之间的夹角，默认0:,M_PI_2代表向下
    emitterCell.emissionRange = M_PI_2;//发射角度范围,默认0，以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内;
    snowflakeLayer.emitterCells = @[emitterCell];
}
//下雨
- (void)createRainSuperView:(UIView *)superView {
    CAEmitterLayer *rainLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:rainLayer];
    self.emitterlayer = rainLayer;
    
    rainLayer.emitterShape = kCAEmitterLayerLine;
    rainLayer.emitterMode = kCAEmitterLayerSurface;
    rainLayer.emitterSize = superView.frame.size;
    rainLayer.emitterPosition = CGPointMake(superView.frame.size.width * 0.5, 0);
    rainLayer.birthRate = 0.f;
    
    CAEmitterCell *rainCell = [CAEmitterCell emitterCell];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/rain_white.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    rainCell.contents = (id)[[UIImage imageWithData:data] CGImage];
    rainCell.birthRate = 10.f;
    rainCell.lifetime = 10.f;
    rainCell.speed = 10.0f;
    
    rainCell.velocity = 10.f;
    rainCell.velocityRange = 20.f;
    rainCell.yAcceleration = 1000.f;
    
    rainCell.scale = 0.1f;
    rainCell.scaleRange = 0.2f;
    
    rainLayer.emitterCells = @[rainCell];
    
}
//五彩球
- (void)createBallSuperView:(UIView *)superView {
    CAEmitterLayer *ballLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:ballLayer];
    self.emitterlayer = ballLayer;
    
    ballLayer.emitterShape = kCAEmitterLayerPoint;
    ballLayer.emitterMode = kCAEmitterLayerPoints;
    ballLayer.emitterSize = superView.frame.size;
    ballLayer.emitterPosition = CGPointMake(superView.frame.size.width, 0);
    ballLayer.birthRate = 0.f;
    
    CAEmitterCell *ballCell = [CAEmitterCell emitterCell];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/circle_white.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    ballCell.contents = (id)[[UIImage imageWithData:data] CGImage];
    ballCell.name = @"BallCell";
    
    ballCell.birthRate = 20.f;
    ballCell.lifetime = 10.f;
    
    ballCell.velocity = 40.f;
    ballCell.velocityRange = 100.f;
    ballCell.yAcceleration = 15.f;
    
    ballCell.emissionLongitude = M_PI; // 向左
    ballCell.emissionRange = M_PI_4; // 围绕X轴向左90度
    
    ballCell.scale = 0.2;
    ballCell.scaleRange = 0.1;
    ballCell.scaleSpeed = 0.02;
    
    ballCell.color = [[UIColor colorWithRed:0.5 green:0.f blue:0.5 alpha:1.f] CGColor];
    ballCell.redRange = 1.f;
    ballCell.greenRange = 1.f;
    ballCell.blueSpeed = 1.f;
    ballCell.alphaRange = 0.8;
    ballCell.alphaSpeed = -0.1f;
    
    ballLayer.emitterCells = @[ballCell];
    
}
//爱心效果
- (void)createLoveSuperView:(UIView *)superView {
    [self createHeartSuperView:superView];
    [self createLoveAnimation:superView];
}
- (void)createHeartSuperView:(UIView *)superView {
    CAEmitterLayer *heartLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:heartLayer];
    
    heartLayer.renderMode = kCAEmitterLayerOldestFirst;
    heartLayer.birthRate = 1.0f;
    heartLayer.emitterPosition = CGPointMake(0, superView.frame.size.height);
    
    CAEmitterCell *heartRedCell = [CAEmitterCell emitterCell];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/Heart_red.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    heartRedCell.contents = (id)[[UIImage imageWithData:data] CGImage];
    heartRedCell.scale = 0.5f;
    heartRedCell.lifetime = 10.0f;
    heartRedCell.alphaSpeed = -0.1f;
    heartRedCell.birthRate = 10.0f;
    heartRedCell.velocity = 100.0f;
    heartRedCell.yAcceleration = 20.0f;
    heartRedCell.emissionLongitude = -M_PI_4;
    heartRedCell.emissionRange = M_PI_4;
    heartRedCell.spinRange = M_PI_2;
    CAEmitterCell *heartBlueCell = [CAEmitterCell emitterCell];
    path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/Heart_blue.png" ofType:nil];
    data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    heartBlueCell.contents = (id)[[UIImage imageWithData:data] CGImage];
    heartBlueCell.scale = 0.3f;
    heartBlueCell.lifetime = 20.0f;
    heartBlueCell.alphaSpeed = -0.12f;
    heartBlueCell.birthRate = 10.0f;
    heartBlueCell.velocity = 150.0f;
    heartBlueCell.yAcceleration = 20.0f;
    heartBlueCell.emissionLongitude = -M_PI_4;
    heartBlueCell.emissionRange = M_PI_4;
    heartBlueCell.spinRange = M_PI_2;
    heartLayer.emitterCells = @[heartRedCell , heartBlueCell];
}
- (void)createLoveAnimation:(UIView *)superView  {
   
    CAEmitterLayer *loveLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:loveLayer];

    loveLayer.emitterPosition = CGPointMake(superView.frame.size.width * 0.5, superView.frame.size.height * 0.5);
    loveLayer.emitterShape = kCAEmitterLayerRectangle;
    loveLayer.emitterMode = kCAEmitterLayerVolume;
    loveLayer.renderMode = kCAEmitterLayerAdditive;
    loveLayer.emitterSize = CGSizeMake(100, 30);
    
    CAEmitterCell *loveCell = [CAEmitterCell emitterCell];
    loveCell.name = @"loveCell";
    loveCell.lifetime = 10.f;
    
    loveCell.velocity = -120.f;
    loveCell.velocityRange = 60.f;
    loveCell.yAcceleration = 20.f;
    
    loveCell.emissionLongitude = M_PI * 0.5;
    loveCell.emissionRange = M_PI_2 * 0.55;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/love_red.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    loveCell.contents = (id)[[UIImage imageWithData:data]CGImage];
    loveCell.color = [[UIColor colorWithRed:0.6 green:0.0 blue:0.4 alpha:0.5] CGColor];
    
    loveCell.scale = 0.6;
    loveCell.scaleRange = 0.5;
    loveCell.spinRange = 2.0 * M_PI;  // 自转
    
    loveLayer.emitterCells = @[loveCell];
    // 添加动画
    CABasicAnimation * heartAnim = [CABasicAnimation animationWithKeyPath:@"emitterCells.loveCell.birthRate"];
    heartAnim.fromValue = @100.f;
    heartAnim.toValue = @0.f;
    heartAnim.duration = 5.f;
    heartAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [loveLayer addAnimation:heartAnim forKey:@"heartAnim"];
}
- (void)createRibbonSuperView:(UIView *)superView {
    CAEmitterLayer *rinnonLayer = [CAEmitterLayer layer];
    [superView.layer addSublayer:rinnonLayer];
    self.emitterlayer = rinnonLayer;
    
    rinnonLayer.emitterPosition = CGPointMake(superView.frame.size.width/2,superView.frame.size.height);
    rinnonLayer.emitterSize = CGSizeMake(superView.frame.size.width-100, 20);
    rinnonLayer.renderMode = kCAEmitterLayerAdditive;
    rinnonLayer.preservesDepth = YES;
    rinnonLayer.birthRate = 0.f;
    
    CAEmitterCell * rinnonCell = [CAEmitterCell emitterCell];
    rinnonCell.birthRate = 100;
    rinnonCell.lifetime = 3.0;
    rinnonCell.lifetimeRange = 1;
    rinnonCell.scale = 0.5;
    rinnonCell.scaleRange = 0.5;
    rinnonCell.color = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.2].CGColor;
    rinnonCell.alphaRange = 1;
    rinnonCell.redRange = 255;
    rinnonCell.blueRange = 22;
    rinnonCell.greenRange = 1.5;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/ribbon.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    rinnonCell.contents=(id)[[UIImage imageWithData:data]CGImage];
    
    rinnonCell.velocity = 200;
    rinnonCell.velocityRange = 50;
    rinnonCell.emissionLongitude = M_PI+M_PI_2;
    rinnonCell.emissionRange = M_PI_2;
    rinnonCell.spin = M_PI_2;
    rinnonCell.spinRange = M_PI_2;
    rinnonLayer.emitterCells= @[rinnonCell];

}
- (void)createFireSuperView:(UIView *)superView {
    // 火花
    CAEmitterLayer * fireLayer = [CAEmitterLayer layer];
    self.emitterlayer = fireLayer;
    [superView.layer addSublayer:fireLayer];
    fireLayer.emitterSize = CGSizeMake(100.f, 0);
    fireLayer.emitterMode = kCAEmitterLayerOutline;
    fireLayer.emitterShape = kCAEmitterLayerLine;
    fireLayer.renderMode = kCAEmitterLayerAdditive;
    fireLayer.birthRate = 0.f;
    fireLayer.emitterPosition = CGPointMake(superView.bounds.size.width * 0.5, superView.bounds.size.height - 60); // 中间下部
    
    // 配置 - 火花
    CAEmitterCell * fireCell = [CAEmitterCell emitterCell];
    fireCell.name = @"fireCell";
    
    fireCell.birthRate = 450.f;
    fireCell.scaleSpeed = 0.5;
    fireCell.lifetime = 0.9f;
    fireCell.lifetimeRange = 0.315;
    
    fireCell.velocity = -80.f;
    fireCell.velocityRange = 30;
    fireCell.yAcceleration = -200; // 向上
    
    fireCell.emissionLongitude = M_PI;
    fireCell.emissionRange = 1.1;
    
    fireCell.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Emitter.bundle/fire_white.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    fireCell.contents = (id)[[UIImage imageWithData:data] CGImage];
   
    fireLayer.emitterCells = @[fireCell];
}

#pragma mark - 动画的操作
/**
 开始动画效果
 */
- (void)startEmitterAnimation {
   [self.emitterlayer setValue:@1.f forKeyPath:@"birthRate"];
}
/**
 结束动画效果
 */
- (void)endEmitterAnimation {
   [self.emitterlayer setValue:@0.f forKeyPath:@"birthRate"];
}

/** 下雨模式 -雨越下越大 */
- (void)magnifyRain {
    if (self.type != ZYQRainEmitterType) {
        return;
    }
   [self.emitterlayer setValue:@(self.emitterlayer.birthRate + 1) forKeyPath:@"birthRate"];
 [self.emitterlayer setValue:@(self.emitterlayer.scale + 0.1) forKeyPath:@"scale"];
}
/** 下雨模式 -雨越下越小 */
- (void)minishRain {
    if (self.type != ZYQRainEmitterType) {
        return;
    }
    [self.emitterlayer setValue:@(self.emitterlayer.birthRate - 0.5) forKeyPath:@"birthRate"];
    [self.emitterlayer setValue:@(self.emitterlayer.scale - 0.1) forKeyPath:@"scale"];
}

/** 移动发射源到某个点上 */
- (void)setBallInPsition:(CGPoint)position{
    if (self.type != ZYQBallEmitterType) return;
    CABasicAnimation * anim = [CABasicAnimation animationWithKeyPath:@"emitterCells.colorBallCell.scale"];
    anim.fromValue = @0.2f;
    anim.toValue = @0.5f;
    anim.duration = 1.f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 用事务包装隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.emitterlayer addAnimation:anim forKey:nil];
    [self.emitterlayer setValue:[NSValue valueWithCGPoint:position] forKeyPath:@"emitterPosition"];
    [CATransaction commit];
}
/**
 * 设置火花的数量
 * ration: 比例系数 0 到 1之间
 */
- (void)setFireCount:(float)ratio{
    
    // 火花
    [self.emitterlayer setValue:@(ratio * 500.0) forKeyPath:@"emitterCells.fireCell.birthRate"]; // 产生数量
    [self.emitterlayer setValue:[NSNumber numberWithFloat:ratio] forKeyPath:@"emitterCells.fireCell.lifetime"]; // 生命周期
    [self.emitterlayer setValue:@(ratio * 0.35) forKeyPath:@"emitterCells.fireCell.lifetimeRange"]; // 生命周期变化范围
    [self.emitterlayer setValue:[NSValue valueWithCGPoint:CGPointMake(ratio * 50, 0)] forKeyPath:@"emitterSize"]; // 发射源大小
    
}

@end
