//
//  ZYQNavController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/8/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQNavController.h"


@interface ZYQNavController ()

@end

@implementation ZYQNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
- (void)setup {
    [self.navigationBar setBarTintColor:kNavColor];
    [[UINavigationBar appearance] setTranslucent:false];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] =  [UIColor whiteColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [self.navigationBar setTitleTextAttributes:attributes];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    UIView *statusBarView = [[UIView alloc]   initWithFrame:CGRectMake(0, -20,    self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = self.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:statusBarView];
    
}


@end
