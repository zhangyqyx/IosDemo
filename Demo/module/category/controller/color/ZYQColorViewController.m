//
//  ZYQColorViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQColorViewController.h"
#import "UIColor+ZYQColor.h"

@interface ZYQColorViewController ()
@property (weak, nonatomic) IBOutlet UIView *showColorView;

@end

@implementation ZYQColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"UIColor";

}
//获取一个十六进值得颜色
- (IBAction)getHexadecimalColor:(id)sender {
    self.showColorView.backgroundColor = [UIColor ZYQ_colorWithHex:0xffbcde];
}
//通过rgb快速获取颜色
- (IBAction)getRGBColor:(id)sender {
    self.showColorView.backgroundColor = [UIColor ZYQ_colorWithRed:100 green:200 blue:80 alpha:0.8];
}
//获取一个渐变的颜色值
- (IBAction)getGradientColor:(id)sender {
    self.showColorView.backgroundColor = [UIColor ZYQ_gradientFromColor:[UIColor ZYQ_randomColor] toColor:[UIColor ZYQ_randomColor] withSize:CGSizeMake(10, self.showColorView.frame.size.height)];
}
//获取当前颜色值
- (IBAction)getCurrentColor:(id)sender {
    u_int8_t red = [self.showColorView.backgroundColor ZYQ_redColorValue];
    u_int8_t green = [self.showColorView.backgroundColor ZYQ_greenColorValue];
    u_int8_t blue = [self.showColorView.backgroundColor ZYQ_blueColorValue];
    CGFloat alpha = [self.showColorView.backgroundColor ZYQ_alphaValue];
    NSLog(@"red = %d , green = %d , blue = %d , alpha = %.3lf" , red , green , blue , alpha);
}

@end
