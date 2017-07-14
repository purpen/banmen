//
//  THNPreviewPuzzleView.h
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNAssetItem.h"

@interface THNPreviewPuzzleView : UIView

@property (nonatomic, strong) UINavigationController *supViewController;

/**
 预览拼图样式视图
 */
@property (nonatomic, strong) UICollectionView *previewCollection;

/**
 绑定拼图所需图片数据

 @param photoData 图片数据
 */
- (void)thn_setPreviewPuzzlePhotoData:(NSMutableArray *)photoData;

@end


