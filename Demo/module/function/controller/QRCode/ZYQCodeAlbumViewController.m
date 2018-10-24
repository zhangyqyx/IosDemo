//
//  ZYQCodeAlbumViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQCodeAlbumViewController.h"
#import "ZYQCode.h"
#import "ZYQCodeDetailViewController.h"

@interface ZYQCodeAlbumViewController ()<ZYQCodeAlbumManagerDelegate>



@end

@implementation ZYQCodeAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"相册导入二维码";
    
    
}

- (IBAction)channelCode:(id)sender {
    
    ZYQCodeAlbumManager *manager = [[ZYQCodeAlbumManager alloc] init];
    [manager ZYQ_readCodeFromAlbumWithCurrentController:self];
    manager.delegate = self;
}
#pragma mark - ZYQCodeAlbumManagerDelegate
- (void)ZYQ_codeAlbumManagerDidCancelWithImagePickerController:(ZYQCodeAlbumManager *)albumManager {
    NSLog(@"取消了操作");
}

- (void)ZYQ_codeAlbumManager:(ZYQCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result {
    ZYQCodeDetailViewController * detailVc = [[ZYQCodeDetailViewController alloc] init];
    detailVc.titleStr = result;
    [self.navigationController pushViewController:detailVc animated:YES];
}




@end
