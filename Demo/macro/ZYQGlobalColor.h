//
//  ZYQGlobalColor.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#ifndef ZYQGlobalColor_h
#define ZYQGlobalColor_h
//背景颜色
#define kViewLightBgColor    C_ECF0F7
//横线颜色
#define klineColor           C_F4F6F9
//导航颜色
#define kNavColor            [UIColor ZYQ_gradientFromColor:C_2694FD toColor:[UIColor ZYQ_colorWithHex:0x5790FF] withSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 1)]

//其他常用到的颜色
#define C_2694FD  [UIColor ZYQ_colorWithHex:0x2694FD]
#define C_5790FF  [UIColor ZYQ_colorWithHex:0x5790FF]
#define C_00B38B  [UIColor ZYQ_colorWithHex:0x00B38B]
#define C_FFC92C  [UIColor ZYQ_colorWithHex:0xFFC92C]
#define C_EA5A60  [UIColor ZYQ_colorWithHex:0xEA5A60]
#define C_ECF0F7  [UIColor ZYQ_colorWithHex:0xECF0F7]
#define C_F4F6F9  [UIColor ZYQ_colorWithHex:0xF4F6F9]
#define C_FFFFFF  [UIColor ZYQ_colorWithHex:0xFFFFFF]
#define C_999999  [UIColor ZYQ_colorWithHex:0x999999]
#define C_B6B6B6  [UIColor ZYQ_colorWithHex:0xB6B6B6]
#define C_666666  [UIColor ZYQ_colorWithHex:0x666666]
#define C_444444  [UIColor ZYQ_colorWithHex:0x444444]
#define C_000000  [UIColor ZYQ_colorWithHex:0x000000]
#define C_DADADA  [UIColor ZYQ_colorWithHex:0xDADADA]
//其他自己定义的颜色,传入颜色字符串， 必须是#00ff0b这种格式
#define kCustomClolr(cColor)    [UIColor ZYQ_getColor:cColor]



#endif 
