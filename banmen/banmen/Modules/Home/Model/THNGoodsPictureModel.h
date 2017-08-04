//
//  THNGoodsPictureModel.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
