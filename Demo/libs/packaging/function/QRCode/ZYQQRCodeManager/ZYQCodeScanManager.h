//
//  ZYQCodeScanManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZYQCodeScanManager;
@protocol ZYQCodeScanManagerDelegate <NSObject>

@required
/**
 扫描二维码后的回调

 @param manager 二维码对象
 @param metadataObjects 回调信息
 */
- (void)ZYQ_codeScanManager:(ZYQCodeScanManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects;
@optional
/**
 光线的强弱回调

 @param manager 二维码对象
 @param brightnessValue 光线强弱值
 */
- (void)ZYQ_codeScanManager:(ZYQCodeScanManager *)manager brightnessValue:(CGFloat)brightnessValue;

@end

@interface ZYQCodeScanManager : NSObject

/** 代理对象 */
@property (nonatomic , weak)id<ZYQCodeScanManagerDelegate> delegate;
/**
 创建单例
 @return 单例对象
 */
+ (instancetype)ZYQSharedManager;
/**
 扫描二维码
 @param windowSize 扫描尺寸
 @param viewSize 视图尺寸
  @param currentController 当前控制器
 */
- (void )ZYQ_scanQRImage:(CGRect)windowSize
            viewSize:(CGRect)viewSize
      currentController:(UIViewController *)currentController;

/**
 开启会话对象扫描
 */
- (void)ZYQStartRunning;
/** 停止会话对象扫描 */
- (void)ZYQStopRunning;
/** 移除 videoPreviewLayer 对象 */
- (void)ZYQVideoPreviewLayerRemoveFromSuperlayer;
/** 播放音效文件 */
- (void)ZYQPalySoundName:(NSString *)name;
/** 重置根据光线强弱值打开手电筒的 delegate 方法 */
- (void)ZYQResetSampleBufferDelegate;
/** 取消根据光线强弱值打开手电筒的 delegate 方法 */
- (void)ZYQCancelSampleBufferDelegate;






@end
