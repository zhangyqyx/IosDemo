//
//  ZYQSystemAnimationNextController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/30.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQSystemAnimationNextController.h"

@interface ZYQSystemAnimationNextController ()

@end

@implementation ZYQSystemAnimationNextController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI {
    self.navigationItem.title= @"转场界面";
    self.navigationController.navigationBar.backgroundColor = kNavColor;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"pic2"];
    [self.view addSubview:imageView];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
