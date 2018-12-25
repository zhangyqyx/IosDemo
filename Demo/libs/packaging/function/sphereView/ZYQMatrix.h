//
//  ZYQMatrix.h
//  SphereTagDemo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/12/24.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#ifndef ZYQMatrix_h
#define ZYQMatrix_h
#import "ZYQPoint.h"

struct ZYQMatrix {
    NSInteger column;
    NSInteger row;
    CGFloat matrix[4][4];
};

typedef struct ZYQMatrix ZYQMatrix;

static ZYQMatrix ZYQMatrixMake(NSInteger column , NSInteger row){
    ZYQMatrix matrix;
    matrix.column = column;
    matrix.row = row;
    for(NSInteger i = 0; i < column; i++){
        for(NSInteger j = 0; j < row; j++){
            matrix.matrix[i][j] = 0;
        }
    }
    return matrix;
}
static ZYQMatrix ZYQMatrixMakeFromArray(NSInteger column, NSInteger row, CGFloat *data) {
    ZYQMatrix matrix = ZYQMatrixMake(column, row);
    for (int i = 0; i < column; i ++) {
        CGFloat *t = data + (i * row);
        for (int j = 0; j < row; j++) {
            matrix.matrix[i][j] = *(t + j);
        }
    }
    return matrix;
}
static ZYQMatrix ZYQMatrixMutiply(ZYQMatrix a, ZYQMatrix b) {
    ZYQMatrix result = ZYQMatrixMake(a.column, b.row);
    for(NSInteger i = 0; i < a.column; i ++){
        for(NSInteger j = 0; j < b.row; j ++){
            for(NSInteger k = 0; k < a.row; k++){
                result.matrix[i][j] += a.matrix[i][k] * b.matrix[k][j];
            }
        }
    }
    return result;
}
static ZYQPoint ZYQPointMakeRotation(ZYQPoint point, ZYQPoint direction, CGFloat angle) {
    if (angle == 0) {
        return point;
    }
    
    CGFloat temp2[1][4] = {point.x, point.y, point.z, 1};
    //    XLMatrix pointM = XLMatrixMakeFromArray(1, 4, *temp2);
    
    ZYQMatrix result = ZYQMatrixMakeFromArray(1, 4, *temp2);
    
    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1[4][4] = {{1, 0, 0, 0}, {0, cos1, sin1, 0}, {0, -sin1, cos1, 0}, {0, 0, 0, 1}};
        ZYQMatrix m1 = ZYQMatrixMakeFromArray(4, 4, *t1);
        result = ZYQMatrixMutiply(result, m1);
    }
    
    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2[4][4] = {{cos2, 0, -sin2, 0}, {0, 1, 0, 0}, {sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        ZYQMatrix m2 = ZYQMatrixMakeFromArray(4, 4, *t2);
        result = ZYQMatrixMutiply(result, m2);
    }
    
    CGFloat cos3 = cos(angle);
    CGFloat sin3 = sin(angle);
    CGFloat t3[4][4] = {{cos3, sin3, 0, 0}, {-sin3, cos3, 0, 0}, {0, 0, 1, 0}, {0, 0, 0, 1}};
    ZYQMatrix m3 = ZYQMatrixMakeFromArray(4, 4, *t3);
    result = ZYQMatrixMutiply(result, m3);
    
    if (direction.x * direction.x + direction.y * direction.y + direction.z * direction.z != 0) {
        CGFloat cos2 = sqrt(direction.y * direction.y + direction.z * direction.z) / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat sin2 = -direction.x / sqrt(direction.x * direction.x + direction.y * direction.y + direction.z * direction.z);
        CGFloat t2_[4][4] = {{cos2, 0, sin2, 0}, {0, 1, 0, 0}, {-sin2, 0, cos2, 0}, {0, 0, 0, 1}};
        ZYQMatrix m2_ = ZYQMatrixMakeFromArray(4, 4, *t2_);
        result = ZYQMatrixMutiply(result, m2_);
    }
    
    if (direction.z * direction.z + direction.y * direction.y != 0) {
        CGFloat cos1 = direction.z / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat sin1 = direction.y / sqrt(direction.z * direction.z + direction.y * direction.y);
        CGFloat t1_[4][4] = {{1, 0, 0, 0}, {0, cos1, -sin1, 0}, {0, sin1, cos1, 0}, {0, 0, 0, 1}};
        ZYQMatrix m1_ = ZYQMatrixMakeFromArray(4, 4, *t1_);
        result = ZYQMatrixMutiply(result, m1_);
    }
    
    ZYQPoint resultPoint = ZYQPointMake(result.matrix[0][0], result.matrix[0][1], result.matrix[0][2]);
    
    return resultPoint;
}



#endif /* ZYQMatrix_h */
