//
//  TFSearchViewController.m
//  TFSearch
//
//  Created by 张永强 on 2018/3/7.
//  Copyright © 2018年 zhangyq. All rights reserved.
//

#import "TFSearchViewController.h"
#import "TFTagView.h"

@interface TFSearchViewController ()<TFTagViewDelegate , UITextFieldDelegate>{
    /** 历史记录视图 */
   @private UITableView *_tableView;
}

/** 搜索输入框 */
@property (nonatomic , strong)UITextField *searchField;
/** 历史记录视图 */
@property (nonatomic , strong)TFTagView *historyTagView;
/** 热门搜索视图 */
@property (nonatomic , strong)TFTagView *hotTagView;
/** 历史记录视图 */
@property (nonatomic , strong)NSMutableArray *historyArr;
/** 热门搜索样式 */
@property (nonatomic , assign)TFTagViewType hotTagType;
/** 历史记录样式 */
@property (nonatomic , assign)TFTagViewType historyTagType;

@end

@implementation TFSearchViewController

#define kHotSearchTag 10001
#define kHistorySearchTag 10002
#define kTableViewTag  10003
#define kFilePathStr @"historyData"
#define kiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kiPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define kTopH            ((kiPhoneX == YES || kiPhoneXr==YES || kiPhoneXr==YES ||kiPhoneXs_Max==YES)?(64 + 24):(64))
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.historyTagType = TFTagViewStyleDefault;
    self.hotTagType = TFTagViewStyleDefault;
    [self readFilePathDatas];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setupTopSearchView];
    [self setupTbaleView];
    [self registTextFieldNotification];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self removeTextFieldNotification];
}

#pragma mark  通知
- (void)registTextFieldNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.searchField];
}
- (void)removeTextFieldNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.searchField];
}

- (void)textFieldDidChange:(NSNotification *)notif {
    UITextField  *textField = [notif object];
    if ([textField.text isEqualToString:@""] || textField == nil) {
        [textField endEditing:YES];
    }
    [self TF_searchStrDidChange:textField.text];
    
}

#pragma mark -  设置UI
- (void)setupTopSearchView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kTopH)];
    topView.backgroundColor = [UIColor colorWithRed:75/255.0  green:211/255.0  blue:198/255.0 alpha:1.0];
    [self.view addSubview:topView];
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     cancleBtn.frame = CGRectMake(topView.frame.size.width - 50, topView.frame.size.height - 24 - 8, 40 , 24);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleBtn addTarget:self action:@selector(cnacleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancleBtn];
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0,topView.frame.size.height - 1 , topView.frame.size.width, 1)];
    lineView.image = [UIImage imageNamed:@"TagView.bundle/cell-content-line"];
    [topView addSubview:lineView];
    UIView *searchVeiw = [[UIView alloc] initWithFrame:CGRectMake(15, topView.frame.size.height - 25 -8, cancleBtn.frame.origin.x - 30, 25)];
    searchVeiw.backgroundColor = [UIColor whiteColor];
    searchVeiw.layer.cornerRadius = 5;
    searchVeiw.clipsToBounds = YES;
    [topView addSubview:searchVeiw];
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 20, 20)];
    searchImageView.center = CGPointMake(searchImageView.center.x, searchVeiw.frame.size.height* 0.5);
    searchImageView.image = [UIImage imageNamed:@"TFSearchManager.bundle/search"];
    [searchVeiw addSubview:searchImageView];
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(searchImageView.frame.size.width + 5 + searchImageView.frame.origin.x, 0, searchVeiw.frame.size.width - searchImageView.frame.size.width - 10, searchVeiw.frame.size.height)];
    searchField.placeholder = @"搜索";
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.font = [UIFont systemFontOfSize:15];
    searchField.delegate = self;
    [searchVeiw addSubview:searchField];
    self.searchField = searchField;
}
- (void)setupTbaleView {
    _tableView                = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopH, self.view.frame.size.width, self.view.frame.size.height - kTopH) style:UITableViewStylePlain];
    _tableView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.separatorStyle    = UITableViewCellSeparatorStyleNone;
    _tableView.tag           = kTableViewTag;
    [self createHeaderView];
    [self createFooterView];
    [self.view addSubview:_tableView];

}
- (UIViewController *)viewController{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}



- (void)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 20, 30)];
    titleLabel.text = @"热门搜索";
    titleLabel.textColor = [UIColor TF_colorWithRed:113 green:113 blue:113 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:titleLabel];
    TFTagView *tagView = [[TFTagView alloc] initWithFrame:CGRectMake(20, titleLabel.TF_viewBottom + 10, headerView.TF_viewWidth - 40, 0)];
    tagView.backgroundColor = [UIColor clearColor];
    tagView.tagsArr = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    tagView.tagType = self.hotTagType;
    tagView.delegate = self;
    tagView.tag = kHotSearchTag;
    [tagView TF_addAndLayoutTags];
    self.hotTagView = tagView;
    [headerView addSubview:tagView];
    headerView.TF_viewHeight = CGRectGetMaxY(tagView.frame) + 5;
    _tableView.tableHeaderView = headerView;
    
}
- (void)createFooterView {
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(footView.frame.size.width - 60, 0, 40, 30);
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [clearBtn setTitleColor:[UIColor TF_colorWithRed:113 green:113 blue:113 alpha:1.0] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:clearBtn];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, clearBtn.frame.origin.x - 20, 30)];
    titleLabel.text = @"历史记录";
    titleLabel.textColor = [UIColor TF_colorWithRed:113 green:113 blue:113 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:13];
    [footView addSubview:titleLabel];
    TFTagView *tagView = [[TFTagView alloc] initWithFrame:CGRectMake(20, titleLabel.TF_viewBottom + 10, footView.TF_viewWidth - 40, 0)];
    tagView.backgroundColor = [UIColor clearColor];
    tagView.tagsArr = self.historyArr;
    tagView.tagType = self.historyTagType;
//    tagView.tagHeight = 30;
//    tagView.tagRadius = 15;
    tagView.delegate = self;
    tagView.tag = kHistorySearchTag;
    [tagView TF_addAndLayoutTags];
    [footView addSubview:tagView];
    footView.TF_viewHeight = CGRectGetMaxY(tagView.frame);
    self.historyTagView = tagView;
    _tableView.tableFooterView = footView;
    if (self.historyArr.count == 0) {
        _tableView.tableFooterView.hidden = YES;
    }
}

//取消
- (void)cnacleBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearBtnClick:(UIButton *)clearBtn {
    self.historyArr = [NSMutableArray array];
    [self writeFilePathDatas];
       _tableView.tableFooterView.hidden = YES;
//    for (UIView * view in self.view.subviews) {
//       if (view.tag == kTableViewTag) {
//           _tableView = (UITableView *)view;
//
//        }
//    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textField.text = %@" , textField.text);
    if ([self isEmptyWithStr:textField.text]) return YES;
    [textField endEditing:YES];
    [self addOrRemoveDataWith:textField.text];
    [self TF_startSearchWithTitle:textField.text];
    [self TF_searchStrDidChange:textField.text];
    return YES;
}
- (BOOL)isEmptyWithStr:(NSString *)str {
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

#pragma mark - TFTagViewDelegate
- (void)TFTagViewClick:(TFTagView *)tagView tagLabel:(UILabel *)tagLabel index:(NSInteger)index text:(NSString *)text {
    if (tagView.tag == kHotSearchTag) {
        //热门搜索
//        return;
    }
    [self addOrRemoveDataWith:text];
    self.searchField.text = text;
    [self TF_startSearchWithTitle:text];
    [self TF_searchStrDidChange:text];
    [self.searchField endEditing:YES];
    //历史记录
    NSLog(@" index = %ld text = %@" ,index, text);
}

- (void)addOrRemoveDataWith:(NSString *)dataStr {
    if (self.historyArr.count == 0) {
        [self.historyArr addObject:dataStr];
        self.historyTagView.tagsArr = self.historyArr;
        UIView * superView = self.historyTagView.superview;
        superView.TF_viewHeight = CGRectGetMaxY(self.historyTagView.frame);
        _tableView.tableFooterView.hidden = NO;
        [_tableView reloadData];
        [self writeFilePathDatas];
        return;
    }
    for (NSString *str in self.historyArr) {
        if ([str isEqualToString:dataStr]) {
            [self.historyArr removeObject:str];
            break;
        }
    }
    [self.historyArr insertObject:dataStr atIndex:0];
    self.historyTagView.tagsArr = self.historyArr;
    UIView * superView = self.historyTagView.superview;
    superView.TF_viewHeight = CGRectGetMaxY(self.historyTagView.frame);
    _tableView.tableFooterView.hidden = NO;
    [_tableView reloadData];
    [self writeFilePathDatas];
}

#pragma mark - UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchField endEditing:YES];
    
}

#pragma mark - 存储和取出
- (void)readFilePathDatas {
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent :kFilePathStr];
    self.historyArr = [NSMutableArray arrayWithArray:[NSArray  arrayWithContentsOfFile:str]];
}
- (void)writeFilePathDatas {
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:kFilePathStr];
    [self.historyArr writeToFile:str atomically:YES];
}

- (void)TF_startSearchWithTitle:(NSString *)searchText {
    
}
- (void)TF_searchStrDidChange:(NSString *)searchText {
    
}
#pragma mark - 设置属性
- (void)setHideHotSearch:(BOOL)hideHotSearch {
    _hideHotSearch = hideHotSearch;
    _tableView.tableHeaderView.hidden = hideHotSearch;
    if (hideHotSearch) {
       _tableView.tableHeaderView.TF_viewHeight = 0;
    }
}

- (void)setSearchInputFont:(UIFont *)searchInputFont {
    _searchInputFont = searchInputFont;
    self.searchField.font = searchInputFont;
}
- (void)setHotArr:(NSArray *)hotArr {
    _hotArr = hotArr;
    self.hotTagView.tagsArr = hotArr;
    UIView * superView = self.hotTagView.superview;
    superView.TF_viewHeight = CGRectGetMaxY(self.hotTagView.frame) + 5;
    [_tableView reloadData];
}

- (void)setHotType:(TFSearchHotStyle)hotType {
    _hotType = hotType;
    if (self.hotType == TFSearchHotStyleDefault) return;
    if (self.hotType == TFSearchHotStyleColorfulTag) {
        self.hotTagType = TFTagViewStyleColor;
         [self setupHotType];
        return;
    }
    if (self.hotType == TFSearchHotStyleBorderTag) {
         self.hotTagType = TFTagViewStyleBorder;
        [self setupHotType];
        return;
    }
    if (self.hotType == TFSearchHotStyleRoundTag) {
         self.hotTagType = TFTagViewStyleBorder;
        self.hotTagView.tagRadius = 15;
        [self setupHotType];
        return;
    }
    if (self.hotType == TFSearchHotStyleRankTag) {
        self.hotTagType = TFTagViewStyleRank;
        [self setupHotType];
        return;
    }
    if (self.hotType == TFSearchHotStyleRectangleTag) {
        self.hotTagType = TFTagViewStyleRectang;
        [self setupHotType];
        return;
    }
}
- (void)setupHotType {
    self.hotTagView.tagType = self.hotTagType;
    UIView * superView = self.hotTagView.superview;
    superView.TF_viewHeight = CGRectGetMaxY(self.hotTagView.frame) + 5;
    [_tableView reloadData];
}
- (void)setHistoryStyleType:(TFSearchHistoryStyle)historyStyleType {
    _historyStyleType = historyStyleType;
    if (self.historyStyleType ==  TFSearchHistoryStyleDefault) return;
    if (self.historyStyleType == TFSearchHistoryStyleBorderTag) {
        self.historyTagType = TFTagViewStyleBorder;
        [self setupHistoryType];
        return;
    }
    if (self.historyStyleType == TFSearchHistoryStyleRoundTag) {
        self.historyTagType = TFTagViewStyleBorder;
        self.hotTagView.tagRadius = 15;
        [self setupHistoryType];
        return;
    }
    if (self.historyStyleType == TFSearchHistoryStyleColorfulTag) {
        self.historyTagType = TFTagViewStyleColor;
        [self setupHistoryType];
        return;
    }

}
- (void)setupHistoryType {
    self.historyTagView.tagType = self.historyTagType;
    UIView * superView = self.historyTagView.superview;
    superView.TF_viewHeight = CGRectGetMaxY(self.hotTagView.frame);
    [_tableView reloadData];
}



@end
