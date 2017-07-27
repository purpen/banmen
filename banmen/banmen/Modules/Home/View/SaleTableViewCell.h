//
//  SaleTableViewCell.h
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesTrendsModel.h"
#import "ChartsSwift.h"

@interface SaleTableViewCell : UITableViewCell <ChartViewDelegate>

@property (strong,nonatomic)UIButton *dateSelectBtn;
@property (strong,nonatomic)NSArray *modelAry;
@property (strong,nonatomic) LineChartView *lineChartView;
@property (strong,nonatomic) UILabel *timeLabel;

@end
