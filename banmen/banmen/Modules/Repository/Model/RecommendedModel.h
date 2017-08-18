//
//  RecommendedModel.h
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RecommendedModelDelegate <NSObject>

-(void)get:(NSMutableArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)getMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface RecommendedModel : NSObject

@property(nonatomic, copy) NSString *product_id;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *inventory;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *status;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;
@property(nonatomic,strong) NSMutableArray *modelAry;
@property(nonatomic,weak) id <RecommendedModelDelegate> rDelegate;

-(void)getRecommendedModelList;
-(void)getMoreRecommendedModelList:(NSInteger)currentPage;

@end
