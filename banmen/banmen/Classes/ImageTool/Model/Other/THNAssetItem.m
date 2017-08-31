//
//  THNAssetItem.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNAssetItem.h"
#import "UIImageView+SDWedImage.h"
#import <SDWebImage/UIImage+MultiFormat.h>

@implementation THNAssetItem

#pragma mark -
- (instancetype)initWithPHAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        self.asset = asset;
        self.selected = NO;
    }
    return self;
}

+ (instancetype)assetItemWithPHAsset:(PHAsset *)asset {
    return [[self alloc] initWithPHAsset:asset];
}

#pragma mark -
- (instancetype)initWithImageUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.image = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
        self.imageUrl = url;
        self.selected = NO;
    }
    return self;
}

+ (instancetype)assetItemWithImageUrl:(NSString *)url {
    return [[self alloc] initWithImageUrl:url];
}

#pragma mark -
- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.image = image;
        self.selected = NO;
    }
    return self;
}

+ (instancetype)assetItemWithImage:(UIImage *)image {
    return [[self alloc] initWithImage:image];
}

#pragma mark -
- (id)copyWithZone:(NSZone *)zone {
    THNAssetItem *assetItem = [[[self class] allocWithZone:zone] init];
    assetItem.selected = self.selected;
    assetItem.asset = self.asset;
    assetItem.image = self.image;
    return assetItem;
}

@end
