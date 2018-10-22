//
//  ZYQOtherModel.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQOtherModel : NSObject
/** 标题 */
@property(nonatomic , strong)NSString *title;
/** 图片 */
@property(nonatomic , strong)NSString *imageStr;
/** 跳转控制器 */
@property(nonatomic , strong)NSString *nextVc;


+ (NSArray *)loadData;
@end
