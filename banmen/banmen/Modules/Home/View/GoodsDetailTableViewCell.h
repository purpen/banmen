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

@end
