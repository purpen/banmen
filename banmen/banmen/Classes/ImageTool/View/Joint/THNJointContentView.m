//
//  THNJointImageView.m
//  banmen
//
//  Created by FLYang on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNJointContentView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import <Photos/Photos.h>
#import "THNAssetItem.h"

const NSInteger kJointImageViewTag = 4641;

@interface THNJointContentView () {
    CGFloat _lastImageHeight;
}

@end

@implementation THNJointContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        [self resetAllView];
        [self thn_setViewUI];
    }
    return self;
}

#pragma mark - 设置视图
- (void)thn_setViewUI {
    [self addSubview:self.firstView];
    [self addSubview:self.secondView];
    [self addSubview:self.thirdView];
    [self addSubview:self.fourthView];
    [self addSubview:self.fifthView];
    [self addSubview:self.sixthView];
    [self addSubview:self.sevenView];
    [self addSubview:self.eightView];
    [self addSubview:self.nineView];
}

- (void)resetAllView {
    [self styleSettingWithView:self.firstView];
    [self styleSettingWithView:self.secondView];
    [self styleSettingWithView:self.thirdView];
    [self styleSettingWithView:self.fourthView];
    [self styleSettingWithView:self.fifthView];
    [self styleSettingWithView:self.sixthView];
    [self styleSettingWithView:self.sevenView];
    [self styleSettingWithView:self.eightView];
    [self styleSettingWithView:self.nineView];
    
    [self thn_saveImageViewArray];
}

//  子视图的样式
- (void)styleSettingWithView:(THNJointChildView *)view {
    view.frame = CGRectZero;
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
    [view thn_setJointImageViewData:nil];
}

#pragma mark - 设置图片
- (void)thn_setImageViewData {
    if (self.photoAsset.count == 0) {
        return;
    }
    
    PHImageRequestOptions *requestOption = [[PHImageRequestOptions alloc] init];
    requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    _lastImageHeight = 0.0;
    
    __weak __typeof(self)weakSelf = self;
    for (NSInteger idx = 0; idx < self.photoAsset.count; ++ idx) {
        THNAssetItem *assetItem = [self.photoAsset objectAtIndex:idx];
        
        if (idx < self.photoAsset.count) {
            THNJointChildView *childView = (THNJointChildView *)[self.contentViewArray objectAtIndex:idx];
            
            if (assetItem.imageUrl != nil) {
                [weakSelf thn_setJointChildViewImage:childView image:assetItem.image];
            } else {
                [[PHImageManager defaultManager] requestImageForAsset:assetItem.asset
                                                           targetSize:CGSizeMake(assetItem.asset.pixelWidth, assetItem.asset.pixelHeight)
                                                          contentMode:PHImageContentModeAspectFill
                                                              options:requestOption
                                                        resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                            [weakSelf thn_setJointChildViewImage:childView image:result];
                                                        }];
            }
            
        }
    }
}

- (void)thn_setJointChildViewImage:(THNJointChildView *)childView image:(UIImage *)image {
    CGFloat scale = image.size.height / image.size.width;
    CGFloat width = self.frame.size.width;
    CGFloat height = width * scale;
    childView.frame = CGRectMake(0, _lastImageHeight, width, height);
    
    [childView thn_setJointImageViewData:image];
    
    _lastImageHeight += height;
    
    self.contentSize = CGSizeMake(self.frame.size.width, _lastImageHeight);
}

#pragma mark - init
- (void)thn_saveImageViewArray {
    if (self.contentViewArray.count) {
        return;
    }
    [self.contentViewArray addObject:self.firstView];
    [self.contentViewArray addObject:self.secondView];
    [self.contentViewArray addObject:self.thirdView];
    [self.contentViewArray addObject:self.fourthView];
    [self.contentViewArray addObject:self.fifthView];
    [self.contentViewArray addObject:self.sixthView];
    [self.contentViewArray addObject:self.sevenView];
    [self.contentViewArray addObject:self.eightView];
    [self.contentViewArray addObject:self.nineView];
}

- (THNJointChildView *)firstView {
    if (!_firstView) {
        _firstView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _firstView.tag = kJointImageViewTag;
    }
    return _firstView;
}

- (THNJointChildView *)secondView {
    if (!_secondView) {
        _secondView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _secondView.tag = kJointImageViewTag + 1;
    }
    return _secondView;
}

- (THNJointChildView *)thirdView {
    if (!_thirdView) {
        _thirdView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _thirdView.tag = kJointImageViewTag + 2;
    }
    return _thirdView;
}

- (THNJointChildView *)fourthView {
    if (!_fourthView) {
        _fourthView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _fourthView.tag = kJointImageViewTag + 3;
    }
    return _fourthView;
}

- (THNJointChildView *)fifthView {
    if (!_fifthView) {
        _fifthView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _fifthView.tag = kJointImageViewTag + 4;
    }
    return _fifthView;
}

- (THNJointChildView *)sixthView {
    if (!_sixthView) {
        _sixthView = [[THNJointChildView alloc] initWithFrame:(CGRectZero)];
        _sixthView.tag = kJointImageViewTag + 5;
    }
    return _sixthView;
}

- (THNJointChildView *)sevenView {
    if (!_sevenView) {
        _sevenView = [[THNJointChildView alloc] initWithFrame:CGRectZero];
        _sevenView.tag = kJointImageViewTag + 6;
    }
    return _sevenView;
}

- (THNJointChildView *)eightView {
    if (!_eightView) {
        _eightView = [[THNJointChildView alloc] initWithFrame:CGRectZero];
        _eightView.tag = kJointImageViewTag + 7;
    }
    return _eightView;
}

- (THNJointChildView *)nineView {
    if (!_nineView) {
        _nineView = [[THNJointChildView alloc] initWithFrame:CGRectZero];
        _nineView.tag = kJointImageViewTag + 8;
    }
    return _nineView;
}

- (NSMutableArray *)contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [NSMutableArray array];
    }
    return _contentViewArray;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
