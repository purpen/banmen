//
//  THNPhotoItemCollectionViewCell.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNAssetItem.h"

@interface THNPhotoItemCollectionViewCell : UICollectionViewCell

/**
 照片
 */
@property (nonatomic, strong) UIImageView *photoImageView;

/**
 选中的对号图标
 */
@property (nonatomic, strong) UIImageView *doneIcon;

/**
 绑定图片资源的图像

 @param assetItem 图片资源
 */
- (void)thn_setPhotoAssetItemImageData:(THNAssetItem *)assetItem;

@end
