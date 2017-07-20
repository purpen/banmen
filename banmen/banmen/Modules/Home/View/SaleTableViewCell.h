//
//  SaleTableViewCell.h
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesTrendsModel.h"

@interface SaleTableViewCell : UITableViewCell
@property (strong,nonatomic)UIButton *dateSelectBtn;
@property (strong,nonatomic)NSArray *modelAry;
//@property (strong,nonatomic)PNLineChart *lineChart;
@end
