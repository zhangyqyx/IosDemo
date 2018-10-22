//
//  ZYQCreateBtn.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCreateBtn.h"

@implementation ZYQCreateBtn
+(instancetype)createBtnWitFrame:(CGRect)frame
                     normalTitle:(NSString *)normalTitle
                normalTitleColor:(UIColor *)normalTitleColor
                     normalImage:(UIImage *)normalImage
                     selectTitle:(NSString *)selectTitle
                selectTitleColor:(UIColor *)selectTitleColor
                     selectImage:(UIImage *)selectImage
                            font:(UIFont *)font
                         bgColor:(UIColor *)bgColor{
    ZYQCreateBtn *customBtn = [ZYQCreateBtn buttonWithType:UIButtonTypeCustom];
    [customBtn setTitle:normalTitle forState:UIControlStateNormal];
    [customBtn setTitle:selectTitle forState:UIControlStateSelected];
    [customBtn setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [customBtn setTitleColor:selectTitleColor forState:UIControlStateSelected];
    [customBtn setImage:normalImage forState:UIControlStateNormal];
    [customBtn setImage:selectImage forState:UIControlStateSelected];
    customBtn.titleLabel.font = font;
    customBtn.backgroundColor = bgColor;
    
    
    return customBtn;
}

@end
