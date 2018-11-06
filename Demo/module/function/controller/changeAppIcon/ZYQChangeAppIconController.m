//
//  ZYQChangeAppIconController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/11/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQChangeAppIconController.h"

@interface ZYQChangeAppIconController ()

@end

@implementation ZYQChangeAppIconController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}
#pragma mark - 设置UI
- (void)createUI {
    self.navigationItem.title = @"修改图标";
    [self createLabel];
    [self createBtn];
    
}
- (void)createLabel {
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 300)];
    hintLabel.text = @"1、添加app图标(文件夹里面放入图标，不能d放在assets.xcassets里面)\n 2、修改info.plist文件，里面加入( Icon files (iOS 5) )key值 ,配置图标信息。\n 3、避免修改后弹框，加入UIViewController+Present 屏蔽弹框 。\n 4、修改app图标";
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.numberOfLines = 0;
    [self.view addSubview:hintLabel];
}
- (void)createBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"修改图标按钮" forState:UIControlStateNormal];
    [button setTitleColor:kNavColor forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 20, 200,21);
    button.center = CGPointMake(self.view.center.x, button.center.y);
    [button addTarget:self action:@selector(changeIcon:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)changeIcon:(UIButton *)sender {
    sender.selected = !sender.selected;
    [sender setTitle:@"修改已完成" forState:UIControlStateSelected];
    [sender setTitle:@"再次修改" forState:UIControlStateNormal];
    NSArray *datas = @[@"demoIcon" , @"health" , @"kcbIcon"];
    if (@available(iOS 10.3, *)) {
        if (![[UIApplication sharedApplication] supportsAlternateIcons]) return;
    } else {
        NSLog(@"不支持修改图标");
    }
    NSString *iconStr = datas[arc4random() % 3];
    
    if (@available(iOS 10.3, *)) {
        [[UIApplication sharedApplication] setAlternateIconName:iconStr completionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"error = %@" , error);
            }
            
        }];
    } else {
        NSLog(@"不支持修改图标");
    }
}


@end
