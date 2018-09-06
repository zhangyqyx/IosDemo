//
//  ZYQHomeCollectionViewCell.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/5.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHomeCollectionViewCell.h"

@interface ZYQHomeCollectionViewCell()
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 简介 */
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;


@end


@implementation ZYQHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ZYQHomeModel *)model {
                        _model   = model;
    self.bgImageView.image       = [UIImage imageNamed:model.image];
    self.titleLabel.text         = model.title;
    self.introductionLabel.text  = model.introduction;
}



@end
