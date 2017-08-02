//
//  THNOrderAreaModel.h
//  banmen
//
//  Created by dong on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THNOrderAreaModelDelegate <NSObject>

-(void)orderAreaModel:(NSArray *)modelAry;

@end

@interface THNOrderAreaModel : NSObject

@property(nonatomic, copy) NSString *order_count;
@property(nonatomic, copy) NSString *buyer_province_id;
@property(nonatomic, copy) NSString *buyer_province;
@property(nonatomic, copy) NSString *sum_money;
@property(nonatomic, copy) NSString *proportion;
@property(nonatomic,weak) id <THNOrderAreaModelDelegate> delegate;
@property(nonatomic,strong) NSArray *modelAry;

-(void)orderAreaModel:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
