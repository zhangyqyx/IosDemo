//
//  ZYQProgressHUDDetailController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQProgressHUDDetailController.h"
#import "UIViewController+Example.h"
#import "ZYQProgressHUD.h"

@interface ZYQProgressHUDDetailController ()


@end

@implementation ZYQProgressHUDDetailController


#define kLoadTime 2.0f

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"加载框";
    MJPerformSelectorLeakWarning(
                                 [self performSelector:NSSelectorFromString(self.method) withObject:nil];
                                 );
}


#pragma mark -  全局的透明背景的加载框，不自动消失
- (void)example01 {
    [ZYQProgressHUD ZYQloadingShowBg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kLoadTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQhide];
        [ZYQProgressHUD ZYQshowMessage:@"手动取消的加载" delay:kLoadTime];
    });
    
}
#pragma mark -  全局文本和图片提示框，自动消失
- (void)example02 {
    [ZYQProgressHUD ZYQshowAlertWithText:@"加载正确" image:@"ZYQHUDProgress.bundle/发布成功"];
}
#pragma mark -  全局文本提示框，自动消失
- (void)example03 {
    [ZYQProgressHUD ZYQshowMessage:@"加载错误" delay:kLoadTime];
}
#pragma mark -  有透明背景的加载框,不自动消失"
- (void)example04 {
    [ZYQProgressHUD ZYQloadingShowBgWithSuperView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kLoadTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQhide];
        [ZYQProgressHUD ZYQshowMessage:@"手动取消的加载" delay:kLoadTime];
    });
}
#pragma mark -  文字加载框，不自动消失
- (void)example05 {
    [ZYQProgressHUD ZYQloadingAlertWithSuperView:self.view text:@"正在加载"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kLoadTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQhide];
        [ZYQProgressHUD ZYQshowMessage:@"手动取消的加载" delay:kLoadTime];
    });
}
#pragma mark - 文本提示框,自动消失
- (void)example06 {
    [ZYQProgressHUD ZYQshowAlertWithSuperView:self.view Text:@"加载错误"];
}
#pragma mark -  图片、文字的提示框,自动消失
- (void)example07 {
    ZYQLog(@"frame == %@" , NSStringFromCGPoint(self.view.center));
    [ZYQProgressHUD ZYQshowAlertWithSuperView:self.view Text:@"加载错误" image:@"ZYQHUDProgress.bundle/发布失败"];
}
#pragma mark -  全局文字加载框，不自动消失
- (void)example08 {
    [ZYQProgressHUD ZYQloadingAlertWithText:@"正在加载"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kLoadTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQhide];
        [ZYQProgressHUD ZYQshowMessage:@"手动取消的加载" delay:kLoadTime];
    });
}
#pragma mark - 加一个断网提示的视图
- (void)example09 {
    //    [ZYQProgressHUD ZYQshowNetworkHintView:self.view image:@"网络断开" title:@"网络连接异常\n请检查网络后点击页面刷新"];
    [ZYQProgressHUD ZYQshowNetworkHintView:self.view image:@"ZYQHUDProgress.bundle/网络断开" title:@"网络连接异常\n请检查网络后刷新" clickRefresh:^(UIView *superView) {
        [ZYQProgressHUD ZYQshowMessage:@"点击了刷新视图"];
    }];
}
#pragma mark - 加一个空白页加载的视图
- (void)example10 {
    [ZYQProgressHUD ZYQloadingViewWithSuperView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQremoveView];
        [ZYQProgressHUD ZYQshowMessage:@"4s后手动取消的视图" delay:1.0f];
    });
}
#pragma mark - 加一个gif加载的视图
- (void)example11 {
    [ZYQProgressHUD ZYQloadingGIFAlertIsCourseSave:false];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQProgressHUD ZYQremoveView];
        [ZYQProgressHUD ZYQshowMessage:@"4s后手动移除的视图" delay:1.0f];
    });
}


@end
