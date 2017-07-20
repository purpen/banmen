//
//  SalesChannelsTableViewCell.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesChannelsTableViewCell.h"
#import "Masonry.h"
#import "ChannelsItemTableViewCell.h"
#import "UIColor+Extension.h"

@interface SalesChannelsTableViewCell () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SalesChannelsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(15);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
        }];
    }
    return self;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ChannelsItemTableViewCell class] forCellReuseIdentifier:@"ChannelsItemTableViewCell1"];
        [_tableView registerClass:[ChannelsItemTableViewCell class] forCellReuseIdentifier:@"ChannelsItemTableViewCell"];
        _tableView.layer.borderColor = [UIColor colorWithHexString:@"#d2d2d2"].CGColor;
        _tableView.layer.borderWidth = 1;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelAry.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ChannelsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelsItemTableViewCell1"];
        cell.serialNumberLael.text = @"序号";
        cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        cell.areaLael.text = @"地区";
        cell.salesLael.text = @"销售额";
        cell.percentageLael.text = @"百分比";
        return cell;
    } else {
        ChannelsItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChannelsItemTableViewCell"];
        cell.model = self.modelAry[indexPath.row-1];
        cell.serialNumberLael.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

@end
