//
//  THNPreviewPuzzleView.m
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPreviewPuzzleView.h"
#import "MainMacro.h"
#import "StyleMacro.h"
#import "UIColor+Extension.h"

#import "THNEditImageViewController.h"
#import "THNPuzzleCollectionViewCell.h"

static NSString *const PreviewItemCollectionCellId = @"THNPuzzleCollectionViewCellId";

@interface THNPreviewPuzzleView () <
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property (nonatomic, strong) NSMutableArray *photoArray;
@property (nonatomic, strong) NSArray *firstStyleTagArray;
@property (nonatomic, strong) NSArray *secondStyleTagArray;
@property (nonatomic, strong) NSArray *thirdStyleTagArray;
@property (nonatomic, strong) NSArray *fourthStyleTagArray;
@property (nonatomic, strong) NSArray *fifthStyleTagArray;
@property (nonatomic, strong) NSArray *sixthStyleTagArray;
@property (nonatomic, strong) NSArray *sevenStyleTagArray;
@property (nonatomic, strong) NSArray *eightStyleTagArray;
@property (nonatomic, strong) NSArray *nineStyleTagArray;

@end

@implementation THNPreviewPuzzleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:1];
        [self thn_setViewUI];
        [self thn_initStyleTagArray];
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
- (void)thn_setPreviewPuzzlePhotoData:(NSMutableArray *)photoData {
    self.photoArray = [NSMutableArray arrayWithArray:photoData];
    [self.previewCollection reloadData];
}

#pragma mark - 拼图样式的标识数组
- (void)thn_initStyleTagArray {
    self.firstStyleTagArray = @[@(leftAndRightViewTag),
                                @(topAndDownViewTag),
                                @(threeVerticalViewTag),
                                @(threeHorizontalViewTag)];
    
    self.secondStyleTagArray = @[@(topAndDownViewTag),
                                 @(leftAndRightViewTag),
                                 @(fieldViewTag)];
    
    self.thirdStyleTagArray = @[@(threeTopViewTag),
                                @(threeVerticalViewTag),
                                @(threeLeftViewTag),
                                @(threeHorizontalViewTag),
                                @(threeRightViewTag),
                                @(threeDownViewTag)];
    
    self.fourthStyleTagArray = @[@(fieldViewTag),
                                 @(fourVerticalViewTag),
                                 @(fourTopViewTag),
                                 @(fourLeftViewTag),
                                 @(fourHorizontalViewTag),
                                 @(fourRightViewTag),
                                 @(fourDownViewTag)];
    
    self.fifthStyleTagArray = @[@(fiveTopTwoDownThreeViewTag),
                                @(fiveLeftThreeRightTwoViewTag),
                                @(fiveVerticalViewTag),
                                @(fiveLeftViewTag),
                                @(fiveDownViewTag),
                                @(fiveVerticalThreePartViewTag),
                                @(fiveHorizontalViewTag)];
    
    self.sixthStyleTagArray = @[@(sixTwoTimesThreeViewTag),
                                @(sixThreeTimesTwoViewTag),
                                @(sixTwoFourViewTag),
                                @(sixOneFiveViewTag),
                                @(sixOneThreeTwoViewTag),
                                @(sixLeftTopSurroundViewTag)];
    
    self.sevenStyleTagArray = @[@(sevenTopThreeDownFourViewTag)];
    
    self.eightStyleTagArray = @[@(eightTopFourDownFourViewTag)];
    
    self.nineStyleTagArray = @[@(nineBlockBoxViewTag)];
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
        [_previewCollection registerClass:[THNPuzzleCollectionViewCell class] forCellWithReuseIdentifier:PreviewItemCollectionCellId];
    }
    return _previewCollection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.photoArray.count) {
        case 1:
            return 4;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 6;
            break;
        case 4:
            return 7;
            break;
        case 5:
            return 7;
            break;
        case 6:
            return 6;
            break;
        case 7:
            return 1;
            break;
        case 8:
            return 1;
            break;
        case 9:
            return 1;
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THNPuzzleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PreviewItemCollectionCellId
                                                                                  forIndexPath:indexPath];
    
    if (self.photoArray.count) {
        switch (self.photoArray.count) {
            case 1:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.firstStyleTagArray[indexPath.row] integerValue]];
                break;
            case 2:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.secondStyleTagArray[indexPath.row] integerValue]];
                break;
            case 3:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.thirdStyleTagArray[indexPath.row] integerValue]];
                break;
            case 4:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.fourthStyleTagArray[indexPath.row] integerValue]];
                break;
            case 5:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.fifthStyleTagArray[indexPath.row] integerValue]];
                break;
            case 6:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.sixthStyleTagArray[indexPath.row] integerValue]];
                break;
            case 7:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.sevenStyleTagArray[indexPath.row] integerValue]];
                break;
            case 8:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.eightStyleTagArray[indexPath.row] integerValue]];
                break;
            case 9:
                [cell thn_setPreviewWithPhotoAssetArray:self.photoArray styleTag:[self.nineStyleTagArray[indexPath.row] integerValue]];
                break;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    THNEditImageViewController *editImageController = [[THNEditImageViewController alloc] init];
    editImageController.styleTag = [self thn_getSelectStyleTag:indexPath.row];
    editImageController.selectedAssetArray = self.photoArray;
    [self.supViewController pushViewController:editImageController animated:YES];
}

- (NSInteger)thn_getSelectStyleTag:(NSInteger)index {
    NSInteger styleTag = 0;
    switch (self.photoArray.count) {
        case 1:
            styleTag = [self.firstStyleTagArray[index] integerValue];
            break;
        case 2:
            styleTag = [self.secondStyleTagArray[index] integerValue];
            break;
        case 3:
            styleTag = [self.thirdStyleTagArray[index] integerValue];
            break;
        case 4:
            styleTag = [self.fourthStyleTagArray[index] integerValue];
            break;
        case 5:
            styleTag = [self.fifthStyleTagArray[index] integerValue];
            break;
        case 6:
            styleTag = [self.sixthStyleTagArray[index] integerValue];
            break;
        case 7:
            styleTag = [self.sevenStyleTagArray[index] integerValue];
            break;
        case 8:
            styleTag = [self.eightStyleTagArray[index] integerValue];
            break;
        case 9:
            styleTag = [self.nineStyleTagArray[index] integerValue];
            break;
    }
    return styleTag;
}

@end
