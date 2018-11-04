//
//  TFTagView.h
//  TFSearch
//
//  Created by 张永强 on 2018/3/2.
//  Copyright © 2018年 zhangyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+TFSetSize.h"
#import "UIColor+TFColor.h"

@class TFTagView;

typedef NS_ENUM(NSInteger , TFTagViewType) {
    TFTagViewStyleDefault,
    TFTagViewStyleColor,
    TFTagViewStyleBorder,
    TFTagViewStyleRank,
    TFTagViewStyleRectang
};

@protocol TFTagViewDelegate <NSObject>

- (void)TFTagViewClick:(TFTagView *)tagView tagLabel:(UILabel *)tagLabel index:(NSInteger)index text:(NSString *)text;

@end



@interface TFTagView : UIView
/** 标签的高度 */
@property (nonatomic , assign)CGFloat tagHeight;
/** 标签的圆角大小 */
@property (nonatomic , assign)CGFloat tagRadius;
/** 标签的样式 */
@property (nonatomic , assign)TFTagViewType tagType;
/** 标签文字颜色 */
@property (nonatomic , strong)UIColor *tagTextColor;
/** 标签文字的背景颜色 */
@property (nonatomic , strong)UIColor *tagBgColor;
/** 标签文字字体  */
@property (nonatomic , strong)UIFont *tagTextFont;
/** 标签内容 */
@property (nonatomic , strong)NSArray *tagsArr;
/**  标签的间隔 */
@property (nonatomic , assign)CGFloat tagSpace;
/** TFTagViewStyleRank 模式下的标题的颜色 */
@property (nonatomic , strong)NSArray *tagsRankBackgroundColorHexStrings;
/** 模式下的有几列 */
@property (nonatomic , assign)int tagsRectangMaxCol;


/** 标签点击代理 */
@property (nonatomic , weak)id<TFTagViewDelegate> delegate;


/**
 增加标签
 */
- (void)TF_addAndLayoutTags;


@end
