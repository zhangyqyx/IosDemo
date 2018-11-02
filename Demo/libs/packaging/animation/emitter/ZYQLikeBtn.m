//
//  ZYQLikeBtn.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/1.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQLikeBtn.h"

@interface ZYQLikeBtn()
/** likeLayer */
@property(nonatomic , strong)CAEmitterLayer *likeLayer;
/** 图片 */
@property(nonatomic , strong)UIImage *tempImage;


@end

@implementation ZYQLikeBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLikeLayer];
    }
    return self;
}
- (void)createLikeLayer {
    self.type = ZYQLikeBtnDefaultType;
    [self createNormalLike];
}
#pragma mark - 效果
//默认
- (void)createNormalLike {
    CAEmitterLayer * likeLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:likeLayer];
    self.likeLayer = likeLayer;
    likeLayer.emitterSize = self.bounds.size;
    likeLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
    likeLayer.emitterShape = kCAEmitterLayerCircle;
    likeLayer.emitterMode = kCAEmitterLayerOutline;
    likeLayer.renderMode = kCAEmitterLayerOldestFirst;

    CAEmitterCell *likeCell = [CAEmitterCell emitterCell];
    likeCell.name = @"likeCell";
    likeCell.alphaSpeed = -1.f;
    likeCell.alphaRange = 0.10f;
    likeCell.lifetime = 1;
    likeCell.lifetimeRange = 0.1f;
    likeCell.velocity = 40.f;
    likeCell.velocityRange = 10.f;
    likeCell.scale = 0.05f;
    likeCell.scaleRange = -0.02f;
    likeLayer.emitterCells = @[likeCell];
}
- (void)createGhostTypeLike {
    CAEmitterLayer * ghostLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:ghostLayer];
    self.likeLayer = ghostLayer;
    ghostLayer.emitterShape = kCAEmitterLayerPoint;
    ghostLayer.emitterMode = kCAEmitterLayerVolume;
    ghostLayer.renderMode = kCAEmitterLayerOldestFirst;
    ghostLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    ghostLayer.birthRate = 0.f;
    
    CAEmitterCell *ghostCell = [CAEmitterCell emitterCell];
    ghostCell.name = @"ghostCell";
    ghostCell.scale = 0.5;
    ghostCell.lifetime = 1;
    ghostCell.birthRate = 1.f;
    ghostCell.alphaSpeed = -1;
    ghostCell.velocity = 50;
    ghostCell.emissionLongitude = -M_PI_2;
    ghostLayer.emitterCells = @[ghostCell];
    
}

- (void)createOverlapTypeLike{
    CAEmitterLayer * overlapLayer = [CAEmitterLayer layer];
    [self.layer addSublayer:overlapLayer];
    self.likeLayer = overlapLayer;
    overlapLayer.renderMode = kCAEmitterLayerOldestFirst;
    overlapLayer.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    overlapLayer.birthRate = 0.f;
    
    CAEmitterCell *overlapCell = [CAEmitterCell emitterCell];
    overlapCell.name = @"overlapCell";
    overlapCell.scale = 0.7f;
    overlapCell.lifetime = 1.0f;
    overlapCell.birthRate = 5.0f;
    overlapCell.alphaSpeed = -1;
    overlapCell.velocity = 50;
    overlapCell.emissionLongitude = -M_PI_2;
    overlapCell.emissionRange = M_PI_2;
    overlapLayer.emitterCells = @[overlapCell];
    
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    if (state == UIControlStateSelected) {
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.ghostCell.contents"];
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.overlapCell.contents"];
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.likeCell.contents"];
        
        self.tempImage = image;
    }
}
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    if (state == UIControlStateSelected) {
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.ghostCell.contents"];
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.overlapCell.contents"];
        [self.likeLayer setValue:(id)[image CGImage] forKeyPath:@"emitterCells.likeCell.contents"];
        
        self.tempImage = image;
    }
}


-(void)setType:(ZYQLikeBtnType)type {
    _type = type;
    if (type == ZYQLikeBtnDefaultType) return;
    if (type == ZYQLikeBtnGhostType ) {
        [self createGhostTypeLike];
        [self.likeLayer setValue:(id)[self.tempImage CGImage] forKeyPath:@"emitterCells.ghostCell.contents"];
    }
    if (type == ZYQLikeBtnOverlapType) {
         [self createOverlapTypeLike];
        [self.likeLayer setValue:(id)[self.tempImage CGImage] forKeyPath:@"emitterCells.overlapCell.contents"];
    }
}


/**
 * 选中状态 实现缩放
 */
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    if (self.type == ZYQLikeBtnDefaultType) {
        [self defaultAnimation:selected];
    }
    if (self.type == ZYQLikeBtnGhostType) {
        [self ghostAnimation:selected];
    }
    if (self.type == ZYQLikeBtnOverlapType) {
        [self overlapAnimation:selected];
    }
    
}
#pragma mark - 动画
- (void)defaultAnimation:(BOOL)selected {
    // 通过关键帧动画实现缩放
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    if (selected) {  // 从没有点击到点击状态 会有爆炸的动画效果
        animation.values = @[@1.5,@2.0, @0.8, @1.0];
        animation.duration = 0.5;
        
        animation.calculationMode = kCAAnimationCubic;
        [self.layer addAnimation:animation forKey:nil];
        // 让放大动画先执行完毕 再执行爆炸动画
        [self startAnimation];
    }else{ // 从点击状态normal状态 无动画效果 如果点赞之后马上取消 那么也立马停止动画
        [self stopAnimation];
    }
}
/**
 * 开始动画
 */
- (void)startAnimation{
    // 用KVC设置颗粒个数
    [self.likeLayer setValue:@1000 forKeyPath:@"emitterCells.likeCell.birthRate"];
    // 开始动画
    self.likeLayer.beginTime = CACurrentMediaTime();
    // 延迟停止动画
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

/**
 * 动画结束
 */
- (void)stopAnimation{
    // 用KVC设置颗粒个数
    [self.likeLayer setValue:@0 forKeyPath:@"emitterCells.likeCell.birthRate"];
    if (self.type != ZYQLikeBtnDefaultType) {
        [self.likeLayer setValue:@0 forKeyPath:@"birthRate"];
    }
    [self.likeLayer removeAllAnimations];
}

- (void)ghostAnimation:(BOOL)selected {
    if (selected) {
      self.likeLayer.beginTime = CACurrentMediaTime() - 1;
      [self.likeLayer setValue:@1 forKeyPath:@"birthRate"];
      [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
    }else {
        [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
    }
}
- (void)overlapAnimation:(BOOL)selected  {
    if (selected) {
        self.likeLayer.beginTime = CACurrentMediaTime() - 0.2;
        [self.likeLayer setValue:@1 forKeyPath:@"birthRate"];
        [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:1.5];
    }else {
        [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
    }
}




@end
