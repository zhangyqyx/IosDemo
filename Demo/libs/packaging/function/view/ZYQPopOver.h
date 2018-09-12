//
//  ZYQPopOver.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/12.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , ZYQArrowDirection){
    //箭头位置
    ZYQArrowDirectionLeftUp, //左上
    ZYQArrowDirectionLeftCenter, //左中
    ZYQArrowDirectionLeftBottom, //左下
    ZYQArrowDirectionRightUp, //右上
    ZYQArrowDirectionRightCenter, //右中
    ZYQArrowDirectionRightBottom, //右下
    ZYQArrowDirectionUpLeft, //上左
    ZYQArrowDirectionUpCenter, //上中
    ZYQArrowDirectionUpRight, //下右
    ZYQArrowDirectionDownLeft, //下左
    ZYQArrowDirectionDownCenter, //下中
    ZYQArrowDirectionDownRight, //下右
};


@interface ZYQPopOver : UIView
/** 弹出的视图 */
@property(nonatomic , strong)UIView *alertView;
/** 箭头大小 默认5 */
@property(nonatomic , assign)CGFloat arrowSize;
/** 箭头颜色 */
@property(nonatomic , strong)UIColor *arrowColor;
/** 箭头间隔距离边缘距离 默认20 */
@property(nonatomic , assign)CGFloat arrowMargin;


/**
 设置视图

 @param origin 顶点
 @param width 宽
 @param height 高
 @param direction 方向
 @return 视图
 */
- (instancetype)initWithOrigin:(CGPoint)origin
                         width:(CGFloat)width
                        height:(CGFloat)height
                     direction:(ZYQArrowDirection)direction;


- (void)popView;//弹出视图
- (void)dissmissView;//隐藏视图

@end
