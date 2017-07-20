//
//  ChannelsItemTableViewCell.h
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesChannelsModel.h"

@interface ChannelsItemTableViewCell : UITableViewCell

@property (strong,nonatomic) UILabel *serialNumberLael;
@property (strong,nonatomic) UILabel *areaLael;
@property (strong,nonatomic) UILabel *salesLael;
@property (strong,nonatomic) UILabel *percentageLael;
@property (strong,nonatomic) SalesChannelsModel *model;
@property (strong,nonatomic) UIView *lineView;

@end
