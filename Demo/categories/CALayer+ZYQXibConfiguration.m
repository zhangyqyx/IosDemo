//
//  CALayer+ZYQXibConfiguration.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/11.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "CALayer+ZYQXibConfiguration.h"

@implementation CALayer (ZYQXibConfiguration)

-(void)setBorderUIColor:(UIColor*)color

{
    
    self.borderColor = color.CGColor;
    
}

-(UIColor*)borderUIColor{
    
    return [UIColor colorWithCGColor:self.borderColor];
    
}

@end
