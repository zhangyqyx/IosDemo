//
//  ZYQViscousBadgeController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQViscousBadgeController.h"
#import "ZYQViscousBadgeBtn.h"

@interface ZYQViscousBadgeController ()
/**btn */
@property(nonatomic,strong)ZYQViscousBadgeBtn *btn ;

@end

@implementation ZYQViscousBadgeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"QQ黏贴效果";
    [self createView];
}
- (void)createView {
    ZYQViscousBadgeBtn *btn = [[ZYQViscousBadgeBtn alloc] initWithFrame:CGRectMake(100, 100, 20, 20)];
    btn.center = self.view.center;
    [btn setTitle:@"45" forState:UIControlStateNormal];
    btn.circleColor = [UIColor blueColor];
    btn.maxDistance = 100;
    [self.view addSubview:btn];
    self.btn = btn;
    self.btn.block = ^(UIButton *btn) {
        NSLog(@"移除后回调");
    };
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.btn setTitle:@"100" forState:UIControlStateNormal];
}

@end
