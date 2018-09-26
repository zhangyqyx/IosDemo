//
//  ZYQProgressHUD.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ZYQProgressHUD : NSObject

#pragma mark - 全局的
/**
 加载一个全局的透明背景的加载框
 @return ZYQProgressHUD
 */
+ (instancetype)ZYQloadingShowBg;

/**
 加载一个全局的文字框

 @param text 文字
 @return ZYQProgressHUD
 */
+ (instancetype)ZYQloadingAlertWithText:(NSString *)text;

/**
 弹出一个全局的提示框
 @param text 文本
 @param imageStr 图片名称
 */
+ (void)ZYQshowAlertWithText:(NSString *)text
                       image:(NSString *)imageStr;

/**
 全局显示一个文本消息 1s后消失
 @param msg 显示的文本
 */
+ (void)ZYQshowMessage:(NSString *)msg;
/**
 全局显示一个文本消息 延时消失
 @param msg 显示的文本
 @param seconds 延时时间
 */
+ (void)ZYQshowMessage:(NSString *)msg
                 delay:(CGFloat)seconds;
/**
 全局显示一个文本消息 延时消失
 @param msg 显示的文本
 @param seconds 延时时间
 @param completion 消失之后回调
 */
+ (void)ZYQshowMessage:(NSString *)msg
                 delay:(CGFloat)seconds
            completion:(void (^)(void))completion;

#pragma mark - 自定义加载视图上
/**
 有透明背景的加载框，用于网络加载
 @param view 加载到那个视图上
 @return ZYQProgressHUD
 */
+ (instancetype)ZYQloadingShowBgWithSuperView:(UIView *)view;

/**
  加载框
 @param view 加载到那个视图上
 @param title 加载文字
 @return ZYQProgressHUD
 */
+ (instancetype)ZYQloadingAlertWithSuperView:(UIView *)view
                                        text:(NSString*)title;

/**
 隐藏加载框
 */
+ (void)ZYQhide;
/**
 显示加载框
 */
+ (void)ZYQshow;
/**
 弹出一个纯文本的提示框
 @param view 加载到那个视图上
 @param text 文本
 */
+ (void)ZYQshowAlertWithSuperView:(UIView *)view
                             Text:(NSString *)text;

/**
 弹出一个图片加文字的提示框
 @param view 加载到那个视图上
 @param text 文本
 @param imageStr 图片名称
 */
+ (void)ZYQshowAlertWithSuperView:(UIView *)view
                             Text:(NSString *)text
                            image:(NSString *)imageStr;

#pragma mark - 空白页加载视图
/**
 加载一个空白页加载视图
 @param view 加载到的视图
 */
+ (void)ZYQloadingViewWithSuperView:(UIView *)view;

#pragma mark - 网络请求加载gif动画

/**
 加载一个gif动画框加载效果

 @param superView 父视图
 @param isCoSave 是否是课程保存动画
 */
+ (void)ZYQloadingGIFAlertWithSuperView:(UIView *)superView isCourseSave:(BOOL)isCoSave;

/**
 加载一个gif动画框加载效果(这个页面覆盖)
 @param isCoSave 是否是课程保存动画
 */
+ (void)ZYQloadingGIFAlertIsCourseSave:(BOOL)isCoSave;
#pragma mark - 断网视图

/**
 加一个断网提示的视图
 
 @param superView 父视图
 @param image 图片
 @param title 文字
 @return 提示视图
 */
+ (UIView *)ZYQshowNetworkHintView:(UIView *)superView
                             image:(NSString *)image
                             title:(NSString *)title;
/**
 加一个断网提示的视图
 
 @param superView 父视图
 @param image 图片
 @param title 文字
 @param refreshBlock 点击刷新回调
 @return 提示视图
 */
+ (UIView *)ZYQshowNetworkHintView:(UIView *)superView
                             image:(NSString *)image
                             title:(NSString *)title
                      clickRefresh:(void(^)(UIView *superView))refreshBlock;

/**
 移除断网视图
 */
+ (void)ZYQremoveView;

@end
