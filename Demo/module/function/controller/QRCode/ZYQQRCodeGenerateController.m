//
//  ZYQQRCodeGenerateController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQQRCodeGenerateController.h"
#import "ZYQQRCodeGenerateManager.h"

@interface ZYQQRCodeGenerateController ()
/**  图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ZYQQRCodeGenerateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"二维码生成";
//        self.imageView.image = [ZYQQRCodeGenerateManager ZYQ_generateQRCodeWithStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️" sizeWidth:200];
    //    self.imageView.image = [ZYQQRCodeGenerateManager ZYQ_generateQRCodeWithLogoStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
    //                                                                   logoImageName:@"logo-1"
    //                                                            logoScaleToSuperView:10];
    //   self.imageView.image = [ZYQQRCodeGenerateManager ZYQ_generateWithColorQRCodeStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
    //                                                                 backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
    //                                                                       mainColor:[CIColor colorWithRed:1.0 green:0.2 blue:0.4]];
    
        self.imageView.image = [ZYQQRCodeGenerateManager ZYQ_generateQRCodeWithLogoStr:@"❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️❤️"
                                                                       logoImageName:@"logo"
                                                                logoScaleToSuperView:10
                                                                     backgroundColor:[CIColor colorWithRed:1 green:0 blue:0.8]
                                                                           mainColor:[CIColor colorWithRed:1.0 green:1.0 blue:0.4]];
    
    
    
}



@end
