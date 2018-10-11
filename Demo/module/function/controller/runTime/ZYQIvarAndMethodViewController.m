//
//  ZYQIvarAndMethodViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQIvarAndMethodViewController.h"
#import "ZYQRuntimeManager.h"

@interface ZYQIvarAndMethodViewController ()
@property (weak, nonatomic) IBOutlet UITextField *className;
@property (weak, nonatomic) IBOutlet UITextView *showView;

@end

@implementation ZYQIvarAndMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    
}

- (IBAction)get:(id)sender {
    self.showView.text = @"";
    NSArray *list;
    if ([self.className.text isEqualToString:@""] || self.className.text.length == 0) {
        NSLog(@"输入不能为空");
        return;
    }
    if (self.type == 1) {
        list = [ZYQRuntimeManager ZYQ_getAllIvarWithClass:NSClassFromString(self.className.text)];
    }else if (self.type == 2) {
        list = [ZYQRuntimeManager ZYQ_getAllMethodWithClass:NSClassFromString(self.className.text)];
    }
    for (NSString *name in list) {
        self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"%@\n" , name]];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
