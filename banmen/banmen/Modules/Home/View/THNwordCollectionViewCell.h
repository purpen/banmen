//
//  THNwordCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNGoodsWorld.h"
#import "THNGoodsArticleModel.h"

@interface THNwordCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) THNGoodsWorld *goodsWordModel;
@property (nonatomic, strong) THNGoodsArticleModel *goodsArticleModel;

@end
