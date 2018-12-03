//
//  ZYQCircularAnimationNextController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCircularAnimationNextController.h"

@interface ZYQCircularAnimationNextController ()

@end

@implementation ZYQCircularAnimationNextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI {
    self.navigationItem.title = @"转场后的控制器";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.ZYQ_viewWidth, self.view.ZYQ_viewHeight)];
    imageView.image = [UIImage imageNamed:@"pic2"];
    [self.view addSubview:imageView];
}

@end
