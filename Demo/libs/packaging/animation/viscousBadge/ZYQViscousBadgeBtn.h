//
//  ZYQViscousBadgeBtn.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/29.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYQViscousBadgeBtn : UIButton

/**文字颜色  默认白色 */
@property(nonatomic,strong)UIColor *titleColor;
/**圆点颜色 默认红色*/
@property(nonatomic,strong)UIColor *circleColor;
/** 字体大小  默认12号 */
@property(nonatomic,assign)CGFloat fontSize;
/**最大拉伸距离 默认60 */
@property(nonatomic,assign)CGFloat maxDistance;
/**移除之后回调 */
@property(nonatomic,copy)void (^block)(UIButton * btn);
@end

NS_ASSUME_NONNULL_END
