//
//  DateValueFormatter.h
//  banmen
//
//  Created by dong on 2017/7/31.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChartsSwift.h"

@interface DateValueFormatter : NSObject <IChartAxisValueFormatter>

@property (nonatomic, strong) NSArray *arr;

-(instancetype)initWithArr:(NSArray *)arr;
-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis;

@end
