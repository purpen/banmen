//
//  THNPuzzleCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPuzzleCollectionViewCell.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNPuzzleCollectionViewCell ()

@end

@implementation THNPuzzleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    }
    return self;
}

#pragma mark - #pragma mark - 加载拼图的预览图
- (void)thn_setPreviewWithPhotoAssetArray:(NSMutableArray *)assetArray styleTag:(NSInteger)styleTag {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    THNShowPuzzleView *puzzleView = [[THNShowPuzzleView alloc] initWithFrame:CGRectMake(0, 0, 150, 150) tag:styleTag];
    [puzzleView thn_setPuzzleViewStyleData:assetArray styleTag:styleTag];
    [self addSubview:puzzleView];
}

@end
