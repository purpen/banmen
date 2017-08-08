//
//  THNSuccessfulOrderHoursAdayTableViewCell.h
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNHourOrderModel.h"
#import "ChartsSwift.h"

@interface THNSuccessfulOrderHoursAdayTableViewCell : UITableViewCell

@property (strong,nonatomic)UIButton *dateSelectBtn;
@property (strong,nonatomic) NSArray *modelAry;
@property (strong,nonatomic) NSArray *timeAry;
@property (strong,nonatomic) LineChartView *lineChartView;
@property (strong,nonatomic) UILabel *timeLabel;

@end
