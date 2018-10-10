//
//  ZYQBaseModel.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQBaseModel : NSObject

/** title */
@property(nonatomic , strong)NSString *title;
/** 简介 */
@property(nonatomic , strong)NSString *introduction;
/** 跳转控制器 */
@property(nonatomic , strong)NSString *nextVc;

+(NSArray *)loadData;


@end
