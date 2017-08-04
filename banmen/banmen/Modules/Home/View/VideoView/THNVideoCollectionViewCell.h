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

@property (nonatomic, strong) UILabel *wordLabel;
@property (nonatomic, strong) UILabel *fromLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *creatAtLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) THNGoodsVideoModel *model;
@property (nonatomic, strong) UIImageView *sizeImageView;
@property (nonatomic, strong) UILabel *sizeLabel;
@property (nonatomic, strong) UIImageView *timeImageView;

@end
