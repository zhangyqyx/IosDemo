//
//  ZYQCodeDetailViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCodeDetailViewController.h"

@interface ZYQCodeDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation ZYQCodeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫描结果";
    self.detailLabel.text = self.titleStr;
    
}



@end
