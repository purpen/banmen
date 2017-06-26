//
//  THNPreviewPuzzleView.m
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPreviewPuzzleView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

#import "THNEditImageViewController.h"

static NSString *const PreviewItemCollectionCellId = @"previewItemCollectionCellId";

@interface THNPreviewPuzzleView ()

@property (nonatomic, strong) NSMutableArray<THNAssetItem *> *photoArray;

@end

@implementation THNPreviewPuzzleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:1];
        [self thn_setViewUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)thn_setViewUI {
    [self addSubview:self.previewCollection];
    [_previewCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self).with.offset(0);
    }];
}

#pragma mark - 绑定拼图数据
- (void)thn_setPreviewPuzzlePhotoData:(NSMutableArray<THNAssetItem *> *)photoData {
    self.photoArray = [NSMutableArray arrayWithArray:photoData];
    NSLog(@"=============  拼图图片： %@", self.photoArray);
    [self.previewCollection reloadData];
}

#pragma mark - 所有的相片列表
- (UICollectionView *)previewCollection {
    if (!_previewCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.minimumLineSpacing = 15;
        flowLayout.itemSize = CGSizeMake(150, 150);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _previewCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _previewCollection.backgroundColor = [UIColor colorWithHexString:kColorBackground];
        _previewCollection.delegate = self;
        _previewCollection.dataSource = self;
        _previewCollection.showsHorizontalScrollIndicator = NO;
        [_previewCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:PreviewItemCollectionCellId];
    }
    return _previewCollection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.photoArray.count) {
        case 1:
            return 3;
            break;
        case 2:
            return 6;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 7;
            break;
        case 5:
            return 8;
            break;
        case 6:
            return 10;
            break;
        case 7:
            return 1;
            break;
        case 8:
            return 5;
            break;
        case 9:
            return 4;
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PreviewItemCollectionCellId
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"=============  选中了第 %zi 个", indexPath.row);
    
    THNEditImageViewController *editImageController = [[THNEditImageViewController alloc] init];
    [self.supViewController pushViewController:editImageController animated:YES];
}

@end
