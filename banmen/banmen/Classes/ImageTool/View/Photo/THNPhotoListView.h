//
//  THNPhotoListView.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNOpenAlbumButton.h"
#import "THNPhotoTool.h"
#import "THNAssetItem.h"

@protocol THNPhotoListViewDelegate <NSObject>

@optional
- (void)thn_didSelectItemAtPhotoList:(THNAssetItem *)item;
- (void)thn_didDeselectItemAtPhotoList:(THNAssetItem *)item;
- (void)thn_didSelectItemAtPhotoListOfReplace:(THNAssetItem *)item;

@end

@interface THNPhotoListView : UIView <
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

/**
 相册列表
 */
@property (nonatomic, strong) UITableView *photoAlbumTable;

/**
 毛玻璃背景
 */
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;

/**
 相片列表
 */
@property (nonatomic, strong) UICollectionView *photoColleciton;

/**
 展开相册列表按钮
 */
@property (nonatomic, strong) THNOpenAlbumButton *openAlbum;

- (void)thn_setOpenAlbumButtonTitle:(NSString *)title;

/**
 获取相册列表的数据

 @param albumArray 相册列表
 */
- (void)thn_getPhotoAlbumListData:(NSMutableArray<THNPhotoAlbumList *> *)albumArray;

/**
 获取全部的照片

 @param assetArray 图片资源
 @param replace 如果是替换照片，相册列表只能单选
 */
- (void)thn_getPhotoAssetInAlbumData:(NSMutableArray<THNAssetItem *> *)assetArray isReplace:(BOOL)replace;

/**
 相册视图的代理
 */
@property (nonatomic, weak) id <THNPhotoListViewDelegate> delegate;

@end
