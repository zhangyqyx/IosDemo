//
//  ZYQDictChangeModelViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQDictChangeModelViewController.h"
#import "ZYQChangeModel.h"
#import "ZYQRuntimeManager.h"

@interface ZYQDictChangeModelViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextView *showView;

@end

@implementation ZYQDictChangeModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
}

- (IBAction)change:(id)sender {
    NSDictionary *dic = @{@"name":self.name.text ,
                          @"gender":self.gender.text,
                          @"age":self.age.text};
    ZYQChangeModel *model = [ZYQRuntimeManager ZYQ_modelWithDict:dic model:[ZYQChangeModel class]];
    self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\nname =%@\ngender = %@\nage = %@\n" , model.name , model.gender , model.age]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


@end
