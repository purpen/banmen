//
//  THNHourOrderModel.h
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THNHourOrderModelDelegate <NSObject>

-(void)hourOrderModel:(NSArray *)modelAry;

@end

@interface THNHourOrderModel : NSObject

@property(nonatomic, copy) NSString *order_count;
@property(nonatomic, copy) NSString *sum_money;
@property(nonatomic, copy) NSString *time;
@property(nonatomic,weak) id <THNHourOrderModelDelegate> delegate;
@property(nonatomic,strong) NSArray *modelAry;

-(void)hourOrderModel:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
