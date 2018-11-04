//
//  TFSearchViewController.h
//  TFSearch
//
//  Created by 张永强 on 2018/3/7.
//  Copyright © 2018年 zhangyq. All rights reserved.
//

#import <UIKit/UIKit.h>



//热门风格
typedef NS_ENUM(NSInteger, TFSearchHotStyle)  {
    TFSearchHotStyleDefault,        // 默认
    TFSearchHotStyleColorfulTag,    // 带颜色
    TFSearchHotStyleBorderTag,      //带边框
    TFSearchHotStyleRoundTag,       // 圆角
    TFSearchHotStyleRankTag,        // 排名
    TFSearchHotStyleRectangleTag,   //网格
};
//历史记录风格
typedef NS_ENUM(NSInteger, TFSearchHistoryStyle) {
    TFSearchHistoryStyleDefault,            //默认
    TFSearchHistoryStyleColorfulTag,       //带颜色
    TFSearchHistoryStyleBorderTag,         //带边框
    TFSearchHistoryStyleRoundTag,         // 圆角
};


@interface TFSearchViewController : UIViewController

/** 是否隐藏热门搜索 */
@property (nonatomic , assign)BOOL hideHotSearch;
/** 设置搜索字体 */
@property (nonatomic , strong)UIFont *searchInputFont;
/** 设置热门搜索的数组 */
@property (nonatomic , strong)NSArray *hotArr;
/** 热门样式 */
@property (nonatomic , assign)TFSearchHotStyle hotType;
/** 历史记录样式 */
@property (nonatomic , assign)TFSearchHistoryStyle historyStyleType;
/**
 开始搜索

 @param searchText 要搜索的字符串
 */
- (void)TF_startSearchWithTitle:(NSString *)searchText;

/**
 搜索框发生变化

 @param searchText 要搜索的字符串
 */
- (void)TF_searchStrDidChange:(NSString *)searchText;
@end
