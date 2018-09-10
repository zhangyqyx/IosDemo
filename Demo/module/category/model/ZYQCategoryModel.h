//
//  ZYQCategoryModel.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQCategoryModel : NSObject

/** 标题 */
@property(nonatomic , strong)NSString *titleName;
/** 简介 */
@property(nonatomic , strong)NSString *introduction;

/** 演示控制器 */
@property(nonatomic , strong)NSString *pushVc;

+(NSArray *)loadData;

@end
