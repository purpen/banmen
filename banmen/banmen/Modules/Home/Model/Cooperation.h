//
//  Cooperation.h
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CooperationDelegate <NSObject>

-(void)getCooperation:(NSMutableArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)getMoreCooperation:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface Cooperation : NSObject

@property(nonatomic, copy) NSString *product_id;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *inventory;
@property(nonatomic, copy) NSString *image;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_rows;
@property(nonatomic,strong) NSMutableArray *modelAry;
@property(nonatomic,weak) id <CooperationDelegate> cDelegate;

-(void)getCooperationItemList;
-(void)getMoreCooperationItemList:(NSInteger)currentPage;

@end
