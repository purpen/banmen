//
//  THNPhotoListView.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (nonatomic, strong) UIButton *openAlbum;

/**
 获取相册列表的数据

 @param albumArray 相册列表
 */
- (void)thn_getPhotoAlbumListData:(NSMutableArray *)albumArray;

/**
 获取全部的照片

 @param assetArray 图片资源
 */
- (void)thn_getPhotoAssetInAlbumData:(NSMutableArray *)assetArray;

@end
