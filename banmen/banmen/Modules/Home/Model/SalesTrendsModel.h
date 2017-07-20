//
//  SalesTrendsModel.h
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SalesTrendsModelDelegate <NSObject>

-(void)getSalesTrendsModel:(NSArray *)modelAry;

@end

@interface SalesTrendsModel : NSObject

@property(nonatomic, copy) NSString *order_count;
@property(nonatomic, copy) NSString *sum_money;
@property(nonatomic, copy) NSString *time;
@property(nonatomic,weak) id <SalesTrendsModelDelegate> sDelegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_rows;
@property(nonatomic,strong) NSArray *modelAry;

-(void)getSalesTrendsModelItemList:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
