//
//  GoodDetailsView.h
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailModel.h"

@protocol GoodDetailsViewDelegate <NSObject>

-(void)uploadModel:(NSInteger)status;
-(void)editPictures;
-(void)chooseWhichClassification:(NSInteger)classification;

@end

@interface GoodDetailsView : UIView

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GoodsDetailModel *model;
@property(nonatomic,weak) id <GoodDetailsViewDelegate> delegate;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) NSArray *articleModelAry;
@property (nonatomic, strong) NSArray *pictureModelAry;
@property (nonatomic, strong) NSArray *videoModelAry;
@property (nonatomic, assign) NSInteger category;

@end

