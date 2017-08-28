//
//  THNGoodsArticleCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsArticleCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "THNwordCollectionViewCell.h"
#import "UIView+FSExtension.h"
#import "THNArticleDetailViewController.h"
#import "THNArticleListTableViewCell.h"
#import "THNArticleBlockCollectionViewCell.h"

@interface THNGoodsArticleCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation THNGoodsArticleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView).mas_offset(0);
        }];
    }
    return self;
}

-(void)setSender_selected:(BOOL)sender_selected{
    _sender_selected = sender_selected;
    [self.collectionView reloadData];
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (self.sender_selected) {
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
        } else {
            layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[THNArticleListTableViewCell class] forCellWithReuseIdentifier:@"THNArticleListTableViewCell"];
        [_collectionView registerClass:[THNArticleBlockCollectionViewCell class] forCellWithReuseIdentifier:@"THNArticleBlockCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sender_selected) {
        THNArticleBlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNArticleBlockCollectionViewCell" forIndexPath:indexPath];
        cell.goodsArticleModel = self.modelAry[indexPath.row];
        return cell;
    } else {
        THNArticleListTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNArticleListTableViewCell" forIndexPath:indexPath];
        cell.goodsArticleModel = self.modelAry[indexPath.row];
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sender_selected) {
        return CGSizeMake(SCREEN_WIDTH, (142/2+7)/667.0*SCREEN_HEIGHT);
    } else {
        return CGSizeMake((SCREEN_WIDTH-45)/2+2.5, 361/2);
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsArticleModel *model = self.modelAry[indexPath.row];
    THNArticleDetailViewController *vc = [[THNArticleDetailViewController alloc] init];
    vc.content = model.share;
    vc.model = model;
    [self.controller.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
