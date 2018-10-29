//
//  ZYQBarcodeGenerateController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQBarcodeGenerateController.h"
#import "ZYQBarcodeGenerateManager.h"

@interface ZYQBarcodeGenerateController ()
/** 二维码图片 */
@property (weak, nonatomic) IBOutlet UIImageView *barcodeImage;

@end

@implementation ZYQBarcodeGenerateController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.barcodeImage.image = [ZYQBarcodeGenerateManager ZYQ_generateBarcodeWithStr:@"18410286154" ];
    self.barcodeImage.image = [ZYQBarcodeGenerateManager ZYQ_generateBarcodeWithStr:@"18410286154" codeImageSize:CGSizeMake(240, 50)];
//    self.barcodeImage.image = [ZYQBarcodeGenerateManager ZYQ_generateBarcodeWithStr:@"www.baidu.com" codeImageSize:CGSizeMake(240, 50) red:0.5f green:0.3f blue:0.8f];
}



@end
