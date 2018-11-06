//
//  UIViewController+Present.m
//  ChangeAppIcon
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "UIViewController+Present.h"
#import <objc/runtime.h>

@implementation UIViewController (Present)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController: animated: completion:));
        Method changeM = class_getInstanceMethod(self.class, @selector(ZYQ_presentViewController: animated: completion:));
        method_exchangeImplementations(presentM, changeM);
    });
    
}


- (void)ZYQ_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
        
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        }
        
    }
    [self ZYQ_presentViewController:viewControllerToPresent animated:flag completion:completion];
}



@end
