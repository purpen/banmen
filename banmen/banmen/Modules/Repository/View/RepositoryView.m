//
//  RepositoryView.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "RepositoryView.h"
#import "OtherMacro.h"
#import "UIColor+Extension.h"
#import "CooperationCollectionViewCell.h"
#import "GoodDetailsViewController.h"

@interface RepositoryView () <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation RepositoryView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        
        [self addSubview:self.collectionView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGoods:) name:@"addGoods" object:nil];
    }
    return self;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(15, 15, 70, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
//        _collectionView.height -= 118/667.0*SCREEN_HEIGHT;
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
    cell.recommendedModel = self.modelAry[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodDetailsViewController *vc = [[GoodDetailsViewController alloc] init];
    vc.model = self.modelAry[indexPath.row];
    [self.nav pushViewController:vc animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-15*3)/2, (347.0/2+41.5)/667.0*SCREEN_HEIGHT);
}

-(void)addGoods:(NSNotification*)notification{
    NSDictionary *dict = notification.userInfo;
    NSString *idStr = dict[@"id"];
    NSString *status = dict[@"status"];
    for (int i = 0; i<self.modelAry.count; i++) {
        RecommendedModel *model = self.modelAry[i];
        if ([model.product_id isEqualToString:idStr]) {
            model.status = status;
            [_collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:i inSection:0]]];
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"addGoods" object:nil];
}

@end
