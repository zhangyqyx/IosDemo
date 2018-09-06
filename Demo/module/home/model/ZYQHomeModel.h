//
//  ZYQHomeModel.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/8/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQHomeModel : NSObject
/** 标题 */
@property(nonatomic , strong)NSString *title;
/** 简介 */
@property(nonatomic , strong)NSString *introduction;
/** 图片 */
@property(nonatomic , strong)NSString *image;
/** 跳转控制器 */
@property(nonatomic , strong)NSString *nextVc;


+ (NSArray *)loadData;





@end
