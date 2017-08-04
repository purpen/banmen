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

@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *content;
@property(nonatomic, copy) NSString *product_number;
@property(nonatomic, copy) NSString *article_describe;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *cover_srcfile;
@property(nonatomic, copy) NSString *site_from;
@property(nonatomic, copy) NSString *article_time;
@property(nonatomic,weak) id <THNGoodsArticleModelDelegate> delegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

-(void)netGetArticle:(NSString*)productId;
-(void)netGetMoreArticle:(NSString*)productId andCurrent_page:(NSInteger)current_page;

@end
