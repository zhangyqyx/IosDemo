//
//  ZYQLikeBtn.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/1.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , ZYQLikeBtnType){
    ZYQLikeBtnDefaultType, // 默认类型
    ZYQLikeBtnGhostType, // 鬼影效果
    ZYQLikeBtnOverlapType//重叠效果
};



@interface ZYQLikeBtn : UIButton
/** 类型 */
@property(nonatomic , assign)ZYQLikeBtnType type;


@end

NS_ASSUME_NONNULL_END
