//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  ZYQSphereViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQSphereViewController.h"
#import "ZYQSphereView.h"

@interface ZYQSphereViewController ()<ZYQSphereViewDelegate>
@property (nonatomic,strong) ZYQSphereView *sphereView;

@end

@implementation ZYQSphereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
- (void)createUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"标签选择";
    CGFloat sphereViewW = self.view.frame.size.width - 30 * 2;
    CGFloat sphereViewH = sphereViewW;
    _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(30, 100, sphereViewW, sphereViewH)];
    _sphereView.sphereType = ZYQSphereRandomType;
    _sphereView.delegate = self;
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i = 0; i < 25; i ++) {
        NSString *imageStr = [NSString stringWithFormat:@"image%u" , arc4random_uniform(9)];
        ZYQSphereModel *model = [ZYQSphereModel createModel:@"" imageStr:imageStr];
        [itemArr addObject:model];
    }
    [_sphereView createItem:itemArr];
    [self.view addSubview:_sphereView];
}
#pragma mark -  delegate
- (void)ZYQSphereView:(ZYQSphereView *)sphereView touchView:(UIButton *)touchBtn {
    [sphereView startAnimation];
}

@end
