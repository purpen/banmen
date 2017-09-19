//
//  THNAssetItem.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface THNAssetItem : NSObject <NSCopying>

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithPHAsset:(PHAsset *)asset;
+ (instancetype)assetItemWithPHAsset:(PHAsset *)asset;

- (instancetype)initWithImageUrl:(NSString *)url;
+ (instancetype)assetItemWithImageUrl:(NSString *)url;

- (instancetype)initWithImage:(UIImage *)image;
+ (instancetype)assetItemWithImage:(UIImage *)image;

@end
