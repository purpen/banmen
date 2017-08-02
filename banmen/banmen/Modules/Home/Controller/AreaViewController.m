//
//  AreaViewController.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "AreaViewController.h"
#import "AreaTableViewCell.h"
#import "THNOrderAreaModel.h"
#import "Masonry.h"
#import "iOS-Echarts.h"
#import "RMMapper.h"

@interface AreaViewController ()<UITableViewDelegate,UITableViewDataSource, THNOrderAreaModelDelegate>

@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) THNOrderAreaModel *a;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) PYEchartsView *mapView;
@property (strong,nonatomic) UIButton *dateSelectBtn;
@property (strong,nonatomic) UILabel *tipLabel;

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contenTableView];
    self.a.delegate = self;
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*30*12 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    [self.a orderAreaModel:the_date_str andEndTime:current_date_str];
}

-(PYEchartsView *)mapView{
    if (!_mapView) {
        _mapView  =[[PYEchartsView alloc] init];
        _mapView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
    }
    return _mapView;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _tipLabel.font = [UIFont systemFontOfSize:13];
        _tipLabel.text = @"地域分布";
    }
    return _tipLabel;
}

-(THNOrderAreaModel *)a{
    if (!_a) {
        _a = [THNOrderAreaModel new];
    }
    return _a;
}

-(void)orderAreaModel:(NSArray *)modelAry{
    self.modelAry = modelAry;
    [self.contenTableView reloadData];
}

-(UITableView *)contenTableView{
    if (!_contenTableView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _contenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 1-44-35) style:UITableViewStyleGrouped];
        _contenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contenTableView.showsVerticalScrollIndicator = NO;
        _contenTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        _contenTableView.delegate = self;
        _contenTableView.dataSource = self;
        _contenTableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        [_contenTableView registerClass:[AreaTableViewCell class] forCellReuseIdentifier:@"AreaTableViewCell"];
        [_contenTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _contenTableView;
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
        _dateSelectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_dateSelectBtn setTitleColor:[UIColor colorWithHexString:@"#7d7d7d"] forState:(UIControlStateNormal)];
    }
    return _dateSelectBtn;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 245+50;
    }
    return 245;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        [cell.contentView addSubview:self.mapView];
        [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).mas_offset(15);
            make.right.mas_equalTo(cell.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(50);
            make.bottom.mas_equalTo(cell.contentView.mas_bottom).mas_offset(-15);
        }];
        
        [cell.contentView addSubview:self.dateSelectBtn];
        [_dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(10);
            make.height.mas_equalTo(46/2);
            make.width.mas_equalTo(288/2);
        }];
        
        [cell.contentView addSubview:self.tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(cell.contentView.mas_left).mas_offset(15);
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(10);
        }];
        
        NSString *json = @"{\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{b}\"},\"series\":[{\"name\":\"中国\",\"type\":\"map\",\"mapType\":\"china\",\"selectedMode\":\"multiple\",\"itemStyle\":{\"normal\":{\"label\":{\"show\":true}},\"emphasis\":{\"label\":{\"show\":true}}},\"data\":[{\"name\":\"广东\",\"selected\":true}]}]}";
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
        [self.mapView setOption:option];
        [self.mapView loadEcharts];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaTableViewCell"];
        return cell;
    }
}

@end
