//
//  THNListTableViewCell.h
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNSalesListModel.h"

@interface THNListTableViewCell : UITableViewCell

@property(nonatomic ,strong) UILabel *serialNumberLabel;
@property(nonatomic ,strong) UILabel *idLabel;
@property(nonatomic ,strong) UILabel *goodsNameLabel;
@property(nonatomic ,strong) UILabel *salesNumLabel;
@property(nonatomic ,strong) UILabel *salesLabel;
@property(nonatomic ,strong) UILabel *percentLabel;
@property(nonatomic ,strong) UIView *lineView;
@property(nonatomic ,strong) THNSalesListModel *model;

@end
