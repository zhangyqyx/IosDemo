//
//  ZYQProgressHUD.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/26.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQProgressHUD.h"
#import "MBProgressHUD.h"
#import "ZYQMusicAnimation.h"
#import "FLAnimatedImage.h"
typedef void(^ZYQProgressRefreshBlock)(UIView *superView);
@interface ZYQProgressHUD ()
/**hub */
@property (nonatomic , strong)MBProgressHUD *hud;
/**断网视图 */
@property (nonatomic , strong)UIView *networkHintView;

/**空白页动画视图 */
@property (nonatomic , strong)UIView *showAnmiationView;
/**加载gif视图 */
@property (nonatomic , strong)UIView *alertLoadingGifView;
/**点击刷新视图回调 */
@property (nonatomic , strong)ZYQProgressRefreshBlock refreshBlock;

@end

@implementation ZYQProgressHUD

#define kHideTime 1.0f
#define kColor    [UIColor whiteColor]//[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0f];
#define kBgColor  [UIColor colorWithRed:0.482 green:0.486 blue:0.490 alpha:0.600]
#define kFont     [UIFont fontWithName:@"PingFang-SC-Regular" size:15]
#define kFontColor   [UIColor blackColor]//[UIColor whiteColor]

+ ZYQsharedProgressHUD {
   static ZYQProgressHUD *_TFHud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _TFHud = [[ZYQProgressHUD alloc] init];
    });
  
    return _TFHud;
}


+ (instancetype)ZYQloadingShowBgWithSuperView:(UIView *)view {
    ZYQProgressHUD *tfHud   = [ZYQProgressHUD ZYQsharedProgressHUD];
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundColor     = kBgColor;
    hud.bezelView.color     = [UIColor clearColor];
    tfHud.hud               = hud;
    return tfHud;
}

+ (instancetype)ZYQloadingShowBg {
    ZYQProgressHUD *tfHud   = [ZYQProgressHUD ZYQsharedProgressHUD];
    MBProgressHUD *hud      = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
    [[UIApplication sharedApplication].delegate.window addSubview:hud];
    hud.backgroundColor     = kBgColor;
    hud.bezelView.color   = [UIColor clearColor];
    tfHud.hud               = hud;
    [hud showAnimated:YES];
    return tfHud;
}
+ (instancetype)ZYQloadingAlertWithText:(NSString *)text {
    return [self ZYQloadingAlertWithSuperView:[UIApplication sharedApplication].delegate.window
                                        text:text];
}

+ (instancetype)ZYQloadingAlertWithSuperView:(UIView *)view text:(NSString*)title {
    ZYQProgressHUD *tfHud   = [ZYQProgressHUD ZYQsharedProgressHUD];
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color     = kColor;
    hud.label.text          = title;
    hud.square              = YES;
    hud.contentColor        = kFontColor;
    hud.backgroundColor     = kBgColor;
    hud.label.font          = kFont;
    hud.margin              = 15;
    hud.label.numberOfLines = 0;
    tfHud.hud               = hud;
    [self showShadowWithView:hud];
    return tfHud;
}


+ (void)ZYQhide {
    ZYQProgressHUD *tfHud  = [ZYQProgressHUD ZYQsharedProgressHUD];
    [tfHud.hud hideAnimated:YES afterDelay:0.0f];
    [tfHud.hud removeFromSuperview];
}
+ (void)ZYQshow {
   ZYQProgressHUD *tfHud    = [ZYQProgressHUD ZYQsharedProgressHUD];
    [tfHud.hud showAnimated:YES];
}
+ (void)ZYQshowAlertWithSuperView:(UIView *)view Text:(NSString *)text{
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode                = MBProgressHUDModeText;
    hud.label.text          = text;
    hud.center              = view.center;
    hud.bezelView.color     = kColor;
    hud.label.font          = kFont;
    hud.contentColor        = kFontColor;
    hud.margin              = 15;
//    hud.yOffset         = view.frame.size.height;
    [self showShadowWithView:hud];
    [hud hideAnimated:YES afterDelay:kHideTime];
}
+ (void)ZYQshowAlertWithSuperView:(UIView *)view Text:(NSString *)text image:(NSString *)imageStr {
    //设置一个小的view限定宽度
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, view.frame.size.width * 0.5, view.frame.size.width * 0.5);
    bgView.center = CGPointMake(view.center.x, view.center.y);
     [self showShadowWithView:bgView];
    [view addSubview:bgView];
    MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:bgView animated:YES];
    hud.mode                = MBProgressHUDModeCustomView;
    UIImage *image          = [[UIImage imageNamed:imageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    hud.customView          = [[UIImageView alloc] initWithImage:image];
    hud.square              = YES;
    hud.label.text          = text;
    hud.label.numberOfLines = 0;
    hud.label.font          = kFont;
    hud.contentColor        = kFontColor;
    hud.bezelView.color     = kColor;
    hud.margin              = 15;
    [hud hideAnimated:YES afterDelay:kHideTime];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kHideTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bgView removeFromSuperview];
    });

    
}
+ (void)ZYQshowAlertWithText:(NSString *)text image:(NSString *)imageStr {
    [self ZYQshowAlertWithSuperView:[UIApplication sharedApplication].delegate.window Text:text image:imageStr];
    
}
#pragma mark -- 全局显示一个文本
+ (void)ZYQshowMessage:(NSString *)msg{
    [self ZYQshowMessage:msg delay:kHideTime];
}

+ (void)ZYQshowMessage:(NSString *)msg delay:(CGFloat)seconds{
    [self ZYQshowMessage:msg delay:seconds completion:nil];
    
}

+ (void)ZYQshowMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)(void))completion
{
    if ([self isEmpty:msg])
    {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud      = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].delegate.window];
        [[UIApplication sharedApplication].delegate.window addSubview:hud];
        hud.mode                = MBProgressHUDModeText;
        hud.label.text          = msg;
        hud.label.font          = kFont;
        hud.label.numberOfLines = 0;
        hud.contentColor        = kFontColor;
        hud.bezelView.color     = kColor;
        hud.margin              = 15;
        [self showShadowWithView:hud];
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:seconds];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion)
            {
                completion();
            }
        });
    
    });
}
+ (BOOL)isEmpty:(NSString *)string
{
    return string == nil || string.length == 0;
}
#pragma mark - 空白页加载视图
/**
 加载一个空白页加载视图
 @param view 加载到的视图
 */
+ (void)ZYQloadingViewWithSuperView:(UIView *)view {
    [[ZYQProgressHUD ZYQsharedProgressHUD] ZYQloadingViewWithSuperView:view];
}
- (void)ZYQloadingViewWithSuperView:(UIView *)view {
    self.showAnmiationView  = [[UIView alloc] initWithFrame:view.frame];
    self.showAnmiationView.backgroundColor = kBgColor;
    [view addSubview:self.showAnmiationView];
    ZYQMusicAnimation *animation     =  [[ZYQMusicAnimation alloc] init];
    UIView * hudView                = [[UIView alloc] initWithFrame:CGRectMake(0, 0,90, 60)];
    hudView.center                  = self.showAnmiationView.center;
    [self.showAnmiationView addSubview:hudView];
    [animation configAnimationAtLayer:hudView.layer];
}
#pragma mark - 网络请求加载gif动画
+ (void)ZYQloadingGIFAlertWithSuperView:(UIView *)superView isCourseSave:(BOOL)isCoSave {
    [[ZYQProgressHUD ZYQsharedProgressHUD] ZYQloadingGIFAlertWithSuperView:superView isCourseSave:isCoSave];
}
- (void)ZYQloadingGIFAlertWithSuperView:(UIView *)superView isCourseSave:(BOOL)isCoSave {
    self.alertLoadingGifView = [[UIView alloc] initWithFrame:superView.frame];
    self.alertLoadingGifView.backgroundColor = kBgColor;
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    imageView.center = self.alertLoadingGifView.center;
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 5;
    NSString *resource = nil;
    if (isCoSave) {
        resource = @"ZYQHUDProgress.bundle/课程保存.gif";
    }else {
        resource = @"ZYQHUDProgress.bundle/空页面加载.gif";
    }
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:resource ofType:nil]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    imageView.animatedImage = animatedImage;
    [self.alertLoadingGifView addSubview:imageView];
    [superView addSubview:self.alertLoadingGifView];
}
+ (void)ZYQloadingGIFAlertIsCourseSave:(BOOL)isCoSave {
    [self ZYQloadingGIFAlertWithSuperView:[UIApplication sharedApplication].delegate.window isCourseSave:isCoSave];
}
#pragma mark - 断网视图
+ (UIView *)ZYQshowNetworkHintView:(UIView *)superView
                             image:(NSString *)image
                             title:(NSString *)title {
    return  [[ZYQProgressHUD ZYQsharedProgressHUD] ZYQshowNetworkHintView:superView image:image title:title clickRefresh:nil];
}
+ (UIView *)ZYQshowNetworkHintView:(UIView *)superView
                             image:(NSString *)image
                             title:(NSString *)title
                      clickRefresh:(void(^)(UIView *))refreshBlock {
    return  [[ZYQProgressHUD ZYQsharedProgressHUD] ZYQshowNetworkHintView:superView image:image title:title clickRefresh:refreshBlock];
}
- (UIView *)ZYQshowNetworkHintView:(UIView *)superView
                             image:(NSString *)image
                             title:(NSString *)title
                      clickRefresh:(void(^)(UIView *))refreshBlock{
    self.networkHintView = [[UIView alloc] initWithFrame:superView.frame];
    if (refreshBlock != nil) {
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshClick:)];
        self.refreshBlock = refreshBlock;
        [self.networkHintView addGestureRecognizer:tapG];
    }
    self.networkHintView.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, superView.frame.size.width * 0.5, superView.frame.size.width * 0.5)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.center =  _networkHintView.center;
    [self.networkHintView addSubview:contentView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((contentView.frame.size.width - 90)*0.5, contentView.frame.size.width*0.5 - 64 , 90, 64)];
    imageView.image = [UIImage imageNamed:image];
    [contentView addSubview:imageView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, contentView.frame.size.width*0.5 + 5, contentView.frame.size.width, contentView.frame.size.height - imageView.frame.size.height - imageView.frame.origin.y - 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    titleLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1.0f];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [contentView addSubview:titleLabel];
    [superView addSubview:_networkHintView];
    return self.networkHintView;
}
- (void)refreshClick:(UITapGestureRecognizer *)tapG {
    self.refreshBlock(tapG.view);
}
+ (void)ZYQremoveView {
    [[ZYQProgressHUD ZYQsharedProgressHUD] ZYQremoveView];
}
- (void)ZYQremoveView {
    [self.networkHintView removeFromSuperview];
    [self.showAnmiationView removeFromSuperview];
    [self.alertLoadingGifView removeFromSuperview];
}
+ (void)showShadowWithView:(UIView *)shadowView {
    shadowView.layer.shadowColor   =  [UIColor colorWithRed:77.0/255.0 green:143.0/255.0 blue:251.0/255.0 alpha:1].CGColor;
    shadowView.layer.shadowOffset  = CGSizeMake(5, 5);
    shadowView.layer.shadowOpacity = 0.19;
    shadowView.layer.shadowRadius  = 5;
}
@end
