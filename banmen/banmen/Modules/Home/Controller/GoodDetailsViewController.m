//
//  GoodDetailsViewController.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodDetailsViewController.h"
#import "GoodDetailsView.h"

@interface GoodDetailsViewController ()

@property(nonatomic, strong) GoodDetailsView *goodDetailsView;

@end

@implementation GoodDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.goodDetailsView];
}

-(GoodDetailsView *)goodDetailsView{
    if (!_goodDetailsView) {
        _goodDetailsView = [[GoodDetailsView alloc] initWithFrame:self.view.frame];
    }
    return _goodDetailsView;
}

-(void)setModel:(Cooperation *)model{
    self.navigationItem.title = model.name;
}

@end
