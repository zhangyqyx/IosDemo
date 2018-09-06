//
//  ZYQBaseController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/8/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQBaseController.h"

@interface ZYQBaseController ()

@end

@implementation ZYQBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kViewLightBgColor;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}



@end
