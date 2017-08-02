//
//  UnitPriceModel.h
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnitPriceModelDelegate <NSObject>

-(void)updateUnitPriceModel:(NSArray *)modelAry;

@end

@interface UnitPriceModel : NSObject

@property(nonatomic, copy) NSString *range;
@property(nonatomic, copy) NSString *count;
@property(nonatomic, copy) NSString *proportion;
@property(nonatomic, strong) NSArray *modelAry;
@property(nonatomic,weak) id <UnitPriceModelDelegate> uDelegate;

-(void)NetGetUnitPriceModel:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
