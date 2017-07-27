//
//  THNGoodsWordCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsWordCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "THNwordCollectionViewCell.h"
#import "UIView+FSExtension.h"
#import "THNWordDetailViewController.h"

@interface THNGoodsWordCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation THNGoodsWordCollectionViewCell

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
        } else {
            layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[THNwordCollectionViewCell class] forCellWithReuseIdentifier:@"THNwordCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THNwordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNwordCollectionViewCell" forIndexPath:indexPath];
    cell.goodsWordModel = self.modelAry[indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sender_selected) {
        return CGSizeMake((SCREEN_WIDTH-20), 112);
    } else {
        return CGSizeMake((SCREEN_WIDTH-45)/2, 361/2);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsWorld *model = self.modelAry[indexPath.row];
    THNWordDetailViewController *vc = [[THNWordDetailViewController alloc] init];
    vc.word = model.describe;
    [self.controller presentViewController:vc animated:YES completion:nil];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
