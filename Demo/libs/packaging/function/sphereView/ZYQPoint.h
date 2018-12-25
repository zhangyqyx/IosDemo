//
//  ZYQPoint.h
//  SphereTagDemo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#ifndef ZYQPoint_h
#define ZYQPoint_h

struct ZYQPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

typedef struct ZYQPoint ZYQPoint;

ZYQPoint ZYQPointMake(CGFloat x , CGFloat y , CGFloat z) {
    ZYQPoint point;
    point.x = x;
    point.y = y;
    point.z = z;
    return point;
}



#endif /* ZYQPoint_h */
