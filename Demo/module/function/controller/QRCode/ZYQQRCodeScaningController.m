//
//  ZYQQRCodeScaningController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQQRCodeScaningController.h"
#import "ZYQCode.h"
#import <AVFoundation/AVFoundation.h>
#import "ZYQCodeDetailViewController.h"

@interface ZYQQRCodeScaningController ()<ZYQCodeScanManagerDelegate>
/** 扫描视图 */
@property (nonatomic , strong)ZYQCodeScanningView *scanningView;
/** 扫描对象 */
@property (nonatomic , strong)ZYQCodeScanManager *manager;

/** 提示文字 */
@property (nonatomic , strong)UILabel *hintLabel;
/** 手电筒开关 */
@property (nonatomic , strong)UIButton *flashlightBtn;


@end

@implementation ZYQQRCodeScaningController
- (ZYQCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [[ZYQCodeScanningView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scanningView.scanningImageName = @"ZYQQRCode.bundle/scan_net.png";
        _scanningView.scnningType = ZYQScanningAnimationTypeGrid;
        _scanningView.scanSize = CGSizeMake(260, 260);
        _scanningView.cornerColor = [UIColor orangeColor];
    }
    return _scanningView;
}
- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 80, 300, 21)];
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _hintLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _hintLabel.text = @"将二维码/条码放入框内, 即可自动扫描";
    }
    return _hintLabel;
}

- (UIButton *)flashlightBtn {
    if (!_flashlightBtn) {
        _flashlightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat flashlightBtnW = 35;
        CGFloat flashlightBtnH = 35;
        CGFloat flashlightBtnX = 0.5 * (self.view.frame.size.width - flashlightBtnW);
        CGFloat flashlightBtnY = 0.6 * self.view.frame.size.height;
        _flashlightBtn.frame = CGRectMake(flashlightBtnX, flashlightBtnY, flashlightBtnW, flashlightBtnH);
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightCloseImage"] forState:UIControlStateNormal];
        [_flashlightBtn setBackgroundImage:[UIImage imageNamed:@"SGQRCodeFlashlightOpenImage"] forState:UIControlStateSelected];
        [_flashlightBtn addTarget:self action:@selector(flashlightBtn_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashlightBtn;
}




- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNav];
    [self setupUI];
    [self setupManager];
    [self.scanningView addTimer];
    [_manager ZYQResetSampleBufferDelegate];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    [self removeFlashlightBtn];
    [_manager ZYQCancelSampleBufferDelegate];
}
- (void)dealloc {
    [self removeScanningView];
}

- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)setupNav {
    self.navigationItem.title = @"扫一扫";
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scanningView];
    [self.view addSubview:self.hintLabel];
}
- (void)setupManager {
    self.manager = [ZYQCodeScanManager ZYQSharedManager];
    [_manager ZYQ_scanQRImage:CGRectMake(0, 0, 260, 260) viewSize:[UIScreen mainScreen].bounds currentController:self];
    
    _manager.delegate = self;
}




#pragma  mark - ZYQCodeScanManagerDelegate

- (void)ZYQ_codeScanManager:(ZYQCodeScanManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects {
    NSLog(@"ZYQCodeScanManagerDelegate =  %@" , metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [manager ZYQPalySoundName:@"ZYQQRCode.bundle/sound.caf"];
        [manager ZYQStopRunning];
        [manager ZYQVideoPreviewLayerRemoveFromSuperlayer];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"obj  ==%@" , obj.stringValue);
        ZYQCodeDetailViewController * detailVc = [[ZYQCodeDetailViewController alloc] init];
        detailVc.titleStr = obj.stringValue;
        [self.navigationController pushViewController:detailVc animated:YES];
    }else {
        NSLog(@"暂未识别出扫描的二维码");
    }
    
    
    
    
    
}


- (void)ZYQ_codeScanManager:(ZYQCodeScanManager *)manager brightnessValue:(CGFloat)brightnessValue {
    if (brightnessValue <  -1) {
        [self.view addSubview:self.flashlightBtn];
        return;
    }
    if (!self.flashlightBtn.selected) {
        [self removeFlashlightBtn];
    }
}

#pragma mark - 按钮操作
- (void)flashlightBtn_action:(UIButton *)button {
    if (button.selected == NO) {
        [ZYQCodeHelperTool ZYQ_openFlashlight];
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}
- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZYQCodeHelperTool ZYQ_closeFlashlight];
        self.flashlightBtn.selected = NO;
        [self.flashlightBtn removeFromSuperview];
    });
}





@end
