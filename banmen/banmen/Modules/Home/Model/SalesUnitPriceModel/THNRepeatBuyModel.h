//
//  THNRepeatBuyModel.h
//  banmen
//
//  Created by dong on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RepeatBuyModelDelegate <NSObject>

-(void)repeatBuyModel:(NSArray *)modelAry;

@end

@interface THNRepeatBuyModel : NSObject

@property(nonatomic, copy) NSString *range;
@property(nonatomic, copy) NSString *count;
@property(nonatomic, copy) NSString *proportion;
@property(nonatomic, strong) NSArray *modelAry;
@property(nonatomic,weak) id <RepeatBuyModelDelegate> delegate;

-(void)repeatBuyModel:(NSString*)startTime andEndTime:(NSString*)endTime;

@end
