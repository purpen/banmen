//
//  RangePickerCell.h
//  banmen
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "FSCalendar.h"

@interface RangePickerCell : FSCalendarCell

// The start/end of the range
@property (weak, nonatomic) CALayer *selectionLayer;

// The middle of the range
@property (weak, nonatomic) CALayer *middleLayer;


@end
