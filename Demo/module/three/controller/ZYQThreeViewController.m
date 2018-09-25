//
//  ZYQThreeViewController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/9/25.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQThreeViewController.h"
#import "ZYQThreeCell.h"
#import "ZYQThreeModel.h"

@interface ZYQThreeViewController ()<UICollectionViewDelegate , UICollectionViewDataSource>

/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;
/** 数据源 */
@property(nonatomic , strong)NSArray *dataSource;



@end

@implementation ZYQThreeViewController

#define kSpacing 10
#define kNumber 1
#define kThreeCell @"kThreeCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    
}
#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"三方封装";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = kSpacing;
    flowLayout.minimumInteritemSpacing = kSpacing;
    flowLayout.sectionInset = UIEdgeInsetsMake(kSpacing, kSpacing, kSpacing, kSpacing);
    CGFloat width = (self.view.frame.size.width - kSpacing * (kNumber +1)) /kNumber;
    flowLayout.itemSize = CGSizeMake(width, width * 0.4);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ZYQ_ScreenWidth, ZYQ_ScreenHeight - ZYQ_TopH) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = kViewLightBgColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    [collectionView registerNib:[UINib nibWithNibName:@"ZYQThreeCell" bundle:nil] forCellWithReuseIdentifier:kThreeCell];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
}
#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQThreeModel loadThreeData];
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kThreeCell forIndexPath:indexPath];
    ZYQThreeModel *model = self.dataSource[indexPath.row];
    cell.backgroundColor = kNavColor;
    cell.model = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQThreeModel *model = self.dataSource[indexPath.row];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
}



@end
