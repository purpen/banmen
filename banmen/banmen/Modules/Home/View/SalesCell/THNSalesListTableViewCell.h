//
//  THNSalesListTableViewCell.h
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNSalesListModel.h"

@interface THNSalesListTableViewCell : UITableViewCell

@property (strong,nonatomic)UIButton *dateSelectBtn;
@property (strong,nonatomic) NSArray *modelAry;
@property (strong,nonatomic) UITableView *tableView;

@end
