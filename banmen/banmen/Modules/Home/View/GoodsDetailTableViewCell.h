//
//  GoodsDetailTableViewCell.h
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@interface GoodsDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) GoodsDetailModel *model;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsNumLabel;
@property (nonatomic, strong) UILabel *categoryLabel;
@property (nonatomic, strong) UILabel *shortNameLabel;
@property (nonatomic, strong) UILabel *pleasedToLabel;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UILabel *skuLabel;
@property (nonatomic, strong) UIButton *relationshipBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *editPicturesMaterialBtn;

@end
