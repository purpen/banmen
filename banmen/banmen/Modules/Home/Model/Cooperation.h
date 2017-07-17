//
//  Cooperation.h
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cooperation : NSObject

@property(nonatomic, copy) NSString *product_id;
@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *inventory;
@property(nonatomic, copy) NSString *image;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_rows;

-(NSMutableArray*)getCooperationItemList;

@end
