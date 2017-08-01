//
//  THNSalesListTableViewCell.m
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNSalesListTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "BezierCurveView.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"
#import "DateValueFormatter.h"
#import "THNListTableViewCell.h"
#import "THNListTopTableViewCell.h"

@interface THNSalesListTableViewCell() <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;
@property (assign,nonatomic) CGFloat sliderXValue;
@property (assign,nonatomic) CGFloat sliderYValue;

@end

@implementation THNSalesListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.salesLabel];
        [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        }];
        
        [self.contentView addSubview:self.topLeftTwoLabel];
        [_topLeftTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.salesLabel.mas_bottom).mas_offset(10);
        }];
        
        [self.contentView addSubview:self.lineview];
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        [self.contentView addSubview:self.dateSelectBtn];
        [_dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
            make.height.mas_equalTo(46/2);
            make.width.mas_equalTo(288/2);
        }];
        
        [self.contentView addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.dateSelectBtn.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        [_tableView registerClass:[THNListTableViewCell class] forCellReuseIdentifier:@"THNListTableViewCell"];
        [_tableView registerClass:[THNListTopTableViewCell class] forCellReuseIdentifier:@"THNListTopTableViewCell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 60;
    } else {
        return 30;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        THNListTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNListTopTableViewCell"];
        return cell;
    }
    THNListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNListTableViewCell"];
    cell.serialNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    THNSalesListModel *model = self.modelAry[indexPath.row];
    cell.model = model;
    return cell;
}

-(UIButton *)dateSelectBtn{
    if (!_dateSelectBtn) {
        _dateSelectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _dateSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"#e9e9e9"].CGColor;
        _dateSelectBtn.layer.borderWidth = 1;
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
        NSTimeInterval  oneDay = 24*60*60*1;
        NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
        NSString *the_date_str = [date_formatter stringFromDate:theDate];
        [_dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", the_date_str, current_date_str] forState:(UIControlStateNormal)];
        _dateSelectBtn.font = [UIFont systemFontOfSize:10];
        [_dateSelectBtn setTitleColor:[UIColor colorWithHexString:@"#7d7d7d"] forState:(UIControlStateNormal)];
    }
    return _dateSelectBtn;
}

-(UIView *)lineview{
    if (!_lineview) {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    }
    return _lineview;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.tableView reloadData];
}



-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"销售排行榜";
        _salesLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _salesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salesLabel;
}

-(UILabel *)topLeftTwoLabel{
    if (!_topLeftTwoLabel) {
        _topLeftTwoLabel = [[UILabel alloc] init];
        _topLeftTwoLabel.text = @"TOP100产品排行榜";
        _topLeftTwoLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _topLeftTwoLabel.font = [UIFont systemFontOfSize:10];
    }
    return _topLeftTwoLabel;
}

@end
