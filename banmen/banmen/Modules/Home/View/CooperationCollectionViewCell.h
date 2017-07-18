//
//  CooperationCollectionViewCell.h
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cooperation.h"

@interface CooperationCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *goodImageView;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *goodLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *inventoryLabel;
@property(nonatomic, strong) Cooperation *model;

@end
