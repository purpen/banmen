//
//  MaterialTableViewCell.m
//  banmen
//
//  Created by dong on 2017/7/24.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "MaterialTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"
#import "THNGoodsWordCollectionViewCell.h"
#import "THNGoodsArticleCollectionViewCell.h"
#import "THNGoodsPictureCollectionViewCell.h"
#import "THNGoodsVideoCollectionViewCell.h"

@interface MaterialTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation MaterialTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.segmentedC];
        [_segmentedC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(13);
            make.width.mas_equalTo(144/2*4);
            make.height.mas_equalTo(58/2);
        }];
        
        [self.contentView addSubview:self.switchingArrangementBtn];
        [_switchingArrangementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.segmentedC.mas_bottom).mas_offset(11);
            make.width.mas_equalTo(52/2);
            make.height.mas_equalTo(52/2);
        }];
        
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.top.mas_equalTo(self.switchingArrangementBtn.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-30);
        }];
    }
    return self;
}

-(void)setModel:(THNGoodsWorld *)model{
    _model = model;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.collectionView reloadData];
}

-(void)setPictureModelAry:(NSArray *)pictureModelAry{
    _pictureModelAry = pictureModelAry;
    [self.collectionView reloadData];
}

-(void)setVideoModelAry:(NSArray *)videoModelAry{
    _videoModelAry = videoModelAry;
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[THNGoodsWordCollectionViewCell class] forCellWithReuseIdentifier:@"THNGoodsWordCollectionViewCell"];
        [_collectionView registerClass:[THNGoodsArticleCollectionViewCell class] forCellWithReuseIdentifier:@"THNGoodsArticleCollectionViewCell"];
        [_collectionView registerClass:[THNGoodsPictureCollectionViewCell class] forCellWithReuseIdentifier:@"THNGoodsPictureCollectionViewCell"];
        [_collectionView registerClass:[THNGoodsVideoCollectionViewCell class] forCellWithReuseIdentifier:@"THNGoodsVideoCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        THNGoodsWordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNGoodsWordCollectionViewCell" forIndexPath:indexPath];
        cell.sender_selected = self.switchingArrangementBtn.selected;
        cell.modelAry = self.modelAry;
        cell.controller = self.controller;
        return cell;
    } else if (indexPath.row == 1){
        THNGoodsArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNGoodsArticleCollectionViewCell" forIndexPath:indexPath];
        cell.modelAry = self.articleModelAry;
        cell.sender_selected = self.switchingArrangementBtn.selected;
        return cell;
    } else if (indexPath.row == 2) {
        THNGoodsPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNGoodsPictureCollectionViewCell" forIndexPath:indexPath];
        cell.modelAry = self.pictureModelAry;
        cell.sender_selected = self.switchingArrangementBtn.selected;
        return cell;
    } else {
        THNGoodsVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNGoodsVideoCollectionViewCell" forIndexPath:indexPath];
        cell.modelAry = self.videoModelAry;
        cell.sender_selected = self.switchingArrangementBtn.selected;
        cell.controller = self.controller;
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, self.collectionView.height);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(UIButton *)switchingArrangementBtn{
    if (!_switchingArrangementBtn) {
        _switchingArrangementBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_switchingArrangementBtn setImage:[UIImage imageNamed:@"landscape"] forState:(UIControlStateNormal)];
        [_switchingArrangementBtn setImage:[UIImage imageNamed:@"square"] forState:(UIControlStateSelected)];
    }
    return _switchingArrangementBtn;
}

-(UISegmentedControl *)segmentedC{
    if (!_segmentedC) {
        NSArray *items = @[@"文字素材",@"文章",@"图片",@"视频"];
        _segmentedC = [[UISegmentedControl alloc]initWithItems:items];
        _segmentedC.selectedSegmentIndex = 0;
        _segmentedC.tintColor = [UIColor colorWithHexString:@"#ff5a5f"];
    }
    return _segmentedC;
}

@end
