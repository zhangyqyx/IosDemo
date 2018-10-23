//
//  ZYQFillViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFillViewController.h"
#import "MyimageView.h"
#import "ColorPickerView.h"
#import <Photos/Photos.h>

@interface ZYQFillViewController ()<UIScrollViewDelegate , ColorPickerViewDelegate>
@property (nonatomic, strong)UIButton *keepButton;//保存
@property (nonatomic, strong)UIButton *revokeButton;//撤销
@property (nonatomic,strong) MyimageView *myimageview;

/** 颜色选择view */
@property(nonatomic , strong) ColorPickerView   *colorView;
/** 选中的view */
@property(nonatomic , strong) UIView  *selectedView;
@property (nonatomic,strong)UIScrollView * scrollView;
/** 颜色 */
@property(nonatomic , strong) UIColor  *selectedColor;

@end

@implementation ZYQFillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self stUI];
}
-(void)stUI
{
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, screenW, screenW)];
    [self.view addSubview:_scrollView];
    self.myimageview = [[MyimageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenW)];
    [self.scrollView addSubview:self.myimageview];
    //设置内容大小
    _scrollView.contentSize = _myimageview.frame.size;
    //设置代理为控制器
    _scrollView.delegate = self;
    //设置最小缩放比例
    _scrollView.minimumZoomScale = 1;
    //设置最大缩放比例
    _scrollView.maximumZoomScale = 4;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    //设置手势点击数,双击：点2下
    tapGesture.numberOfTapsRequired=2;
    [_scrollView addGestureRecognizer:tapGesture];
    
    //设置一个图片的存储路径
    self.myimageview.image = [UIImage imageNamed:@"1.1.png"];
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    self.myimageview.newcolor = [UIColor redColor];
    
    
    self.colorView = [[ColorPickerView alloc] init];
    _colorView.pickedColorDelegate = self;
    _colorView.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 20 - 150, 100, 100);
    [self.view addSubview:self.colorView];
    self.selectedView = [[UIView alloc] init];
    self.selectedView.frame = CGRectMake(200, [UIScreen mainScreen].bounds.size.height - 100,  100, 20);
    [self.view  addSubview:self.selectedView];
    
    UIButton * changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"切换图片" forState:UIControlStateNormal];
    changeBtn.frame = CGRectMake(200, self.view.frame.size.height - 100, 100, 20);
    [changeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(changeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}
//放大缩小
-(void)handleTapGesture:(UIGestureRecognizer*)sender
{
    if(_scrollView.zoomScale > 1.0){
        [_scrollView setZoomScale:1.0 animated:YES];
    }else{
        [_scrollView setZoomScale:4.0 animated:YES];
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _myimageview;
}


- (void)setNav{
    
    self.navigationItem.title = @"图画的填充";
    //保存
    self.keepButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.keepButton.frame = CGRectMake(0, 0, 60, 24);
    [self.keepButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.keepButton setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.keepButton addTarget:self action:@selector(keepButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.keepButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.keepButton];
    //撤销
    self.revokeButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.revokeButton.frame = CGRectMake(100, 0, 60, 24);
    [self.revokeButton setImage:[UIImage imageNamed:@"撤销"] forState:UIControlStateNormal];
    [self.revokeButton addTarget:self action:@selector(revokeButtonBarButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.revokeButton setTitle:@"撤销" forState:UIControlStateNormal];
    [self.revokeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.revokeButton];

}
// 返回
- (void)shapeButtonBarButtonAction
{
    
}
// 保存到相册按钮
- (void)keepButtonBarButtonAction
{
    
    UIAlertController *ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存到相册" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.myimageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        //因为需要知道该操作的完成情况，即保存成功与否，所以此处需要一个回调方法image:didFinishSavingWithError:contextInfo:
        
        
    }];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [ale addAction:cancelAction];
    [ale addAction:cancelAction1];
    
    [self presentViewController:ale animated:YES completion:nil];
    
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 撤销 按钮
- (void)revokeButtonBarButtonAction{
    [self.myimageview revokeOption];
}
// 颜色的选择
- (void)pickedColor:(UIColor *)color {
    NSLog(@"color = %@" , color);
    self.myimageview.newcolor = color;
    self.selectedColor = color;
    self.selectedView.backgroundColor = color;
}
- (void)changeBtnClick {
    [self.myimageview removeFromSuperview];
    [_scrollView setZoomScale:1.0 animated:YES];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.myimageview = [[MyimageView alloc]initWithFrame:CGRectMake(0, 0, screenW, screenW)];
    [self.scrollView addSubview:self.myimageview];
    int a =   arc4random_uniform(5) + 1;
    NSString *imageName = [NSString stringWithFormat:@"%d.1.png" , a];
    UIImage *image = [UIImage imageNamed:imageName];
    self.myimageview.image = image;
    CGFloat sc =  (screenW/self.myimageview.image.size.width);
    self.myimageview.frame = CGRectMake(0, 0, screenW, self.myimageview.image.size.height * sc);
    self.myimageview.scaleNum = 1/sc;
    if (self.selectedColor == nil) {
        self.selectedColor = [UIColor redColor];
    }
    self.myimageview.newcolor = self.selectedColor;
    self.myimageview.revokePoints = [NSMutableArray array];
}


@end
