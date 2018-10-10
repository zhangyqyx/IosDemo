//
//  ZYQFunctionCell.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/10.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQFunctionCell.h"

@implementation ZYQFunctionCell
#define kmargin 10

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = 10;
}
- (void)setFrame:(CGRect)frame {
    frame.origin.x = kmargin;
    frame.origin.y += kmargin ;
    frame.size.width -= 2*kmargin;
    frame.size.height -= kmargin;
    [super setFrame:frame];
}

-(void)setModel:(ZYQFunctionModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    _detailLabel.text = model.introduction;
    
    
}

@end
