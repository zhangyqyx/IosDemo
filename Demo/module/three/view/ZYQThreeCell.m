//
//  ZYQThreeCell.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQThreeCell.h"

@interface ZYQThreeCell()
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/** 简介 */
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;

@end

@implementation ZYQThreeCell
#define kMargin 5

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = kMargin;
}
-(void)setFrame:(CGRect)frame {
    frame.origin.x = kMargin;
    frame.size.height -= 2 *kMargin;
    frame.size.width -= kMargin;
    [super setFrame:frame];
}

-(void)setModel:(ZYQThreeModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    _briefLabel.text = model.introduction;
}



@end
