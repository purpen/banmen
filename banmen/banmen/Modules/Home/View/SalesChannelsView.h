//
//  SalesChannelsView.h
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartsSwift.h"

@interface SalesChannelsView : UIView

@property (nonatomic, strong) PieChartView *pieChartView;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) UITableView *tableView;

@end
