//
//  THNAssetItem.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNAssetItem.h"

@implementation THNAssetItem

- (instancetype)initWithPHAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
        self.selected = NO;
    }
    return self;
}

+ (instancetype)AssetItemWithPHAsset:(PHAsset *)asset {
    return [[self alloc] initWithPHAsset:asset];
}

- (id)copyWithZone:(NSZone *)zone {
    THNAssetItem *assetItem = [[[self class] allocWithZone:zone] init];
    assetItem.selected = self.selected;
    assetItem.asset = self.asset;
    return assetItem;
}

@end
