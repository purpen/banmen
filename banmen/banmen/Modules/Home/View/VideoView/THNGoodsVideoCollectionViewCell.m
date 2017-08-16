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
#import "THNVideoCollectionViewCell.h"
 #import <MediaPlayer/MediaPlayer.h>
#import "THNVideoBlockCollectionViewCell.h"

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
        if (self.sender_selected) {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
        [_collectionView registerClass:[THNVideoBlockCollectionViewCell class] forCellWithReuseIdentifier:@"THNVideoBlockCollectionViewCell"];
        [_collectionView registerClass:[THNVideoCollectionViewCell class] forCellWithReuseIdentifier:@"THNVideoCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsVideoModel *model = self.modelAry[indexPath.row];
    if (self.sender_selected) {
        THNVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNVideoCollectionViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    THNVideoBlockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNVideoBlockCollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
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
    if (self.sender_selected) {
        return CGSizeMake(SCREEN_WIDTH, 142/2+27);
    }
    return CGSizeMake((SCREEN_WIDTH-45)/2+2.5, (SCREEN_WIDTH-45)/2);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsVideoModel *model = self.modelAry[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.video];
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self.controller presentViewController:vc animated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
