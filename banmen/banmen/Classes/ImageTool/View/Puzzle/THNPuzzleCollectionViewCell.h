//
//  THNPuzzleCollectionViewCell.h
//  banmen
//
//  Created by FLYang on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNShowPuzzleView.h"

@interface THNPuzzleCollectionViewCell : UICollectionViewCell

/**
 设置展示不同拼图的样式视图
 */
- (void)thn_setPreviewWithPhotoAssetArray:(NSMutableArray *)assetArray styleTag:(NSInteger)styleTag;

@end
