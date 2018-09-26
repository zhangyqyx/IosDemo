//
//  ZYQMusicAnimation.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYQMusicAnimation : NSObject

/**
 配置动画效果
 @param layer 加到那个view的layer上
 */
- (void)configAnimationAtLayer:(CALayer *)layer ;

/**
 移除动画效果
 */
- (void)removeAnimation;


@end
