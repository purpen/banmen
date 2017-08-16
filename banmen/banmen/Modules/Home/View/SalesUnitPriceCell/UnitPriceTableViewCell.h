//
//  UnitPriceTableViewCell.h
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartsSwift.h"

@interface UnitPriceTableViewCell : UITableViewCell

@property (strong,nonatomic) UIButton *dateSelectBtn;
@property (strong,nonatomic) NSArray *modelAry;
@property (strong,nonatomic) UILabel *timeLabel;
@property (strong,nonatomic) NSArray *timeAry;
@property (strong,nonatomic) LineChartView *lineChartView;

@end
