//
//  DateValueFormatter.m
//  banmen
//
//  Created by dong on 2017/7/31.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "DateValueFormatter.h"

@implementation DateValueFormatter

-(id)initWithArr:(NSArray *)arr{
    self = [super init];
    if (self)
    {
        _arr = arr;
        
    }
    return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return _arr[(NSInteger)value];
}

@end
