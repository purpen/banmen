//
//  THNGoodsPictureCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsPictureCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "THNwordCollectionViewCell.h"
#import "UIView+FSExtension.h"
#import "THNGoodsPictureModel.h"
#import "THNPictureCollectionViewCell.h"

@interface THNGoodsPictureCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation THNGoodsPictureCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView).mas_offset(0);
        }];
    }
    return self;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.collectionView reloadData];
}

-(void)setSender_selected:(BOOL)sender_selected{
    _sender_selected = sender_selected;
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (self.sender_selected) {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.minimumInteritemSpacing = 2;
//            layout.minimumLineSpacing = 1;
        } else {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.minimumInteritemSpacing = 1;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[THNPictureCollectionViewCell class] forCellWithReuseIdentifier:@"THNPictureCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsPictureModel *model = self.modelAry[indexPath.row];
    if (self.sender_selected) {
        THNPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNPictureCollectionViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(cell.contentView).mas_offset(0);
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sender_selected) {
        return CGSizeMake(SCREEN_WIDTH, 51);
    } else {
        return CGSizeMake((SCREEN_WIDTH-3)/4, (SCREEN_WIDTH-3)/4);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
