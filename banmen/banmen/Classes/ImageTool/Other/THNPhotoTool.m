//
//  THNPhotoTool.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPhotoTool.h"
#import "MainMacro.h"

@implementation THNPhotoAlbumList

@end


@implementation THNPhotoTool

static THNPhotoTool *_sharePhotoTool = nil;

+ (instancetype)sharePhotoTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharePhotoTool = [[self alloc] init];
    });
    return _sharePhotoTool;
}

#pragma mark - 获取所有的相片
- (NSArray<PHAsset *> *)thn_getPhotoOfAblumsWithAscending:(BOOL)ascending {
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];

    PHFetchResult *result = [PHAsset fetchAssetsWithMediaType:(PHAssetMediaTypeImage) options:option];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAsset *asset = (PHAsset *)obj;
        [assets addObject:asset];
    }];
    
    return assets;
}

#pragma mark - 获取所有的相册
- (NSArray<THNPhotoAlbumList *> *)thn_getPhotoAlbumList {
    NSMutableArray<THNPhotoAlbumList *> *photoAblumList = [NSMutableArray array];
    
    //  获取智能相册
    PHFetchResult *smartAblums = [PHAssetCollection fetchAssetCollectionsWithType:(PHAssetCollectionTypeSmartAlbum) subtype:(PHAssetCollectionSubtypeAlbumRegular) options:nil];
    [smartAblums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        //  过滤掉视频文件和删除文件
        if (collection.assetCollectionSubtype != PHAssetCollectionSubtypeSmartAlbumVideos && collection.assetCollectionSubtype < PHAssetCollectionSubtypeSmartAlbumDepthEffect) {
            NSArray<PHAsset *> *assets = [self thn_getAssetOfAssetCollection:collection ascending:NO];
            if (assets.count > 0) {
                THNPhotoAlbumList *ablumList = [[THNPhotoAlbumList alloc] init];
                ablumList.title = collection.localizedTitle;
                ablumList.count = assets.count;
                ablumList.coverPhoto = assets.firstObject;
                ablumList.assetCOllection = collection;
                [photoAblumList addObject:ablumList];
            }
        }
    }];
    
    //  获取用户创建的相册
    PHFetchResult *userAblums = [PHAssetCollection fetchAssetCollectionsWithType:(PHAssetCollectionTypeAlbum) subtype:(PHAssetCollectionSubtypeSmartAlbumUserLibrary) options:nil];
    [userAblums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray<PHAsset *> *assets = [self thn_getAssetOfAssetCollection:collection ascending:NO];
        if (assets.count > 0) {
            THNPhotoAlbumList *ablumList = [[THNPhotoAlbumList alloc] init];
            ablumList.title = collection.localizedTitle;
            ablumList.count = assets.count;
            ablumList.coverPhoto = assets.firstObject;
            ablumList.assetCOllection = collection;
            [photoAblumList addObject:ablumList];
        }
    }];

    return photoAblumList;
}

#pragma mark - 获取指定相册内的所有照片
- (NSArray<PHAsset *> *)thn_getAssetOfAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    NSMutableArray<PHAsset *> *ablumAssets = [NSMutableArray array];
    
    PHFetchResult *result = [self thn_fetchAssetsInAssetCollection:assetCollection ascending:ascending];
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((PHAsset *)obj).mediaType == PHAssetMediaTypeImage) {
            [ablumAssets addObject:obj];
        }
    }];
    
    return ablumAssets;
}

- (PHFetchResult *)thn_fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending {
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:ascending]];
    PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:option];
    return result;
}

#pragma mark - 获取每个资源对应的照片信息
- (void)thn_requesImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *, NSDictionary *))completion {
    //请求大图界面，当切换图片时，取消上一张图片的请求，对于iCloud端的图片，可以节省流量
    static PHImageRequestID requestID = -1;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (requestID >= 1 && size.width / width == scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    /**
     resizeMode：对请求的图像怎样缩放。有三种选择：None，默认加载方式；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
     deliveryMode：图像质量。有三种值：Opportunistic，在速度与质量中均衡；HighQualityFormat，不管花费多长时间，提供高质量图像；FastFormat，以最快速度提供好的质量。
     这个属性只有在 synchronous 为 true 时有效。
     */
    option.resizeMode = resizeMode;//控制照片尺寸
    //option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;//控制照片质量
    option.networkAccessAllowed = YES;
    
    /*
     info字典提供请求状态信息:
     PHImageResultIsInCloudKey：图像是否必须从iCloud请求
     PHImageResultIsDegradedKey：当前UIImage是否是低质量的，这个可以实现给用户先显示一个预览图
     PHImageResultRequestIDKey和PHImageCancelledKey：请求ID以及请求是否已经被取消
     PHImageErrorKey：如果没有图像，字典内的错误信息
     */
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable image, NSDictionary * _Nullable info) {
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey];
        //  不要该判断，即如果该图片在iCloud上时候，会先显示一张模糊的预览图，待加载完毕后会显示高清图
        // && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue]
        if (downloadFinined && completion) {
            completion(image, info);
        }
    }];
}

@end
