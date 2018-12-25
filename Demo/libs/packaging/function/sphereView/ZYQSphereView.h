//
//  ZYQSphereView.h
//  SphereTagDemo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQSphereModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZYQSphereType) {
    ZYQSphereDefaultType,
    ZYQSphereRandomType,
};


@class ZYQSphereView;

@protocol ZYQSphereViewDelegate <NSObject>

- (void)ZYQSphereView:(ZYQSphereView *)sphereView
            touchView:(UIButton *)touchBtn;

@end

@interface ZYQSphereView : UIView

/** 点击视图大小 默认 80 */
@property(nonatomic , assign)CGFloat size;
/** type */
@property(nonatomic , assign)ZYQSphereType sphereType;
/** delegate */
@property(nonatomic , weak)id<ZYQSphereViewDelegate> delegate;


/**
 创建item
 @param arrays 数组
 */
- (void)createItem:(NSArray<ZYQSphereModel *> *)arrays;


/**
 开始动画
 */
- (void)startAnimation;

/**
 结束动画
 */
- (void)stopAnimation;




@end

NS_ASSUME_NONNULL_END
