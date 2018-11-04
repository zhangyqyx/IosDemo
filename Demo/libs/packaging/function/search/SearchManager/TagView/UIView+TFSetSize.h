//
//  UIView+TFSetSize.h
//  封装
//
//  Created by 张永强 on 17/4/1.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TFSetSize)
/**设置原点 */
@property (nonatomic , assign)CGPoint TF_viewOrign;
/**设置尺寸 */
@property (nonatomic , assign)CGSize TF_viewSize;

/**设置 x */
@property (nonatomic , assign)CGFloat TF_viewX;
/**设置 y */
@property (nonatomic , assign)CGFloat TF_viewY;
/**设置 width */
@property (nonatomic , assign)CGFloat TF_viewWidth;
/**设置 height */
@property (nonatomic , assign)CGFloat TF_viewHeight;

/**设置centerX */
@property (nonatomic , assign)CGFloat TF_viewCenterX;
/**设置centerY */
@property (nonatomic , assign)CGFloat TF_viewCenterY;
/**设置右侧 */
@property (nonatomic , assign)CGFloat TF_viewRight;
/**设置底侧 */
@property (nonatomic , assign)CGFloat TF_viewBottom;

/** 截屏 */
- (UIImage *)TF_capturedImage;


@end
