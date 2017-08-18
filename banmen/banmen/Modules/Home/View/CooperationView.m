//
//  CooperationView.m
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "CooperationView.h"
#import "UIColor+Extension.h"
#import "CooperationCollectionViewCell.h"
#import "OtherMacro.h"
#import "GoodDetailsViewController.h"
#import "UIView+FSExtension.h"

@interface CooperationView () <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation CooperationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 10, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.height -= 160;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CooperationCollectionViewCell class] forCellWithReuseIdentifier:@"CooperationCollectionViewCell"];
    }
    return _collectionView;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CooperationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CooperationCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.modelAry[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailsViewController *vc = [[GoodDetailsViewController alloc] init];
    vc.model = self.modelAry[indexPath.row];
    [self.navC pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-15*3)/2, 347.0/2);
}

@end
