//
//  SalesChannelsModel.h
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SalesChannelsModelDelegate <NSObject>

-(void)updateSalesChannelsModel:(NSArray *)modelAry;

@end

@interface SalesChannelsModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *count;
@property(nonatomic, copy) NSString *proportion;
@property(nonatomic, strong) NSArray *modelAry;
@property(nonatomic,weak) id <SalesChannelsModelDelegate> sDelegate;

-(void)getSalesChannelsModelItem:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
