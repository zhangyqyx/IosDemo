//
//  ZYQHomeController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/8/23.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQHomeController.h"
#import "ZYQHomeModel.h"
#import "ZYQHomeCollectionViewCell.h"

@interface ZYQHomeController()<UICollectionViewDelegate , UICollectionViewDataSource>

/** 数据源 */
@property(nonatomic , strong)NSArray *dataSource;

/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;


@end

@implementation ZYQHomeController

#define kSpacing 10
#define kNumber 2
#define kHomeCell @"kHomeCell"

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self setupUI];
    [self loadData];
}

#pragma mark - 设置UI
- (void)setupUI {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = kSpacing;
    flowLayout.minimumInteritemSpacing = kSpacing;
    flowLayout.sectionInset = UIEdgeInsetsMake(kSpacing, kSpacing, kSpacing, kSpacing);
    CGFloat width = (self.view.frame.size.width - kSpacing * (kNumber +1)) /kNumber;
    flowLayout.itemSize = CGSizeMake(width, width * 0.5);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ZYQHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:kHomeCell];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQHomeModel loadData];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor ZYQ_randomColor];
    ZYQHomeModel *model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQHomeModel *model = self.dataSource[indexPath.row];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
}




@end
