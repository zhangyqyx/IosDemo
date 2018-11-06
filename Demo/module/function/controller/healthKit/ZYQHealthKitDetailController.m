//
//  ZYQHealthKitDetailController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHealthKitDetailController.h"
#import "ZYQHealthManager.h"
#import "NSDate+HKDate.h"

@interface ZYQHealthKitDetailController ()
@property (weak, nonatomic) IBOutlet UITextView *dataShowTextView;
@property (weak, nonatomic) IBOutlet UITextField *whriteTextField;

/**授权类型 */
@property (nonatomic , assign)ZYQQuantityType  quantityType;

@end

@implementation ZYQHealthKitDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *title;
    if ([self.type isEqualToString:@"ZYQQuantityTypeStep"]) {
        title = @"步行";
        self.quantityType = ZYQQuantityTypeStep;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeWalking"]) {
        title = @"跑步 + 步行";
        self.quantityType = ZYQQuantityTypeWalking;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeCycling"]) {
        title = @"骑行";
        self.quantityType = ZYQQuantityTypeCycling;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeSwimming"]) {
        title = @"游泳";
        self.quantityType = ZYQQuantityTypeSwimming;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeHeight"]) {
        title = @"身高";
        self.quantityType = ZYQQuantityTypeHeight;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeBodyMass"]) {
        title = @"体重";
        self.quantityType = ZYQQuantityTypeBodyMass;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeActiveEnergyBurned"]) {
        title = @"活动能量";
        self.quantityType = ZYQQuantityTypeActiveEnergyBurned;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeBasalEnergyBurned"]) {
        title = @"膳食能量";
        self.quantityType = ZYQQuantityTypeBasalEnergyBurned;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeBloodGlucose"]) {
        title = @"血糖";
        self.quantityType = ZYQQuantityTypeBloodGlucose;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeBloodPressureSystolic"]) {
        title = @"收缩压";
        self.quantityType = ZYQQuantityTypeBloodPressureSystolic;
    }else if ([self.type isEqualToString:@"ZYQQuantityTypeBloodPressureDiastolic"]) {
        title = @"舒张压";
        self.quantityType = ZYQQuantityTypeBloodPressureDiastolic;
    }
    self.navigationItem.title = title;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//授权
- (IBAction)authorization:(id)sender {
    if ([ZYQHealthManager ZYQ_isHealthDataAvailable]) {
        [ZYQHealthManager ZYQ_authorizeHealthKitWithType:self.quantityType
                                                result:^(BOOL isAuthorizateSuccess, NSError *error) {
                                                    NSLog(@" success = %d,error =  %@" , isAuthorizateSuccess , error);
                                                }];
    }
}
//读取数据
- (IBAction)readData:(id)sender {
    self.dataShowTextView.text = @"";
    [ZYQHealthManager ZYQ_getDayHealthWithType:self.quantityType queryResultBlock:^(NSArray *queryResults) {
        for (NSDictionary *dic in queryResults) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataShowTextView.text = [self.dataShowTextView.text stringByAppendingFormat:@"startDate = %@,endDate = %@ ,count = %@\n",dic[@"startDate"],dic[@"endDate"],dic[@"stepCount"]];
            });
        }
        if (queryResults.count == 0 ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dataShowTextView.text = @"暂无数据";
            });
        }
    }];

    
}
//写入数据
- (IBAction)whriteData:(id)sender {
    NSDate *endDate         = [NSDate date];
    NSDate *startDate       = [NSDate HK_dateAfterDate:endDate hour:-3];
    CGFloat num =  [self.whriteTextField.text floatValue];
    if (num <= 0) return;
    //必须都加入收缩压和舒张压，健康数据才会有显示，但是提前最好判断一下数值范围
    [ZYQHealthManager ZYQ_saveHealthKitDataType:self.quantityType startDate:startDate endDate:endDate number:num success:^(BOOL isSuccess, NSError *error) {
         NSLog(@"%d" ,isSuccess);
    }];
}



@end
