//
//  ZYQCodeAlbumManager.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import "ZYQCodeAlbumManager.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface ZYQCodeAlbumManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, strong) NSString *detectorString;

@end


@implementation ZYQCodeAlbumManager
static ZYQCodeAlbumManager *_instance;

+ (instancetype)ZYQsharedManager  {
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}


- (void)ZYQ_readCodeFromAlbumWithCurrentController:(UIViewController *)currentController {
    
    self.currentVC = currentController;
    
    if (currentController == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"readQRCodeFromAlbumWithCurrentController: 方法中的 currentController 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) { // 用户第一次同意了访问相册权限
                    self.isPHAuthorization = YES;
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self enterImagePickerController];
                    });
                } else { // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户没有访问相机权限");
                }
            }];
            
        } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
            self.isPHAuthorization = YES;
            [self enterImagePickerController];
        } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册
            [self enterImagePickerController];
        } else if (status == PHAuthorizationStatusRestricted) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于系统原因, 无法访问相册" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [self.currentVC presentViewController:alertC animated:YES completion:nil];
        }
    }
    
    
}
// 进入 UIImagePickerController
- (void)enterImagePickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.currentVC dismissViewControllerAnimated:YES completion:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZYQ_codeAlbumManagerDidCancelWithImagePickerController:)]) {
        [self.delegate ZYQ_codeAlbumManagerDidCancelWithImagePickerController:self];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 对选取照片的处理，如果选取的图片尺寸过大，则压缩选取图片，否则不作处理
    UIImage *image = [self imageSizeWithScreenImage:info[UIImagePickerControllerOriginalImage]];
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count == 0) {
        NSLog(@"暂未识别出扫描的二维码 - - %@", features);
        [self.currentVC dismissViewControllerAnimated:YES completion:nil];
        return;
    } else {
        for (int index = 0; index < [features count]; index ++) {
            CIQRCodeFeature *feature = [features objectAtIndex:index];
            NSString *resultStr = feature.messageString;
                NSLog(@"相册中读取二维码数据信息 - - %@", resultStr);
            self.detectorString = resultStr;
        }
        [self.currentVC dismissViewControllerAnimated:YES completion:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(ZYQ_codeAlbumManager:didFinishPickingMediaWithResult:)]) {
                [self.delegate ZYQ_codeAlbumManager:self didFinishPickingMediaWithResult:self.detectorString];
            }
        }];
    }
}


/// 返回一张不超过屏幕尺寸的 image
- (UIImage *)imageSizeWithScreenImage:(UIImage *)image {
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    if (imageWidth <= screenWidth && imageHeight <= screenHeight) {
        return image;
    }
    CGFloat max = MAX(imageWidth, imageHeight);
    CGFloat scale = max / (screenHeight * 2.0);
    
    CGSize size = CGSizeMake(imageWidth / scale, imageHeight / scale);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
