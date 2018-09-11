//
//  ZYQViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQViewController.h"

@interface ZYQViewController ()

@end

@implementation ZYQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视图frame操作";
}



#pragma mark - 按钮点击

- (IBAction)getValue:(UIButton *)sender {
    NSLog(@"tag值：%ld" ,sender.tag);
    
}


@end
