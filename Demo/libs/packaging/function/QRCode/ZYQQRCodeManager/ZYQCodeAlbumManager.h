//
//  ZYQCodeAlbumManager.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ZYQCodeAlbumManager;
@protocol ZYQCodeAlbumManagerDelegate <NSObject>

@required

/**
 图片选择控制器取消按钮的点击回调方法

 @param albumManager 识别图片对象
 */
- (void)ZYQ_codeAlbumManagerDidCancelWithImagePickerController:(ZYQCodeAlbumManager *)albumManager;
/**
 图片选择控制器选取图片完成之后的回调方法

 @param albumManager 识别图片对象
 @param result 获取的二维码数据
 */
- (void)ZYQ_codeAlbumManager:(ZYQCodeAlbumManager *)albumManager didFinishPickingMediaWithResult:(NSString *)result;

@end

@interface ZYQCodeAlbumManager : NSObject

/** 快速创建单利方法 */
+ (instancetype)ZYQsharedManager;
/** 代理对象  */
@property (nonatomic, weak) id<ZYQCodeAlbumManagerDelegate> delegate;
/** 判断相册访问权限是否授权 */
@property (nonatomic, assign) BOOL isPHAuthorization;

/** 从相册中读取二维码方法，必须实现的方法 */
- (void)ZYQ_readCodeFromAlbumWithCurrentController:(UIViewController *)currentController;





@end
