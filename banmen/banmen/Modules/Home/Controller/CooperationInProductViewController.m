//
//  CooperationInProductViewController.m
//  banmen
//
//  Created by dong on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "CooperationInProductViewController.h"
#import "CooperationView.h"
#import "MJRefresh.h"
#import "Cooperation.h"

@interface CooperationInProductViewController ()<CooperationDelegate>
@property(nonatomic, strong) CooperationView *cView;
@property (nonatomic, strong) Cooperation *c;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_rows;
@property(nonatomic,strong) NSMutableArray *modelAry;
@end

@implementation CooperationInProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cView = [[CooperationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.cView];
    self.cView.modelAry = self.c.modelAry;
    [self setupRefresh];
}

-(Cooperation *)c{
    if (!_c) {
        _c = [Cooperation new];
    }
    return _c;
}

-(void)setupRefresh{
    self.cView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    // 自动改变透明度
    self.cView.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.cView.collectionView.mj_header beginRefreshing];
    self.cView.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.cView.collectionView.mj_footer.hidden = YES;
}

-(void)loadMore{
    [self.cView.collectionView.mj_header endRefreshing];
    self.c.cDelegate = self;
    [self.c getMoreCooperationItemList:self.current_page];
}

-(void)getMoreCooperation:(NSArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    [self.modelAry addObjectsFromArray:modelAry];
    [self.cView.collectionView reloadData];
    [self.cView.collectionView.mj_footer endRefreshing];
    self.current_page = current_page;
    self.total_rows = total_rows;
    [self checkFooterState];
}

-(void)loadNew{
    [self.cView.collectionView.mj_footer endRefreshing];
    self.c.cDelegate = self;
    [self.c getCooperationItemList];
}

-(void)getCooperation:(NSMutableArray *)modelAry andC:(NSInteger)current_page andT:(NSInteger)total_rows{
    self.modelAry = modelAry;
    self.cView.modelAry = modelAry;
    [self.cView.collectionView reloadData];
    [self.cView.collectionView.mj_header endRefreshing];
    self.current_page = current_page;
    self.total_rows = total_rows;
    [self checkFooterState];
}

-(void)checkFooterState{
    self.cView.collectionView.mj_footer.hidden = self.modelAry.count == 0;
    if (self.modelAry.count == self.total_rows) {
        self.cView.collectionView.mj_footer.hidden = YES;
    }else{
        [self.cView.collectionView.mj_footer endRefreshing];
    }
}

@end
