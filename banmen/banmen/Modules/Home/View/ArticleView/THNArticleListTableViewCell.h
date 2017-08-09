//
//  THNArticleListTableViewCell.h
//  banmen
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNGoodsArticleModel.h"

@interface THNArticleListTableViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) THNGoodsArticleModel *goodsArticleModel;

@end
