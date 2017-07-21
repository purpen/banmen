//
//  GoodsDetailModel.h
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GoodsDetailModelDelegate <NSObject>

-(void)getGoodsDetailModel:(id)model;

@end

@interface GoodsDetailModel : NSObject

@property(nonatomic, copy) NSString *product_id;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *category;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *short_name;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *weight;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *inventory;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, strong) NSArray *skus;
@property(nonatomic,weak) id <GoodsDetailModelDelegate> delegate;

-(void)netGetGoodsDetailModel:(NSString*)product_id;

@end

