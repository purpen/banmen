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

@interface GoodDetailsViewController () <GoodsDetailModelDelegate, GoodDetailsViewDelegate>

@property(nonatomic, strong) GoodDetailsView *goodDetailsView;
@property(nonatomic, strong) GoodsDetailModel *goodsDetailModel;

@end

@implementation GoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodDetailsView.delegate = self;
    [self.view addSubview:self.goodDetailsView];
    [self setupRefresh];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
