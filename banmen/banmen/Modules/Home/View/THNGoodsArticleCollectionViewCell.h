//
//  THNGoodsArticleCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNGoodsArticleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL sender_selected;

@end
