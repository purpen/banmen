//
//  THNGoodsVideoModel.h
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THNGoodsVideoModelDelegate <NSObject>

-(void)video:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;
-(void)videoMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows;

@end

@interface THNGoodsVideoModel : NSObject

@property(nonatomic, copy) NSString *video;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *video_size;
@property(nonatomic, copy) NSString *video_image;
@property(nonatomic,weak) id <THNGoodsVideoModelDelegate> delegate;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

-(void)netGetVideo:(NSString*)productId;

@end
