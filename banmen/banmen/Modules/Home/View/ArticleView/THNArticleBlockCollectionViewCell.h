//
//  THNArticleBlockCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/8/4.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNGoodsArticleModel.h"

@interface THNArticleBlockCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) THNGoodsArticleModel *goodsArticleModel;

@end
