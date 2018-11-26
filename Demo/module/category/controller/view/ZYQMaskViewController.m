//
//  ZYQMaskViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQMaskViewController.h"
#import "UIView+ZYQHollowMask.h"

@interface ZYQMaskViewController ()
/** topView */
@property(nonatomic , strong)UIView *topView;
/** centerView */
@property(nonatomic , strong)UIView  *centerView;

@end

@implementation ZYQMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupBtn];
}

- (void)setupView {
    self.navigationItem.title = @"设置镂空形状";
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 260, 160)];
    topView.ZYQ_viewCenterX = self.view.ZYQ_viewCenterX;
    topView.backgroundColor = [UIColor ZYQ_randomColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UIImageView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 220, 260, 160)];
    centerImageView.ZYQ_viewCenterX = self.view.ZYQ_viewCenterX;
    centerImageView.image = [UIImage imageNamed:@"background"];
    [self.view addSubview:centerImageView];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *centerView = [[UIVisualEffectView alloc] initWithEffect:effect];
    centerView.frame = CGRectMake(15, 10,230, 140);
    [centerImageView addSubview:centerView];
    self.centerView = centerView;
    
}
- (void)setupBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"设置镂空字体" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 10, 120, 20);
    [button addTarget:self action:@selector(setupFont) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"设置镂空图案" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(150, 10, 120, 20);
    [button1 addTarget:self action:@selector(setupImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    
}

- (void)setupFont {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 160)];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"张永强的签名";
    self.topView.hollowMaskView = label;
    self.centerView.hollowMaskView = label;
}
- (void)setupImage {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bear"]];
    imageView.frame = CGRectMake(40, 5, 140, 140);
    
    self.topView.hollowMaskView = imageView;
    self.centerView.hollowMaskView = imageView;
}



@end
