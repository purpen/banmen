//
//  THNGoodsArticleModel.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol THNGoodsArticleModelDelegate <NSObject>

-(void)article:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)articleMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface THNGoodsArticleModel : NSObject

@property(nonatomic, copy) NSString *goodsId;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *product_number;
@property(nonatomic, copy) NSString *describe;
@property(nonatomic,weak) id <THNGoodsArticleModelDelegate> delegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

-(void)netGetArticle:(NSString*)productId;

@end
