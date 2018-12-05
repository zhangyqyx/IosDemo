//
//  UIViewController+ZYQTransitionAnimation.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/3.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIViewController+ZYQTransitionAnimation.h"
#import <objc/message.h>

static NSString *ZYQPushTranstionKey     = @"ZYQPushTranstionKey";
static NSString *ZYQPopTranstionKey      = @"ZYQPopTranstionKey";
static NSString *ZYQPresentTranstionKey  = @"ZYQPresentTranstionKey";
static NSString *ZYQDismissTranstionKey  = @"ZYQDismissTranstionKey";
@implementation UIViewController (ZYQTransitionAnimation)

#pragma mark -- 添加属性
//push/pop
- (void)setZYQ_pushTranstion:(ZYQTransitonAnimation *)ZYQ_pushTranstion {
    if (ZYQ_pushTranstion) {
        ZYQ_pushTranstion.transitonType      = ZYQTransitonAnimationTypeShow;
        self.navigationController.delegate  = self;
        objc_setAssociatedObject(self, &ZYQPushTranstionKey, ZYQ_pushTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (ZYQTransitonAnimation *)ZYQ_pushTranstion {
    return objc_getAssociatedObject(self, &ZYQPushTranstionKey);
}
- (void)setZYQ_popTransition:(ZYQTransitonAnimation *)ZYQ_popTransition {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ZYQ_popTransition) {
            ZYQ_popTransition.transitonType      = ZYQTransitonAnimationTypeHide;
            self.navigationController.delegate  = self;
            objc_setAssociatedObject(self, &ZYQPopTranstionKey, ZYQ_popTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    });
}
- (ZYQTransitonAnimation *)ZYQ_popTransition {
    return objc_getAssociatedObject(self, &ZYQPopTranstionKey);
}
//present/dismiss
- (void)setZYQ_presentTranstion:(ZYQTransitonAnimation *)ZYQ_presentTranstion {
    if (ZYQ_presentTranstion) {
        ZYQ_presentTranstion.transitonType   = ZYQTransitonAnimationTypeShow;
        self.transitioningDelegate          = self;
        objc_setAssociatedObject(self, &ZYQPresentTranstionKey, ZYQ_presentTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (ZYQTransitonAnimation *)ZYQ_presentTranstion {
    return objc_getAssociatedObject(self, &ZYQPresentTranstionKey);
}
- (void)setZYQ_dismissTransition:(ZYQTransitonAnimation *)ZYQ_dismissTransition {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ZYQ_dismissTransition) {
            ZYQ_dismissTransition.transitonType   = ZYQTransitonAnimationTypeHide;
            self.transitioningDelegate          = self;
            objc_setAssociatedObject(self, &ZYQDismissTranstionKey, ZYQ_dismissTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    });
   
}
- (ZYQTransitonAnimation *)ZYQ_dismissTransition {
    return objc_getAssociatedObject(self, &ZYQDismissTranstionKey);
}
#pragma mark -- push和pop动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush && [fromVC isEqual:self]) {
        return self.ZYQ_pushTranstion;
    }else if (operation == UINavigationControllerOperationPop && [toVC isEqual:self]) {
        return self.ZYQ_popTransition;
    }else {
        return nil;
    }
}

#pragma mark -- present和dismiss动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return (id<UIViewControllerAnimatedTransitioning>)self.ZYQ_presentTranstion;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return (id<UIViewControllerAnimatedTransitioning>)self.ZYQ_dismissTransition;
}

@end
