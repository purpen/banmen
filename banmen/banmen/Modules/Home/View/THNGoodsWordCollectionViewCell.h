//
//  THNGoodsWordCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNGoodsWordCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, assign) BOOL sender_selected;
@property (nonatomic, strong) UIViewController *controller;

@end
