//
//  ZYQFillAnimationController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFillAnimationController.h"
#import "ZYQWaterWaveView.h"

@interface ZYQFillAnimationController ()

@end

@implementation ZYQFillAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填充动画";
    [self createOneAnimation];
}

- (void)createOneAnimation {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    imageView.image = [UIImage imageNamed:@"circle_bg"];
    [self.view addSubview:imageView];
    
    ZYQWaterWaveView *waveView = [[ZYQWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    waveView.backgroundColor = [UIColor clearColor];
    waveView.clipsToBounds = true;
    waveView.layer.cornerRadius = 50;
    [imageView addSubview:waveView];
    [waveView updateViewGradientFromColor:[UIColor ZYQ_randomColor] toColor:[UIColor ZYQ_randomColor] withRange:waveView.frame.size.width];
    [waveView showDripAnmin:@(0.8)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [waveView drawWaterWavePath:@(0.6)];
    });
    
    
}


@end
