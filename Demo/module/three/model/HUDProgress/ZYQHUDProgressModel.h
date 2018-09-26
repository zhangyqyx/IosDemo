//
//  ZYQHUDProgressModel.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYQHUDProgressModel : NSObject
/** 分区头部标题 */
@property (copy, nonatomic) NSString *header;
/** 文字 */
@property (strong, nonatomic) NSArray *titles;
/** 方法 */
@property (strong, nonatomic) NSArray *methods;
/** 控制器 */
@property (assign, nonatomic) Class vcClass;

+ (NSArray *)loadData;
@end
