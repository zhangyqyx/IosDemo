//
//  ZYQCodeScanningView.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//


#import "ZYQCodeScanningView.h"

@interface ZYQCodeScanningView ()
{
    UIView *_contentView;
    NSTimer *_timer;
   
    /** 扫描内容的 W 值 */
    CGFloat _scanBorderW;
    /** 扫描内容的 H 值 */
    CGFloat _scanBorderH;
    /** 扫描内容的 x 值*/
    CGFloat _scanBorderX;
    /** 扫描内容的 Y 值 */
    CGFloat _scanBorderY;
}
/** 动画图片 */
@property (nonatomic , strong) UIImageView *scanningline;;


@end

@implementation ZYQCodeScanningView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self initialization];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];

}
- (void)initialization {
    _scnningType = ZYQScanningAnimationTypeDefault;
    _borderColor = [UIColor whiteColor];
    _cornerLocation = ZYQCornerLocationDefault;
    _cornerColor = [UIColor colorWithRed:85/255.0f green:183/255.0 blue:55/255.0 alpha:1.0];
    _cornerWidth = 2.0;
    _backgroundAlpha = 0.5;
    _animationTimeInterval = 0.02;
    _scanningImageName = @"ZYQQRCode.bundle/QRCodeScanningLine.png";
    _scanBorderW = self.frame.size.width * 0.8;
    _scanBorderH = _scanBorderW;
    _scanBorderX =  0.5 * (self.frame.size.width - _scanBorderW);
    _scanBorderY =  0.5 * (self.frame.size.height - _scanBorderH);
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(_scanBorderX, _scanBorderY, _scanBorderW, _scanBorderW);
        _contentView.clipsToBounds = YES;
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}
- (UIImageView *)scanningline {
    if (!_scanningline) {
        _scanningline = [[UIImageView alloc] init];
        _scanningline.image = [UIImage imageNamed:self.scanningImageName];
    }
    return _scanningline;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    /// 边框 frame
    CGFloat borderW = _scanBorderW;
    CGFloat borderH = _scanBorderH;
    CGFloat borderX = _scanBorderX;
    CGFloat borderY = _scanBorderY;
    CGFloat borderLineW = 0.2;
    
    /// 空白区域设置
    [[[UIColor blackColor] colorWithAlphaComponent:self.backgroundAlpha] setFill];
    UIRectFill(rect);
    // 获取上下文，并设置混合模式 -> kCGBlendModeDestinationOut
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    // 设置空白区
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderX + 0.5 * borderLineW, borderY + 0.5 *borderLineW, borderW - borderLineW, borderH - borderLineW)];
    [bezierPath fill];
    // 执行混合模式
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    /// 边框设置
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:CGRectMake(borderX, borderY, borderW, borderH)];
    borderPath.lineCapStyle = kCGLineCapButt;
    borderPath.lineWidth = borderLineW;
    [self.borderColor set];
    [borderPath stroke];
    
    
    CGFloat cornerLenght = 20;
    /// 左上角小图标
    UIBezierPath *leftTopPath = [UIBezierPath bezierPath];
    leftTopPath.lineWidth = self.cornerWidth;
    [self.cornerColor set];
    
    CGFloat insideExcess = fabs(0.5 * (self.cornerWidth - borderLineW));
    CGFloat outsideExcess = 0.5 * (borderLineW + self.cornerWidth);
    if (self.cornerLocation == ZYQCornerLocationInside) {
        [leftTopPath moveToPoint:CGPointMake(borderX + insideExcess, borderY + cornerLenght + insideExcess)];
        [leftTopPath addLineToPoint:CGPointMake(borderX + insideExcess, borderY + insideExcess)];
        [leftTopPath addLineToPoint:CGPointMake(borderX + cornerLenght + insideExcess, borderY + insideExcess)];
    } else if (self.cornerLocation == ZYQCornerLocationOutside) {
        [leftTopPath moveToPoint:CGPointMake(borderX - outsideExcess, borderY + cornerLenght - outsideExcess)];
        [leftTopPath addLineToPoint:CGPointMake(borderX - outsideExcess, borderY - outsideExcess)];
        [leftTopPath addLineToPoint:CGPointMake(borderX + cornerLenght - outsideExcess, borderY - outsideExcess)];
    } else {
        [leftTopPath moveToPoint:CGPointMake(borderX, borderY + cornerLenght)];
        [leftTopPath addLineToPoint:CGPointMake(borderX, borderY)];
        [leftTopPath addLineToPoint:CGPointMake(borderX + cornerLenght, borderY)];
    }
    
    [leftTopPath stroke];
    
    /// 左下角小图标
    UIBezierPath *leftBottomPath = [UIBezierPath bezierPath];
    leftBottomPath.lineWidth = self.cornerWidth;
    [self.cornerColor set];
    
    if (self.cornerLocation == ZYQCornerLocationInside) {
        [leftBottomPath moveToPoint:CGPointMake(borderX + cornerLenght + insideExcess, borderY + borderH - insideExcess)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX + insideExcess, borderY + borderH - insideExcess)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX + insideExcess, borderY + borderH - cornerLenght - insideExcess)];
    } else if (self.cornerLocation == ZYQCornerLocationOutside) {
        [leftBottomPath moveToPoint:CGPointMake(borderX + cornerLenght - outsideExcess, borderY + borderH + outsideExcess)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX - outsideExcess, borderY + borderH + outsideExcess)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX - outsideExcess, borderY + borderH - cornerLenght + outsideExcess)];
    } else {
        [leftBottomPath moveToPoint:CGPointMake(borderX + cornerLenght, borderY + borderH)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX, borderY + borderH)];
        [leftBottomPath addLineToPoint:CGPointMake(borderX, borderY + borderH - cornerLenght)];
    }
    
    [leftBottomPath stroke];
    
    /// 右上角小图标
    UIBezierPath *rightTopPath = [UIBezierPath bezierPath];
    rightTopPath.lineWidth = self.cornerWidth;
    [self.cornerColor set];
    
    if (self.cornerLocation == ZYQCornerLocationInside) {
        [rightTopPath moveToPoint:CGPointMake(borderX + borderW - cornerLenght - insideExcess, borderY + insideExcess)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW - insideExcess, borderY + insideExcess)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW - insideExcess, borderY + cornerLenght + insideExcess)];
    } else if (self.cornerLocation == ZYQCornerLocationOutside) {
        [rightTopPath moveToPoint:CGPointMake(borderX + borderW - cornerLenght + outsideExcess, borderY - outsideExcess)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW + outsideExcess, borderY - outsideExcess)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW + outsideExcess, borderY + cornerLenght - outsideExcess)];
    } else {
        [rightTopPath moveToPoint:CGPointMake(borderX + borderW - cornerLenght, borderY)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW, borderY)];
        [rightTopPath addLineToPoint:CGPointMake(borderX + borderW, borderY + cornerLenght)];
    }
    
    [rightTopPath stroke];
    
    /// 右下角小图标
    UIBezierPath *rightBottomPath = [UIBezierPath bezierPath];
    rightBottomPath.lineWidth = self.cornerWidth;
    [self.cornerColor set];
    
    if (self.cornerLocation == ZYQCornerLocationInside) {
        [rightBottomPath moveToPoint:CGPointMake(borderX + borderW - insideExcess, borderY + borderH - cornerLenght - insideExcess)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW - insideExcess, borderY + borderH - insideExcess)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW - cornerLenght - insideExcess, borderY + borderH - insideExcess)];
    } else if (self.cornerLocation == ZYQCornerLocationOutside) {
        [rightBottomPath moveToPoint:CGPointMake(borderX + borderW + outsideExcess, borderY + borderH - cornerLenght + outsideExcess)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW + outsideExcess, borderY + borderH + outsideExcess)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW - cornerLenght + outsideExcess, borderY + borderH + outsideExcess)];
    } else {
        [rightBottomPath moveToPoint:CGPointMake(borderX + borderW, borderY + borderH - cornerLenght)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW, borderY + borderH)];
        [rightBottomPath addLineToPoint:CGPointMake(borderX + borderW - cornerLenght, borderY + borderH)];
    }
    [rightBottomPath stroke];
}

#pragma mark - - - 添加定时器
- (void)addTimer {
    CGFloat scanninglineX = 0;
    CGFloat scanninglineY = 0;
    CGFloat scanninglineW = 0;
    CGFloat scanninglineH = 0;
    if (self.scnningType == ZYQScanningAnimationTypeGrid) {
        [self addSubview:self.contentView];
        [_contentView addSubview:self.scanningline];
        scanninglineW = _scanBorderW;
        scanninglineH = _scanBorderH;
        scanninglineX = 0;
        scanninglineY = _scanBorderH;
        _scanningline.frame = CGRectMake(scanninglineX, scanninglineY, scanninglineW, scanninglineH);
        
    } else {
        [self addSubview:self.scanningline];
        
        scanninglineW = _scanBorderW;
        scanninglineH = 12;
        scanninglineX = _scanBorderX;
        scanninglineY = _scanBorderY;
        _scanningline.frame = CGRectMake(scanninglineX, scanninglineY, scanninglineW, scanninglineH);
    }
    _timer = [NSTimer timerWithTimeInterval:self.animationTimeInterval target:self selector:@selector(beginRefreshUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark - - - 移除定时器
- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
    [self.scanningline removeFromSuperview];
    _scanningline = nil;
}
#pragma mark - - - 执行定时器方法
//这里写出现警告的代码就能实现去除警告
- (void)beginRefreshUI {
    __block CGRect frame = _scanningline.frame;
    static BOOL flag = YES;
    if (self.scnningType == ZYQScanningAnimationTypeGrid) {
        if (flag) {
            frame.origin.y = -_scanBorderH;
            flag = NO;
            [UIView animateWithDuration:_animationTimeInterval animations:^{
                frame.origin.y += 2;
               self.scanningline.frame = frame;
            } completion:nil];
        } else {
            if (self.scanningline.frame.origin.y >= - _scanBorderH) {
                CGFloat scanContent_MaxY = - _scanBorderH + self.frame.size.height - 2 * _scanBorderY;
                if (_scanningline.frame.origin.y >= scanContent_MaxY) {
                    __weak __typeof(self)weakSelf = self;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        __strong __typeof(weakSelf)strongSelf = weakSelf;
                        frame.origin.y = - strongSelf->_scanBorderH;
                        self.scanningline.frame = frame;
                        flag = YES;
                    });
                } else {
                    [UIView animateWithDuration:_animationTimeInterval animations:^{
                        frame.origin.y += 2;
                        self.scanningline.frame = frame;
                    } completion:nil];
                }
            } else {
                flag = !flag;
            }
        }
    } else {
        if (flag) {
            frame.origin.y = _scanBorderY;
            flag = NO;
            [UIView animateWithDuration:_animationTimeInterval animations:^{
                frame.origin.y += 2;
                 self.scanningline.frame = frame;
            } completion:nil];
        } else {
            if (self.scanningline.frame.origin.y >= _scanBorderY) {
                CGFloat scanContent_MaxY = _scanBorderY + self.frame.size.height - 2 * _scanBorderY;
                if (self.scanningline.frame.origin.y >= scanContent_MaxY - 10) {
                    frame.origin.y = _scanBorderY;
                     self.scanningline.frame = frame;
                    flag = YES;
                } else {
                    [UIView animateWithDuration:_animationTimeInterval animations:^{
                        frame.origin.y += 2;
                         self.scanningline.frame = frame;
                    } completion:nil];
                }
            } else {
                flag = !flag;
            }
        }
    }
}
- (void)setScnningType:(ZYQScanningAnimationType)scnningType {
    _scnningType = scnningType;
}
- (void)setScanningImageName:(NSString *)scanningImageName {
    _scanningImageName = scanningImageName;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
}

- (void)setCornerLocation:(ZYQCornerLocation)cornerLocation {
    _cornerLocation = cornerLocation;
}

- (void)setCornerColor:(UIColor *)cornerColor {
    _cornerColor = cornerColor;
}

- (void)setCornerWidth:(CGFloat)cornerWidth {
    _cornerWidth = cornerWidth;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    _backgroundAlpha = backgroundAlpha;
}

- (void)setAnimationTimeInterval:(NSTimeInterval)animationTimeInterval {
    _animationTimeInterval = animationTimeInterval;
}

- (void)setScanSize:(CGSize)scanSize {
    _scanSize     = scanSize;
   _scanBorderW  = scanSize.width;
   _scanBorderH  = scanSize.height;
   _scanBorderX  =  0.5 * (self.frame.size.width - _scanBorderW);
   _scanBorderY  =  0.5 * (self.frame.size.height - _scanBorderH);
    
}


@end
