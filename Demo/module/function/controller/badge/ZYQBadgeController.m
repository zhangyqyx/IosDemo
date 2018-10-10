//
//  ZYQBadgeController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQBadgeController.h"
#import "ZYQBadgeConfi.h"
#import "ZYQBadgeDeatilOneController.h"
#import "ZYQBadgeDeatilTwoController.h"

@interface ZYQBadgeController ()

@end

@implementation ZYQBadgeController
#define kIconTaskNormal            [UIImage imageNamed:@"courseIcon-normal"]
#define kIconTaskHover              [UIImage imageNamed:@"courseIcon-select"]
#define kIconGroupNormal             [UIImage imageNamed:@"groupIcon-normal"]
#define kIconGroupHover              [UIImage imageNamed:@"groupIcon-select"]
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"红点功能";
   
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[ZYQBadgeDeatilOneController alloc]init]]
                                title:@"detailOne"
                                image:kIconGroupNormal
                        selectedImage:kIconGroupHover
                              isFirst:YES];
    [self setupOneChildViewController:[[UINavigationController alloc] initWithRootViewController:[[ZYQBadgeDeatilTwoController alloc]init]]
                                title:@"detailTwo"
                                image:kIconTaskNormal
                        selectedImage:kIconTaskHover
                              isFirst:NO];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.view.ZYQ_viewY = -1;
    self.view.ZYQ_viewHeight = ZYQ_ScreenHeight +1;
    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.view.ZYQ_viewY = -1;
    self.view.ZYQ_viewHeight = ZYQ_ScreenHeight +1;
    
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage isFirst:(BOOL)isFirst{
    vc.tabBarItem.title = title;
    if (isFirst) {
        vc.tabBarItem.badgeCenterOffset = CGPointMake(0, 0);
        [vc.tabBarItem ZYQ_showBadgeWithStyle:ZYQBadgeStyleNew value:123 animationType:ZYQBadgeAnimTypeScale];
    }else {
        vc.tabBarItem.badgeCenterOffset = CGPointMake(-8, 0);
        [vc.tabBarItem ZYQ_showBadgeWithStyle:ZYQBadgeStyleNumber value:100 animationType:ZYQBadgeAnimTypeBounce];
    }
    if (image != nil) { // 图片名有具体值
        vc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [self addChildViewController:vc];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if ([item.title isEqualToString:@"detailTwo"]) {
        [item ZYQ_clearBadge];
    }
    
}

@end
