//
//  THNEditImageViewController.h
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNImageToolViewController.h"
#import "THNPhotoTool.h"

@interface THNEditImageViewController : THNImageToolViewController

/**
 选中的拼图样式标识
 */
@property (nonatomic, assign) NSInteger styleTag;

/**
 选中的图片数组
 */
@property (nonatomic, strong) NSMutableArray *selectedAssetArray;

/**
 选中的相册
 */
@property (nonatomic, strong) THNPhotoAlbumList *photoAlbum;

@end
