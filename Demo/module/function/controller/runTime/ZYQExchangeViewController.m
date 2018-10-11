//
//  ZYQExchangeViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQExchangeViewController.h"
#import "ZYQRuntimeManager.h"

@interface ZYQExchangeViewController ()
/** 文字 */
@property(nonatomic , strong)NSString *titleStr;


@end

@implementation ZYQExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    self.titleStr = @"要设置的字";
}
- (IBAction)exchange:(id)sender {
    if (self.type == 1) {
        self.titleStr = @"交换后的文字";
      [ZYQRuntimeManager ZYQ_exchangeMethodSourceClass:[UIButton class] sourceSel:@selector(setTitle:forState:) targetClass:[self class] targetSel:@selector(setTitleName: withState:)];
    }
}

- (IBAction)replace:(id)sender {
    if (self.type == 2) {
        self.titleStr = @"替换后的文字";
        [ZYQRuntimeManager ZYQ_replaceMethodSourceClass:[UIButton class] sourceSel:@selector(setTitle:forState:)  targetClass:[self class] targetSel:@selector(setTitleName: withState:)];
    }
    
}
- (void)setTitleName:(NSString *)titleName withState:(UIControlState)state {
    NSLog(@"调用或者替换这个方法设置，titleName = %@" , titleName);
}


- (IBAction)use:(id)sender {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:self.titleStr forState:UIControlStateNormal];
    button.ZYQ_viewWidth = 200;
    button.ZYQ_viewHeight = 40;
    button.ZYQ_viewY = 20;
    button.ZYQ_viewCenterX = self.view.ZYQ_viewCenterX;
    button.backgroundColor = kNavColor;
    [self.view addSubview:button];
}



@end
