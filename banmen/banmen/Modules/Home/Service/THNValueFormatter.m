//
//  THNValueFormatter.m
//  banmen
//
//  Created by dong on 2017/8/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNValueFormatter.h"

@implementation THNValueFormatter

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis{
    return [NSString stringWithFormat:@"%.0f万", value];
}

@end
