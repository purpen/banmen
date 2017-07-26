//
//  THNVideoCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNGoodsVideoModel.h"

@interface THNVideoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *discribeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) THNGoodsVideoModel *model;

@end
