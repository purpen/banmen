//
//  GoodDetailsView.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodDetailsView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "GoodsDetailTableViewCell.h"

@interface GoodDetailsView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GoodDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GoodsDetailTableViewCell class] forCellReuseIdentifier:@"GoodsDetailTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 438/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailTableViewCell"];
    cell.model = self.model;
    return cell;
}

@end
