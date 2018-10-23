//
//  ZYQOtherController.m
//  Demo
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2018/10/22.
//  Copyright © 2018年 ༺ོ࿆强ོ࿆ ༻. All rights reserved.
//

#import "ZYQOtherController.h"
#import "ZYQOtherCollectionCell.h"
#import "ZYQOtherModel.h"
#import "FLAnimatedImage.h"

@interface ZYQOtherController ()<UICollectionViewDelegate , UICollectionViewDataSource>
/** collectionView */
@property(nonatomic , strong)UICollectionView *collectionView;
/** dataSource */
@property(nonatomic , strong)NSArray *dataSource;



@end

@implementation ZYQOtherController
#define kSpacing 10
#define kNumber 1
#define kOtherCell @"kOtherCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self loadData];
}

#pragma mark - 设置UI
- (void)createUI {
    self.navigationItem.title = @"其他";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = kSpacing * 2;
    flowLayout.minimumInteritemSpacing = kSpacing * 2;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, kSpacing, 0, kSpacing);
    CGFloat width = (self.view.frame.size.width - kSpacing * (kNumber +1)) /kNumber;
    flowLayout.itemSize = CGSizeMake(width, width * 1.5);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,ZYQ_ScreenWidth , ZYQ_ScreenHeight - ZYQ_TopH) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = kViewLightBgColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = true;
    collectionView.bounces = false;
    collectionView.showsVerticalScrollIndicator = false;
    collectionView.showsHorizontalScrollIndicator = false;
    [collectionView registerNib:[UINib nibWithNibName:@"ZYQOtherCollectionCell" bundle:nil] forCellWithReuseIdentifier:kOtherCell];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark - 加载数据
- (void)loadData {
    self.dataSource = [ZYQOtherModel loadData];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQOtherCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOtherCell forIndexPath:indexPath];
    ZYQOtherModel *model = self.dataSource[indexPath.row];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, ZYQ_ScreenWidth - kSpacing * 2, (ZYQ_ScreenWidth - kSpacing * 2 )* 1.5- 25) ];
      if (![model.imageStr isEqualToString:@""]) {
     NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:model.imageStr ofType:nil]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        imageView.animatedImage = animatedImage;
        [cell addSubview:imageView];
    }
    
    cell.titleLabel.text = model.title;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYQOtherModel *model = self.dataSource[indexPath.row];
    Class class = NSClassFromString(model.nextVc);
    UIViewController *nextVc = [[class alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
}


@end
