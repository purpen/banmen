//
//  THNPhotoTool.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface THNPhotoAlbumList : NSObject

/**
 相册名称
 */
@property (nonatomic, copy) NSString *title;

/**
 相册内照片数量
 */
@property (nonatomic, assign) NSInteger count;

/**
 相册的封面图
 */
@property (nonatomic, strong) PHAsset *coverPhoto;

/**
 相册下的照片集合
 */
@property (nonatomic, strong) PHAssetCollection *assetCOllection;

@end

@interface THNPhotoTool : NSObject

+ (instancetype)sharePhotoTool;

/**
 获取相册内所有照片

 @param ascending 是否按创建时间正序排列
 @return 图片资源
 */
- (NSArray<PHAsset *> *)thn_getPhotoOfAblumsWithAscending:(BOOL)ascending;

/**
 获取相册列表

 @return 相册列表
 */
- (NSArray<THNPhotoAlbumList *> *)thn_getPhotoAlbumList;

/**
 获取指定相册内的图片资源

 @param assetCollection 相册
 @param ascending 按时间正序排序
 @return 图片资源
 */
- (NSArray<PHAsset *> *)thn_getAssetOfAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

/**
 获取每个资源对应的照片信息
 
 @param asset 图片资源
 @param size 大小尺寸
 @param resizeMode 调整模式
 @param completion 获取完成相应处理
 */
- (void)thn_requesImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image, NSDictionary *info))completion;

@end
