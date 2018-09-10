//
//  ZYQImageViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQImageViewController.h"
#import "UIImage+ZYQFunction.h"
#import "UIView+ZYQSetSize.h"

@interface ZYQImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
/**颜色 */
@property (nonatomic , strong)UIColor *color;
/**添加毛玻璃视图 */
@property (nonatomic , strong)UIView *effectView;
@end

@implementation ZYQImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"图片操作";
}
//获取图片此点区域的色值
- (IBAction)getColor:(id)sender {
    UIImage *image = self.showImageView.image;
    UIColor *color = [image ZYQ_colorAtPoint:CGPointMake(10, 20)];
    NSLog(@"color = %@" , color);
    self.color = color;
}
//生成指定颜色的一个`点`的图像
- (IBAction)colorConvertImage:(id)sender {
    [self.effectView removeFromSuperview];
    if (!self.color) {
        self.color = [UIColor brownColor];
    }
    self.showImageView.image = [UIImage ZYQ_singleDotImageWithColor:self.color];
    
    
}
//获得水印图片
- (IBAction)getWaterImage:(id)sender {
    [self.effectView removeFromSuperview];
    self.showImageView.image = [UIImage ZYQ_waterImageWithBg:@"3" logo:@"logo" scale:0.5 margin:10];
}
//裁剪一张圆形图片
- (IBAction)cutRoundImage:(id)sender {
    [self.effectView removeFromSuperview];
    self.showImageView.image = [UIImage ZYQ_circleImageWithImage:self.showImageView.image imageSize:300 isExistBorder:YES borderWidth:2.0 borderColor:[UIColor redColor]];
    CGPoint center = self.showImageView.center;
    self.showImageView.ZYQ_viewSize = CGSizeMake(302, 302);
    self.showImageView.center = center;
}
// 将一张图片变模糊
- (IBAction)blurImage:(id)sender {
    [self.effectView removeFromSuperview];
   self.showImageView.image =  [UIImage ZYQ_blurImage:self.showImageView.image argument:0.3];
}
//添加毛玻璃效果
- (IBAction)addBlurVisualEffect:(id)sender {
    CGRect rect = CGRectMake(0, 0, self.showImageView.ZYQ_viewWidth * 0.5, self.showImageView.ZYQ_viewHeight);
   self.effectView =  [UIImage ZYQ_blurVisualEffectImage:self.showImageView frame:rect style:UIBlurEffectStyleExtraLight];
}

//裁剪一张图片
- (IBAction)cutImage:(id)sender {
    [self.effectView removeFromSuperview];
    //裁剪一张全图
    self.showImageView.image = [UIImage ZYQ_image:self.showImageView.image scaledToSize:CGSizeMake(40, 80)];
    //裁剪指定区域图片
//    self.showImageView.image = [UIImage TF_handleImage:self.showImageView.image withframe:CGRectMake(100, 120, 100, 100)];
    NSLog(@"imageSize =%@" , NSStringFromCGSize(self.showImageView.image.size));
}


@end
