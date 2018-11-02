//
//  ZYQEmitterShowController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/31.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQEmitterShowController.h"
#import "ZYQEmitterView.h"

@interface ZYQEmitterShowController ()
/** 粒子动画 */
@property(nonatomic , strong)ZYQEmitterView *emitterView;


@end

@implementation ZYQEmitterShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

#pragma mark - 设置UI
- (void)setupUI {
    [self createImageView];
    [self createBtn];
    [self createEmitterView];
   
}
- (void)createBtn {
    if ([self.type isEqualToString:@"love"]) return;
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [startBtn setTitle:@"开始动画" forState:UIControlStateNormal];
    startBtn.frame = CGRectMake(0, 40, 100, 21);
    startBtn.center = CGPointMake(self.view.center.x - 80, startBtn.center.y);
    [startBtn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [endBtn setTitle:@"结束动画" forState:UIControlStateNormal];
    endBtn.frame = CGRectMake(0, 40, 100, 21);
    endBtn.center = CGPointMake(self.view.center.x + 80, startBtn.center.y);
    [endBtn addTarget:self action:@selector(endAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endBtn];
    if ([self.type isEqualToString:@"rain"]) {
        [self createRainBtn];
    }
    if ([self.type isEqualToString:@"ball"]) {
        self.view.backgroundColor = [UIColor blackColor];
        [self createHintLabel:@"轻点或者移动更改发射位置"];
    }
    if ([self.type isEqualToString:@"fire"]) {
        self.view.backgroundColor = [UIColor blackColor];
        [self createHintLabel:@"点击屏幕v位置增大或减小火焰"];
    }
    
}
- (void)createRainBtn {
    UIButton *magnifyRainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [magnifyRainBtn setTitle:@"雨下大了" forState:UIControlStateNormal];
    magnifyRainBtn.frame = CGRectMake(0, 70, 100, 21);
    magnifyRainBtn.center = CGPointMake(self.view.center.x - 80, magnifyRainBtn.center.y);
    [magnifyRainBtn addTarget:self action:@selector(magnifyRain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:magnifyRainBtn];
    UIButton *minishRainBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [minishRainBtn setTitle:@"雨变小了" forState:UIControlStateNormal];
    minishRainBtn.frame = CGRectMake(0, 70, 100, 21);
    minishRainBtn.center = CGPointMake(self.view.center.x + 80, minishRainBtn.center.y);
    [minishRainBtn addTarget:self action:@selector(minishRain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:minishRainBtn];
}
- (void)createHintLabel:(NSString *)hintStr {
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 21)];
    hintLabel.text = hintStr;
    hintLabel.textColor = [UIColor whiteColor];
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:hintLabel];
}



- (void)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    if ([self.type isEqualToString:@"RedPacket"]) {
        imageView.image = [UIImage imageNamed:@"redPacketBg"];
    }
    if ([self.type isEqualToString:@"Snowflake"]) {
         imageView.image = [UIImage imageNamed:@"snowflakeBg"];
    }
    if ([self.type isEqualToString:@"rain"]) {
       imageView.image = [UIImage imageNamed:@"rainBg"];
    }
    [self.view addSubview:imageView];
}


- (void)createEmitterView {
    self.emitterView = [[ZYQEmitterView alloc] init];
    if ([self.type isEqualToString:@"RedPacket"]) {
        self.navigationItem.title = @"红包雨效果";
       [self.emitterView createEmitterAnimation:ZYQRedPacketEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"Snowflake"]) {
        self.navigationItem.title = @"下雪效果";
         [self.emitterView createEmitterAnimation:ZYQSnowflakeEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"rain"]) {
        self.navigationItem.title = @"下雨效果";
        [self.emitterView createEmitterAnimation:ZYQRainEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"ball"]) {
        self.navigationItem.title = @"五彩小球";
        [self.emitterView createEmitterAnimation:ZYQBallEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"love"]) {
          self.view.backgroundColor = [UIColor blackColor];
        self.navigationItem.title = @"💕效果";
          [self.emitterView createEmitterAnimation:ZYQLoveEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"rinnon"]) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"彩带效果";
        [self.emitterView createEmitterAnimation:ZYQRibbonEmitterType superView:self.view];
    }
    if ([self.type isEqualToString:@"fire"]) {
        self.view.backgroundColor = [UIColor blackColor];
        self.navigationItem.title = @"火焰效果";
        [self.emitterView createEmitterAnimation:ZYQFireEmitterType superView:self.view];
    }
}
#pragma mark - 喷射小球效果
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self.type isEqualToString:@"ball"] && ![self.type isEqualToString:@"fire"] ) return;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.view];
    if ([self.type isEqualToString:@"ball"]) {
        [self.emitterView setBallInPsition:point];
        return;
    }
    // 计算比例
    CGFloat distanceToBottom = self.view.bounds.size.height - point.y;
    CGFloat per = distanceToBottom / self.view.bounds.size.height;
    // 设置数量
    [self.emitterView setFireCount:2 * per];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self.type isEqualToString:@"ball"]) return;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self.view];
    [self.emitterView setBallInPsition:point];
    
  
    
}


#pragma mark - 按钮点击
- (void)startAnimation {
    [self.emitterView startEmitterAnimation];
}
- (void)endAnimation {
    [self.emitterView endEmitterAnimation];
}
- (void)magnifyRain {
    [self.emitterView magnifyRain];
}
- (void)minishRain {
    [self.emitterView minishRain];
}

@end
