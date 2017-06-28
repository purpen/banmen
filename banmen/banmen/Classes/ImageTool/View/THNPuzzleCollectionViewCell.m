//
//  THNPuzzleCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPuzzleCollectionViewCell.h"
#import "MainMacro.h"
#import "StyleMacro.h"
#import "UIColor+Extension.h"

@interface THNPuzzleCollectionViewCell ()

@property (nonatomic, strong) NSArray *firstStyleTagArray;
@property (nonatomic, strong) NSArray *secondStyleTagArray;
@property (nonatomic, strong) NSArray *thirdStyleTagArray;
@property (nonatomic, strong) NSArray *fourthStyleTagArray;
@property (nonatomic, strong) NSArray *fifthStyleTagArray;
@property (nonatomic, strong) NSArray *sixthStyleTagArray;

@end

@implementation THNPuzzleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
        [self thn_initStyleTagArray];
    }
    return self;
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
}

#pragma mark - 根据图片数量设置拼图样式
- (void)thn_setPreviewWithPhotoAssetArray:(NSMutableArray *)assetArray index:(NSInteger)index {
    switch (assetArray.count) {
        case 1:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.firstStyleTagArray index:index];
            break;
        case 2:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.secondStyleTagArray index:index];
            break;
        case 3:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.thirdStyleTagArray index:index];
            break;
        case 4:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.fourthStyleTagArray index:index];
            break;
        case 5:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.fifthStyleTagArray index:index];
            break;
        case 6:
            [self thn_setPreviewAssetArray:assetArray withTagArray:self.sixthStyleTagArray index:index];
            break;
    }
}

#pragma mark - 加载拼图的预览图
- (void)thn_setPreviewAssetArray:(NSMutableArray *)assetArray withTagArray:(NSArray *)tagArray index:(NSInteger)index {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    THNShowPuzzleView *puzzleView = [[THNShowPuzzleView alloc] initWithFrame:CGRectMake(0, 0, 150, 150) tag:[tagArray[index] integerValue]];
    [puzzleView thn_setPuzzleViewStyleData:assetArray styleTag:[tagArray[index] integerValue]];
    [self addSubview:puzzleView];
}

@end
