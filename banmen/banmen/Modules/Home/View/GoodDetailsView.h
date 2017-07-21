//
//  GoodDetailsView.h
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@interface GoodDetailsView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GoodsDetailModel *model;

@end

