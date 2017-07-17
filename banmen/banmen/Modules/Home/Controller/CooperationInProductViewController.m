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

@interface CooperationInProductViewController ()
@property(nonatomic, strong) CooperationView *cView;
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (nonatomic, strong) Cooperation *c;
@end

@implementation CooperationInProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cView = [[CooperationView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.cView];
    self.modelAry = [NSMutableArray array];
    self.cView.modelAry = self.modelAry;
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

-(void)loadView{
    [self.cView.collectionView.mj_footer endRefreshing];
    self.modelAry = [self.c getCooperationItemList];
    [self.cView.collectionView reloadData];
    [self.cView.collectionView.mj_header endRefreshing];
    [self checkFooterState];
}

-(void)checkFooterState{
    self.cView.collectionView.mj_footer.hidden = self.modelAry.count == 0;
    if (self.modelAry.count == self.c.total_rows) {
        self.cView.collectionView.mj_footer.hidden = YES;
    }else{
        [self.cView.collectionView.mj_footer endRefreshing];
    }
}

@end
