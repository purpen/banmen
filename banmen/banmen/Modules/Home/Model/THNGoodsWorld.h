//
//  THNGoodsWorld.h
//  banmen
//
//  Created by dong on 2017/7/24.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THNGoodsWorldDelegate <NSObject>

-(void)getGoodsWorld:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)getMoreGoodsWorld:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface THNGoodsWorld : NSObject

@property(nonatomic, copy) NSString *goodsId;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *product_number;
@property(nonatomic, copy) NSString *describe;
@property(nonatomic,weak) id <THNGoodsWorldDelegate> delegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

-(void)netGetGoodsWorld:(NSString*)productId;

@end
