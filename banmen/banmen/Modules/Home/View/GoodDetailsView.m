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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[GoodsDetailTableViewCell class] forCellReuseIdentifier:@"GoodsDetailTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 2;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
//        [cell.contentView addSubview:self.pieChartView];
//        [_pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.bottom.mas_equalTo(cell.contentView).mas_offset(0);
//        }];
//        cell.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
//        return cell;
//    } else {
//        SalesChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesChannelsTableViewCell"];
//        cell.modelAry = self.modelAry;
//        return cell;
//    }
//}

@end
