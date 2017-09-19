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
#import "THNGoodsArticleModel.h"
#import "THNGoodsPictureModel.h"
#import "THNGoodsVideoModel.h"

#import "THNLayoutViewController.h"
#import "THNImageToolNavigationController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface GoodDetailsViewController () <GoodsDetailModelDelegate, THNGoodsWorldDelegate, GoodDetailsViewDelegate, THNGoodsArticleModelDelegate, THNGoodsPictureModelDelegate, THNGoodsVideoModelDelegate>

@property(nonatomic, strong) GoodDetailsView *goodDetailsView;
@property(nonatomic, strong) GoodsDetailModel *goodsDetailModel;
@property(nonatomic, strong) THNGoodsWorld *goodsWorldModel;
@property(nonatomic, strong) THNGoodsArticleModel *goodsArticleModel;
@property(nonatomic, strong) THNGoodsPictureModel *goodsPictureModel;
@property(nonatomic, strong) THNGoodsVideoModel *goodsVideoModel;
@property(nonatomic,assign) NSInteger word_current_page;
@property(nonatomic,assign) NSInteger word_total_pages;
@property(nonatomic,assign) NSInteger article_current_page;
@property(nonatomic,assign) NSInteger article_total_pages;
@property(nonatomic,assign) NSInteger picture_current_page;
@property(nonatomic,assign) NSInteger picture_total_pages;
@property(nonatomic,assign) NSInteger video_current_page;
@property(nonatomic,assign) NSInteger video_total_pages;
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
    [self.goodsPictureModel thn_requestProductImageWithProductId:self.model.product_id count:10 completion:^(NSArray *imageUrlArray) {
        if (imageUrlArray.count == 0) {
            [SVProgressHUD showInfoWithStatus:@"暂无可用的图片素材"];
            return ;
        }
        
        THNLayoutViewController *imageLayoutController = [[THNLayoutViewController alloc] init];
        [imageLayoutController thn_loadProductImageUrlForLayout:imageUrlArray goodsTitle:self.model.name type:(THNLayoutViewControllerTypeNetwork)];
        THNImageToolNavigationController *imageToolNavController = [[THNImageToolNavigationController alloc] initWithRootViewController:imageLayoutController];
        [self presentViewController:imageToolNavController animated:YES completion:nil];
    }];
}

-(void)loadNew{
    [self.goodDetailsView.tableView.mj_footer endRefreshing];
    self.goodsDetailModel.delegate = self;
    [self.goodsDetailModel netGetGoodsDetailModel:self.model.product_id];
    self.goodsWorldModel.delegate = self;
    self.goodsArticleModel.delegate = self;
    self.goodsPictureModel.delegate = self;
    self.goodsVideoModel.delegate = self;
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
            [self.goodsArticleModel netGetArticle:self.model.product_id];
        }
            break;
        case 2:
            //图片
        {
            [self.goodsPictureModel netGetpicture:self.model.product_id];
        }
            break;
        case 3:
            //视频
        {
            [self.goodsVideoModel netGetVideo:self.model.product_id];
        }
            break;
            
        default:
            break;
    }
}

-(void)loadMore{
    [self.goodDetailsView.tableView.mj_header endRefreshing];
    switch (self.MClassification) {
        case 0:
            //文字素材
        {
            [self.goodsWorldModel netGetMoreGoodsWorld:self.model.product_id andCurrent_page:self.word_current_page];
        }
            break;
        case 1:
            //文章
        {
            [self.goodsArticleModel netGetMoreArticle:self.model.product_id andCurrent_page:self.article_current_page];
        }
            break;
        case 2:
            //图片
        {
            [self.goodsPictureModel netGetMoreGoodsPicture:self.model.product_id andCurrent_page:self.picture_current_page];
        }
            break;
        case 3:
            //视频
        {
            [self.goodsVideoModel netGetMoreGoodsVideo:self.model.product_id andCurrent_page:self.video_current_page];
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
                [self.goodsWorldModel netGetGoodsWorld:self.model.product_id];
            }
            break;
        case 1:
            //文章
        {
            [self.goodsArticleModel netGetArticle:self.model.product_id];
        }
            break;
        case 2:
            //图片
        {
            [self.goodsPictureModel netGetpicture:self.model.product_id];
        }
            break;
        case 3:
            //视频
        {
            [self.goodsVideoModel netGetVideo:self.model.product_id];
        }
            break;
            
        default:
            break;
    }
}

-(void)video:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.goodDetailsView.videoModelAry = [NSMutableArray arrayWithArray:modelAry];
    self.video_current_page = current_page;
    self.video_total_pages = total_rows;
    [self.goodDetailsView.tableView.mj_header endRefreshing];
    [self checkFooterState];
}

-(void)videoMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    [self.goodDetailsView.videoModelAry addObjectsFromArray:modelAry];
    [self.goodDetailsView.tableView reloadData];
    self.video_current_page = current_page;
    self.video_total_pages = total_rows;
    [self checkFooterState];
}

-(void)picture:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.goodDetailsView.pictureModelAry = [NSMutableArray arrayWithArray:modelAry];
    [self.goodDetailsView.tableView.mj_header endRefreshing];
    self.picture_current_page = current_page;
    self.picture_total_pages = total_rows;
    [self checkFooterState];
}

-(void)pictureMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    [self.goodDetailsView.pictureModelAry addObjectsFromArray:modelAry];
    [self.goodDetailsView.tableView reloadData];
    self.picture_current_page = current_page;
    self.picture_total_pages = total_rows;
    [self checkFooterState];
}

-(void)article:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.goodDetailsView.articleModelAry = [NSMutableArray arrayWithArray:modelAry];
    self.article_current_page = current_page;
    [self.goodDetailsView.tableView.mj_header endRefreshing];
    self.article_total_pages = total_rows;
    [self checkFooterState];
}

-(void)articleMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    [self.goodDetailsView.articleModelAry addObjectsFromArray:modelAry];
    [self.goodDetailsView.tableView reloadData];
    self.article_current_page = current_page;
    self.article_total_pages = total_rows;
    [self checkFooterState];
}

-(void)getGoodsWorld:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.word_current_page = current_page;
    self.word_total_pages = total_rows;
    [self.goodDetailsView.tableView.mj_header endRefreshing];
    self.goodsWorldModelAry = modelAry;
    self.goodDetailsView.modelAry = [NSMutableArray arrayWithArray:modelAry];
    [self checkFooterState];
}

-(void)getMoreGoodsWorld:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.word_current_page = current_page;
    self.word_total_pages = total_rows;
    self.goodsWorldModelAry = modelAry;
    [self.goodDetailsView.modelAry addObjectsFromArray:modelAry];
    [self.goodDetailsView.tableView reloadData];
    [self checkFooterState];
}

-(THNGoodsWorld *)goodsWorldModel{
    if (!_goodsWorldModel) {
        _goodsWorldModel = [THNGoodsWorld new];
    }
    return _goodsWorldModel;
}

-(THNGoodsArticleModel *)goodsArticleModel{
    if (!_goodsArticleModel) {
        _goodsArticleModel = [THNGoodsArticleModel new];
    }
    return _goodsArticleModel;
}

-(THNGoodsPictureModel *)goodsPictureModel{
    if (!_goodsPictureModel) {
        _goodsPictureModel = [THNGoodsPictureModel new];
    }
    return _goodsPictureModel;
}

-(THNGoodsVideoModel *)goodsVideoModel{
    if (!_goodsVideoModel) {
        _goodsVideoModel = [THNGoodsVideoModel new];
    }
    return _goodsVideoModel;
}

-(void)uploadModel:(NSInteger)status{
    self.goodsDetailModel.status = status;
}

-(void)getGoodsDetailModel:(id)model{
    self.goodsDetailModel = model;
    self.goodDetailsView.model = model;
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
        _goodDetailsView.controller = self;
    }
    return _goodDetailsView;
}

-(void)setModel:(Cooperation *)model{
    _model = model;
    self.navigationItem.title = model.name;
}

-(void)checkFooterState{
    switch (self.MClassification) {
        case 0:
            //文字素材
        {
            self.goodDetailsView.tableView.mj_footer.hidden = self.goodDetailsView.modelAry.count == 0;
            if (self.word_total_pages == self.word_current_page) {
                self.goodDetailsView.tableView.mj_footer.hidden = YES;
            }else{
                [self.goodDetailsView.tableView.mj_footer endRefreshing];
            }
        }
            break;
        case 1:
            //文章
        {
            self.goodDetailsView.tableView.mj_footer.hidden = self.goodDetailsView.articleModelAry.count == 0;
            if (self.article_total_pages == self.article_current_page) {
                self.goodDetailsView.tableView.mj_footer.hidden = YES;
            }else{
                [self.goodDetailsView.tableView.mj_footer endRefreshing];
            }
        }
            break;
        case 2:
            //图片
        {
            self.goodDetailsView.tableView.mj_footer.hidden = self.goodDetailsView.pictureModelAry.count == 0;
            if (self.picture_total_pages == self.picture_current_page) {
                self.goodDetailsView.tableView.mj_footer.hidden = YES;
            }else{
                [self.goodDetailsView.tableView.mj_footer endRefreshing];
            }
        }
            break;
        case 3:
            //视频
        {
            self.goodDetailsView.tableView.mj_footer.hidden = self.goodDetailsView.videoModelAry.count == 0;
            if (self.video_total_pages == self.video_current_page) {
                self.goodDetailsView.tableView.mj_footer.hidden = YES;
            }else{
                [self.goodDetailsView.tableView.mj_footer endRefreshing];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
