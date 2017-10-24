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
#import "UIView+FSExtension.h"
#import "banmen-Swift.h"
#import "AFNetworkReachabilityManager.h"

@interface CooperationInProductViewController ()<CooperationDelegate>
@property(nonatomic, strong) CooperationView *cView;
@property (nonatomic, strong) Cooperation *c;
@property(nonatomic,assign) NSInteger current_page;
@property(nonatomic,assign) NSInteger total_rows;
@property(nonatomic,strong) NSMutableArray *modelAry;
@property(nonatomic, strong) THNNoCooperativeProductView *nView;
@property (nonatomic, strong) THNNoNetConnectionView *noConnectView;
@end

@implementation CooperationInProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cView = [[CooperationView alloc] initWithFrame:self.view.frame];
    self.cView.navC = self.navigationController;
    [self.view addSubview:self.cView];
    self.cView.modelAry = self.c.modelAry;
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"THNNoCooperativeProductView" owner:nil options:nil];
    self.nView = views[0];
    self.nView.frame = self.view.frame;
    [self.cView.collectionView addSubview:self.nView];
    
    NSArray *views2 = [[NSBundle mainBundle] loadNibNamed:@"THNNoNetConnectionView" owner:nil options:nil];
    self.noConnectView = views2[0];
    self.noConnectView.frame = self.view.frame;
    [self.view addSubview:self.noConnectView];
    
    [self setupRefresh];
    
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.noConnectView.hidden = YES;
                break;
            default:
                break;
        }
    }];
    
    [self.noConnectView.reFreshBtn addTarget:self action:@selector(checkNetConnect) forControlEvents:UIControlEventTouchUpInside];
}

-(void)checkNetConnect{
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.noConnectView.hidden = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.noConnectView.hidden = YES;
                break;
            default:
                break;
        }
    }];
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
    if (modelAry.count == 0) {
        self.nView.hidden = NO;
    } else {
        self.nView.hidden = YES;
    }
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
