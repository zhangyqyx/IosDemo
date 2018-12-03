//
//  UIViewController+ZYQTransitionAnimation.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQTransitonAnimation.h"

@interface UIViewController (ZYQTransitionAnimation)<UINavigationControllerDelegate , UIViewControllerTransitioningDelegate>

/** push操作 */
@property (nonatomic , strong)ZYQTransitonAnimation *ZYQ_pushTranstion;
/** pop操作 */
@property (nonatomic , strong)ZYQTransitonAnimation *ZYQ_popTransition;

/** present操作 */
@property (nonatomic , strong)ZYQTransitonAnimation *ZYQ_presentTranstion;
/** dismiss操作 */
@property (nonatomic , strong)ZYQTransitonAnimation *ZYQ_dismissTransition;

@end
