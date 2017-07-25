//
//  GoodDetailsViewController.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodDetailsViewController.h"
#import "GoodDetailsView.h"
#import "GoodsDetailModel.h"
#import "MJRefresh.h"
#import "THNGoodsWorld.h"

@interface GoodDetailsViewController () <GoodsDetailModelDelegate, THNGoodsWorldDelegate, GoodDetailsViewDelegate>

@property(nonatomic, strong) GoodDetailsView *goodDetailsView;
@property(nonatomic, strong) GoodsDetailModel *goodsDetailModel;
@property(nonatomic, strong) THNGoodsWorld *goodsWorldModel;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;
@property(nonatomic, strong) NSArray *goodsWorldModelAry;
@property(nonatomic,assign) NSInteger MClassification;

@end

@implementation GoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodDetailsView.delegate = self;
    [self.view addSubview:self.goodDetailsView];
    [self setupRefresh];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.MClassification = 0;
}

-(void)setupRefresh{
    self.goodDetailsView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    // 自动改变透明度
    self.goodDetailsView.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.goodDetailsView.tableView.mj_header beginRefreshing];
    self.goodDetailsView.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.goodDetailsView.tableView.mj_footer.hidden = YES;
}

-(void)editPictures{
    NSLog(@"图片编辑");
}

-(void)loadNew{
    [self.goodDetailsView.tableView.mj_footer endRefreshing];
    self.goodsDetailModel.delegate = self;
    [self.goodsDetailModel netGetGoodsDetailModel:self.model.product_id];
    self.goodsWorldModel.delegate = self;
    switch (self.MClassification) {
        case 0:
            //文字素材
        {
            [self.goodsWorldModel netGetGoodsWorld:self.model.product_id];
        }
            break;
        case 1:
            //文章
        {
            
        }
            break;
        case 3:
            //图片
        {
            
        }
            break;
        case 4:
            //视频
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)chooseWhichClassification:(NSInteger)classification{
    self.MClassification = classification;
    switch (classification) {
        case 0:
            //文字素材
            {
                
            }
            break;
        case 1:
            //文章
        {
            
        }
            break;
        case 3:
            //图片
        {
            
        }
            break;
        case 4:
            //视频
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(void)getGoodsWorld:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.current_page = current_page;
    self.total_pages = total_rows;
    self.goodsWorldModelAry = modelAry;
    self.goodDetailsView.modelAry = modelAry;
    self.goodDetailsView.tableView.mj_header.hidden = YES;
}

-(THNGoodsWorld *)goodsWorldModel{
    if (!_goodsWorldModel) {
        _goodsWorldModel = [THNGoodsWorld new];
    }
    return _goodsWorldModel;
}

-(void)uploadModel:(NSInteger)status{
    self.goodsDetailModel.status = status;
}

-(void)getGoodsDetailModel:(id)model{
    self.goodsDetailModel = model;
    self.goodDetailsView.model = model;
    self.goodDetailsView.tableView.mj_header.hidden = YES;
//    [self checkFooterState];
}

-(GoodsDetailModel *)goodsDetailModel{
    if (!_goodsDetailModel) {
        _goodsDetailModel = [GoodsDetailModel new];
    }
    return _goodsDetailModel;
}

-(GoodDetailsView *)goodDetailsView{
    if (!_goodDetailsView) {
        _goodDetailsView = [[GoodDetailsView alloc] initWithFrame:self.view.frame];
    }
    return _goodDetailsView;
}

-(void)setModel:(Cooperation *)model{
    _model = model;
    self.navigationItem.title = model.name;
}

//-(void)checkFooterState{
////    self.goodDetailsView.tableView.mj_footer.hidden = self.modelAry.count == 0;
//    if (self.modelAry.count == self.total_rows) {
//        self.cView.collectionView.mj_footer.hidden = YES;
//    }else{
//        [self.cView.collectionView.mj_footer endRefreshing];
//    }
//}

@end
