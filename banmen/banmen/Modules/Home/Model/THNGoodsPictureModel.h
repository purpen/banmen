//
//  THNGoodsPictureModel.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol THNGoodsPictureModelDelegate <NSObject>

-(void)picture:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)pictureMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface THNGoodsPictureModel : NSObject

@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *describe;
@property(nonatomic, copy) NSString *image_created;
@property(nonatomic, copy) NSString *image_size;
@property(nonatomic,weak) id <THNGoodsPictureModelDelegate> delegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

-(void)netGetpicture:(NSString*)productId;
-(void)netGetMoreGoodsPicture:(NSString*)productId andCurrent_page:(NSInteger)current_page;

/**
 获取商品中的的图片信息
 
 @param productId 商品id
 @param count 需要的图片数量
 @param completion 获取完成的回调
 */
- (void)thn_requestProductImageWithProductId:(NSString *)productId count:(NSInteger)count completion:(void (^)(NSArray *imageUrlArray))completion;

@end
