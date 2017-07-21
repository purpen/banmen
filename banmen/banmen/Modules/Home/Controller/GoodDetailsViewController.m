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

@interface GoodDetailsViewController () <GoodsDetailModelDelegate>

@property(nonatomic, strong) GoodDetailsView *goodDetailsView;
@property(nonatomic, strong) GoodsDetailModel *goodsDetailModel;

@end

@implementation GoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.goodDetailsView];
    self.goodsDetailModel.delegate = self;
    [self.goodsDetailModel netGetGoodsDetailModel:self.model.product_id];
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
    }
    return _goodDetailsView;
}

-(void)setModel:(Cooperation *)model{
    _model = model;
    self.navigationItem.title = model.name;
}

@end
