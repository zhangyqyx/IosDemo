//
//  ZYQFunctionCell.h
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQFunctionModel.h"

@interface ZYQFunctionCell : UITableViewCell
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 详情 */
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

/** 模型 */
@property(nonatomic , strong) ZYQFunctionModel *model;


@end
