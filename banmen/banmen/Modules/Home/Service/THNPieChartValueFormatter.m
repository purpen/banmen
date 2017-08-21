//
//  THNPieChartValueFormatter.m
//  banmen
//
//  Created by dong on 2017/8/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPieChartValueFormatter.h"

@implementation THNPieChartValueFormatter

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (NSString * _Nonnull)stringForValue:(double)value entry:(ChartDataEntry * _Nonnull)entry dataSetIndex:(NSInteger)dataSetIndex viewPortHandler:(ChartViewPortHandler * _Nullable)viewPortHandler {
    return [NSString stringWithFormat:@"%.1f%%", value*100];
}

@end
