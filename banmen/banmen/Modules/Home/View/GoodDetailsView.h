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
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (nonatomic, strong) NSMutableArray *articleModelAry;
@property (nonatomic, strong) NSMutableArray *pictureModelAry;
@property (nonatomic, strong) NSMutableArray *videoModelAry;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) BOOL sender_selected;
@property (nonatomic, strong) UIViewController *controller;

@end

