//
//  ZYQEmitterBtnController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/1.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQEmitterBtnController.h"
#import "ZYQLikeBtn.h"

@interface ZYQEmitterBtnController ()

@end

@implementation ZYQEmitterBtnController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"点赞动画";
    [self createLikeBtn];
    [self createLoveBtn];
}
- (void)createLikeBtn {
    ZYQLikeBtn *likeBtn = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(60, 100, 40, 40)];
//    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
//    [likeBtn setImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [likeBtn setBackgroundImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn];
    
    ZYQLikeBtn *likeBtn1 = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(150, 100, 40, 40)];
    likeBtn1.type = ZYQLikeBtnGhostType;
    [likeBtn1 setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [likeBtn1 setBackgroundImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [likeBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn1];
    ZYQLikeBtn *likeBtn2 = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(240, 100, 40, 40)];
    likeBtn2.type = ZYQLikeBtnOverlapType;
    [likeBtn2 setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [likeBtn2 setBackgroundImage:[UIImage imageNamed:@"dislike"] forState:UIControlStateNormal];
    [likeBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:likeBtn2];
    
}

- (void)createLoveBtn {
    ZYQLikeBtn *loveBtn = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(60, 200, 40, 40)];
    //    [loveBtn setImage:[UIImage imageNamed:@"love_red"] forState:UIControlStateSelected];
    //    [loveBtn setImage:[UIImage imageNamed:@"love_normal"] forState:UIControlStateNormal];
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"love_red"] forState:UIControlStateSelected];
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"love_normal"] forState:UIControlStateNormal];
    [loveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loveBtn];
    ZYQLikeBtn *loveBtn1 = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(150, 200, 40, 40)];
    [loveBtn1 setBackgroundImage:[UIImage imageNamed:@"love_red"] forState:UIControlStateSelected];
    [loveBtn1 setBackgroundImage:[UIImage imageNamed:@"love_normal"] forState:UIControlStateNormal];
    loveBtn1.type = ZYQLikeBtnGhostType;
    [loveBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loveBtn1];
    ZYQLikeBtn *loveBtn2 = [[ZYQLikeBtn alloc] initWithFrame:CGRectMake(240, 200, 40, 40)];
    [loveBtn2 setBackgroundImage:[UIImage imageNamed:@"love_red"] forState:UIControlStateSelected];
    [loveBtn2 setBackgroundImage:[UIImage imageNamed:@"love_normal"] forState:UIControlStateNormal];
    loveBtn2.type = ZYQLikeBtnOverlapType;
    [loveBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loveBtn2];
    
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}


@end
