//
//  ZYQCircularAnimationController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCircularAnimationController.h"
#import "ZYQCircularAnimationNextController.h"
#import "ZYQTransitonAnimation.h"
#import "UIViewController+ZYQTransitionAnimation.h"

@interface ZYQCircularAnimationController ()

@end

@implementation ZYQCircularAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupJumpBtn];
}
#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"圆形转场动画";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"pic1"];
    [self.view addSubview:imageView];
}
- (void)setupJumpBtn {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 80);
    button.backgroundColor = [UIColor greenColor];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 40;
    button.center = self.view.center;
    [button setTitle:@"点击或\n拖动我" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    [button  addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];

}

- (void)next:(UIButton *)btn {
    ZYQCircularAnimationNextController *customVc = [[ZYQCircularAnimationNextController alloc] init];
    ZYQTransitonAnimation *cusAnimation = [ZYQTransitonAnimation transitionWithRect:btn.frame];
    cusAnimation.animationType = ZYQCircularAnimationType;
    self.ZYQ_pushTranstion = cusAnimation;
    self.ZYQ_popTransition = cusAnimation;
    [self.navigationController pushViewController:customVc animated:true];
}


- (void)pan:(UIPanGestureRecognizer *)panGesture{
    UIButton * btn  = (UIButton *)panGesture.view;
    CGPoint lPoint = [panGesture locationInView:self.view];
    CGFloat KWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat KHeight = [UIScreen mainScreen].bounds.size.height;
    
    //确定特殊的centerX
    if (lPoint.x  >= KWidth - btn.frame.size.width * 0.5){
        lPoint = CGPointMake(KWidth - btn.frame.size.width * 0.5, lPoint.y);
    }
    if (lPoint.x  <=  btn.frame.size.width * 0.5){
        lPoint = CGPointMake(btn.frame.size.width * 0.5, lPoint.y);
    }
    //确定特殊的centerY
    if (lPoint.y  >= KHeight - btn.frame.size.width * 0.5){
        lPoint = CGPointMake(lPoint.x, KHeight - btn.frame.size.width * 0.5);
    }
    if (lPoint.y  <=  btn.frame.size.width * 0.5 + 64){
        lPoint = CGPointMake(lPoint.x, btn.frame.size.width * 0.5 + 64);
    }
    btn.center = lPoint;
}

@end
