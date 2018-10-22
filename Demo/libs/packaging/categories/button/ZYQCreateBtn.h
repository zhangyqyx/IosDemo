//
//  ZYQCreateBtn.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/21.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYQCreateBtn : UIButton

+(instancetype)createBtnWitFrame:(CGRect)frame
                     normalTitle:(NSString *)normalTitle
                normalTitleColor:(UIColor *)normalTitleColor
                     normalImage:(UIImage *)normalImage
                     selectTitle:(NSString *)selectTitle
                selectTitleColor:(UIColor *)selectTitleColor
                     selectImage:(UIImage *)selectImage
                            font:(UIFont *)font
                         bgColor:(UIColor *)bgColor;

@end
