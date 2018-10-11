//
//  ZYQArchiveViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQArchiveViewController.h"
#import "ZYQChangeModel.h"
#import "ZYQRuntimeManager.h"

@interface ZYQArchiveViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextView *showView;
/**filePath */
@property (nonatomic , strong)NSString *filePath;
@end

@implementation ZYQArchiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title   = self.titleName;
    //创建路径
    NSString *documentPath      = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject];
    NSString *filePath          = [documentPath stringByAppendingPathComponent:@"ZYQChangeModel.plist"];
    self.filePath               = filePath;
}

- (IBAction)archive:(id)sender {
    ZYQChangeModel *model        = [[ZYQChangeModel alloc] init];
    model.name                  = self.name.text;
    model.gender                = self.gender.text;
    model.age                   = self.age.text;
    
 

    
    BOOL result = [ZYQRuntimeManager ZYQ_archive:[model class] model:model filePath:self.filePath];
    if (result) {
        NSLog(@"归档成功:%@",self.filePath);
    }else{
        NSLog(@"归档失败");
    }
}
- (IBAction)unarchive:(id)sender {
    ZYQChangeModel *model  = [ZYQRuntimeManager ZYQ_unarchive:[ZYQChangeModel class] filePath:self.filePath];
    self.showView.text = [self.showView.text stringByAppendingString:[NSString stringWithFormat:@"\nname =%@\ngender = %@\nage = %@\n" , model.name , model.gender , model.age]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
