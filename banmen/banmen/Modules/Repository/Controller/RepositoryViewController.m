//
//  RepositoryViewController.m
//  banmen
//
//  Created by dong on 2017/6/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "RepositoryViewController.h"
#import "RepositoryView.h"
#import "RecommendedModel.h"
#import "MJRefresh.h"

@interface RepositoryViewController () <RecommendedModelDelegate>

@property(nonatomic, strong) RepositoryView *rView;
@property(nonatomic, strong) RecommendedModel *r;
@property(nonatomic, strong) NSMutableArray *modelAry;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_pages;

@end

@implementation RepositoryViewController

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.rView];
    self.rView.modelAry = self.r.modelAry;
    [self setupRefresh];
}

-(void)setupRefresh{
    self.rView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    // 自动改变透明度
    self.rView.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.rView.collectionView.mj_header beginRefreshing];
    self.rView.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.rView.collectionView.mj_footer.hidden = YES;
}

-(void)loadMore{
    [self.rView.collectionView.mj_header endRefreshing];
    self.r.rDelegate = self;
    [self.r getMoreRecommendedModelList:self.current_page];
}

-(void)getMore:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    [self.modelAry addObjectsFromArray:modelAry];
    [self.rView.collectionView reloadData];
    [self.rView.collectionView.mj_footer endRefreshing];
    self.current_page = current_page;
    self.total_pages = total_rows;
    [self checkFooterState];
}

-(RecommendedModel *)r{
    if (!_r) {
        _r = [RecommendedModel new];
    }
    return _r;
}

-(void)loadNew{
    [self.rView.collectionView.mj_footer endRefreshing];
    self.r.rDelegate = self;
    [self.r getRecommendedModelList];
}

-(void)get:(NSMutableArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.modelAry = modelAry;
    self.rView.modelAry = modelAry;
    [self.rView.collectionView reloadData];
    [self.rView.collectionView.mj_header endRefreshing];
    self.current_page = current_page;
    self.total_pages = total_rows;
    [self checkFooterState];
}

-(void)checkFooterState{
    self.rView.collectionView.mj_footer.hidden = self.modelAry.count == 0;
    if (self.current_page == self.total_pages) {
        self.rView.collectionView.mj_footer.hidden = YES;
    }else{
        [self.rView.collectionView.mj_footer endRefreshing];
    }
}

-(RepositoryView *)rView{
    if (!_rView) {
        _rView = [[RepositoryView alloc] initWithFrame:self.view.frame];
        _rView.nav = self.navigationController;
    }
    return _rView;
}

@end
