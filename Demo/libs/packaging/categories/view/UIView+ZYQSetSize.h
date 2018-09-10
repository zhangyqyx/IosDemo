//
//  UIView+ZYQSetSize.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYQSetSize)
/**设置原点 */
@property (nonatomic , assign)CGPoint ZYQ_viewOrign;
/**设置尺寸 */
@property (nonatomic , assign)CGSize ZYQ_viewSize;

/**设置 x */
@property (nonatomic , assign)CGFloat ZYQ_viewX;
/**设置 y */
@property (nonatomic , assign)CGFloat ZYQ_viewY;
/**设置 width */
@property (nonatomic , assign)CGFloat ZYQ_viewWidth;
/**设置 height */
@property (nonatomic , assign)CGFloat ZYQ_viewHeight;

/**设置centerX */
@property (nonatomic , assign)CGFloat ZYQ_viewCenterX;
/**设置centerY */
@property (nonatomic , assign)CGFloat ZYQ_viewCenterY;
/**设置右侧 */
@property (nonatomic , assign)CGFloat ZYQ_viewRight;
/**设置底侧 */
@property (nonatomic , assign)CGFloat ZYQ_viewBottom;

/** 截屏 */
- (UIImage *)ZYQ_capturedImage;


@end
