//
//  THNGoodsVideoCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsVideoCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "THNwordCollectionViewCell.h"
#import "UIView+FSExtension.h"
#import "THNGoodsVideoModel.h"
#import <AVFoundation/AVFoundation.h>

@interface THNGoodsVideoCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation THNGoodsVideoCollectionViewCell

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

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 0, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsVideoModel *model = self.modelAry[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(cell.contentView).mas_offset(0);
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.video_image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:10];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(cell.contentView).mas_offset(-5);
    }];
    
    NSInteger second = [self durationWithVideo:[NSURL URLWithString:model.video]];
    
    NSString *str;
    if (second > 60) {
        NSInteger minutes = second / 60;
        NSString *str2;
        if (minutes >= 10) {
            str2 = [NSString stringWithFormat:@"%ld",minutes];
        } else {
            str2 = [NSString stringWithFormat:@"0%ld",minutes];
        }
        NSInteger seconds = second - minutes * 60;
        if (seconds >= 10) {
            str = [NSString stringWithFormat:@"%@:%ld",str2 ,seconds];
        } else {
            str = [NSString stringWithFormat:@"%@:0%ld",str2 ,seconds];
        }
    } else {
        if (second >= 10) {
            str = [NSString stringWithFormat:@"00:%ld",second];
        } else {
            str = [NSString stringWithFormat:@"00:0%ld",second];
        }
    }
    label.text = str;
    return cell;
}

-(NSInteger)durationWithVideo:(NSURL*)videoUrl{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts];
    NSInteger second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-45)/2, (SCREEN_WIDTH-45)/2);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
