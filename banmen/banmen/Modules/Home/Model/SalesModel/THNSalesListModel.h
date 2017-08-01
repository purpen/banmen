//
//  THNSalesListModel.h
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THNSalesListModelDelegate <NSObject>

-(void)salesListModel:(NSArray *)modelAry;

@end

@interface THNSalesListModel : NSObject

@property(nonatomic, copy) NSString *sku_number;
@property(nonatomic, copy) NSString *sku_name;
@property(nonatomic, copy) NSString *sales_quantity;
@property(nonatomic, copy) NSString *sum_money;
@property(nonatomic, copy) NSString *proportion;
@property(nonatomic,weak) id <THNSalesListModelDelegate> delegate;
@property(nonatomic,strong) NSArray *modelAry;

-(void)salesListModel:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
