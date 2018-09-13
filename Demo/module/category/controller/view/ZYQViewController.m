//
//  ZYQViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQViewController.h"
#import "ZYQarrow.h"
#import "UIView+ZYQSetSize.h"

@interface ZYQViewController ()
/** 当前视图 */
@property (weak, nonatomic) IBOutlet UIView *currentView;

@end

@implementation ZYQViewController

#define kSpacing 15

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视图frame操作";
}


#pragma mark - 按钮点击

- (IBAction)getValue:(UIButton *)sender {
    NSLog(@"tag值：%ld" ,sender.tag);
    switch (sender.tag) {
        case 201:
         [self addLabelWithFrame:CGRectMake(self.currentView.ZYQ_viewX - 60, self.currentView.ZYQ_viewY -10, 120, 21) title:[NSString stringWithFormat:@"{x , y}-%@" , NSStringFromCGPoint(self.currentView.ZYQ_viewOrign)]];
            break;
        case 202:
            [self addLabelWithFrame:CGRectMake(self.currentView.ZYQ_viewRight - 60, self.currentView.ZYQ_viewBottom -10, 120, 21) title:[NSString stringWithFormat:@"{w , h}-%@" , NSStringFromCGSize(self.currentView.ZYQ_viewSize)]];
            break;
        case 203:
            [self addViewWithArrow:CGRectMake(0, self.currentView.ZYQ_viewBottom - kSpacing, self.currentView.ZYQ_viewX, kSpacing) isCrosswise:true labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewX]];
            break;
        case 204:
            [self addViewWithArrow:CGRectMake(self.currentView.ZYQ_viewRight - kSpacing , 0, kSpacing, self.currentView.ZYQ_viewY) isCrosswise:false labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewY]];
            break;
        case 205:
            [self addViewWithArrow:CGRectMake(self.currentView.ZYQ_viewX , self.currentView.ZYQ_viewBottom - 2 * kSpacing, self.currentView.ZYQ_viewRight - self.currentView.ZYQ_viewX, kSpacing) isCrosswise:true labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewWidth]];
            break;
        case 206:
            [self addViewWithArrow:CGRectMake(self.currentView.ZYQ_viewRight - 2* kSpacing , self.currentView.ZYQ_viewY, kSpacing, self.currentView.ZYQ_viewBottom - self.currentView.ZYQ_viewY) isCrosswise:false labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewHeight]];
            break;
        case 207:
            [self addViewWithArrow:CGRectMake(0 , self.currentView.ZYQ_viewCenterY - 0.5 * kSpacing, self.currentView.ZYQ_viewCenterX, kSpacing) isCrosswise:true labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewCenterX]];
            break;
        case 208:
            [self addViewWithArrow:CGRectMake(self.currentView.ZYQ_viewCenterX - 0.5 * kSpacing , 0, kSpacing, self.currentView.ZYQ_viewCenterY) isCrosswise:false labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewCenterY]];
            break;
        case 209:
            [self addViewWithArrow:CGRectMake(0 , self.currentView.ZYQ_viewBottom - 3 * kSpacing, self.currentView.ZYQ_viewRight, kSpacing) isCrosswise:true labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewRight]];
            break;
        case 210:
            [self addViewWithArrow:CGRectMake(self.currentView.ZYQ_viewRight - 3* kSpacing , 0, kSpacing, self.currentView.ZYQ_viewBottom) isCrosswise:false labelText:[NSString stringWithFormat:@"%.0lf" , self.currentView.ZYQ_viewBottom]];
            break;
        default:
            break;
    }
    sender.enabled = false;
    
}

- (void)addViewWithArrow:(CGRect)frame  isCrosswise:(BOOL)isCrosswise  labelText:(NSString *)labelText{
    [UIView animateWithDuration:0.2 animations:^{
        ZYQarrow *view = [[ZYQarrow alloc] initWithFrame:frame];
        view.isCrosswise = isCrosswise;
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        UILabel *titleLabel = [[UILabel alloc] init];
        if (isCrosswise) {
            titleLabel.frame = CGRectMake(frame.origin.x + (frame.size.width-60) * 0.5 , frame.origin.y - 12, 60, 21);
        }else {
            titleLabel.frame = CGRectMake(frame.origin.x + 10, frame.origin.y + (frame.size.height-21) * 0.5 , 80, 21);
        }
        titleLabel.text = labelText;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor redColor];
        [self.view addSubview:titleLabel];
    }];
    
}
- (void)addLabelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor redColor];
    [self.view addSubview:titleLabel];
    [UIView animateWithDuration:0.2 animations:^{
       titleLabel.frame = frame;
    }];
    
}


@end
