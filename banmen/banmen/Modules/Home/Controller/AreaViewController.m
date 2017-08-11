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
#import "HotelCalendarViewController.h"
#import "THNDateSelectViewController.h"

@interface AreaViewController ()<UITableViewDelegate,UITableViewDataSource, THNOrderAreaModelDelegate, THNDateSelectViewControllerDelegate>

@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) THNOrderAreaModel *a;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) PYEchartsView *mapView;
@property (strong,nonatomic) UIButton *dateSelectBtn;
@property (strong,nonatomic) UILabel *tipLabel;
@property (strong,nonatomic) NSArray *timeAry;

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
        _mapView.userInteractionEnabled = YES;
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
        _contenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 1-44-35-50) style:UITableViewStyleGrouped];
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
        _dateSelectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_dateSelectBtn setTitleColor:[UIColor colorWithHexString:@"#7d7d7d"] forState:(UIControlStateNormal)];
        [_dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dateSelectBtn;
}

-(void)dateSelect:(UIButton*)sender{
    THNDateSelectViewController *vc = [[THNDateSelectViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getDate:(NSDate *)startDate andEnd:(NSDate *)endDate{
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startstr = [date_formatter stringFromDate:startDate];
    NSString *endStr = [date_formatter stringFromDate:endDate];
    self.timeAry = @[startstr, endStr];
    [self.a orderAreaModel:startstr andEndTime:endStr];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 245+50;
    }
    return (self.modelAry.count*30+50);
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
        
        NSMutableArray *strAry = [NSMutableArray array];
        for (int i = 0; i<self.modelAry.count; i++) {
            THNOrderAreaModel *model = self.modelAry[i];
            NSString *str = model.buyer_province;
            CGFloat ahpa = [model.proportion floatValue];
            NSString *str2 = [NSString stringWithFormat:@"{\"name\":\"%@\",\"selected\":true,\"value\":\"10\",\"itemStyle\":{\"emphasis\":{\"areaStyle\":{\"color\":\"rgba(255,59,107,%f)\"}},\"normal\":{\"borderColor\":\"rgba(100,149,237,1)\",\"borderWidth\":0.5,\"areaStyle\":{\"color\":\"#1b1b1b\"}},\"emphasis\":{\"label\":{\"show\":false}}}}]}", str, ahpa];
            [strAry addObject:str2];
        }
        
        NSString *str3 = [strAry componentsJoinedByString:@","];
        NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSLog(@"sadasdsadsadsaddsa   %@", str4);
        NSString *jsonStr = [NSString stringWithFormat:@"{\"backgroundColor\":\"#f7f7f9\",\"color\":[\"gold\",\"aqua\",\"lime\"],\"tooltip\":{\"trigger\":\"item\"},\"visualMap\":{\"textStyle\":{\"color\":\"#fff\"}},\"series\":[{\"name\":\"中国\",\"type\":\"map\",\"mapType\":\"china\",\"selectedMode\":\"multiple\",\"itemStyle\":{\"emphasis\":{\"areaStyle\":{\"color\":\"rgba(255,59,107,1)\"}},\"normal\":{\"borderColor\":\"#c19798\",\"borderWidth\":0.5,\"areaStyle\":{\"color\":\"#cccccc\"}},\"emphasis\":{\"label\":{\"show\":false}}},\"data\":[{\"name\":\"云南\",\"selected\":true,\"value\":\"10\",\"itemStyle\":{\"emphasis\":{\"areaStyle\":{\"color\":\"rgba(255,59,107,1.0600)\"}},\"normal\":{\"borderColor\":\"rgba(100,149,237,1)\",\"borderWidth\":0.5,\"areaStyle\":{\"color\":\"#1b1b1b\"}},\"emphasis\":{\"label\":{\"show\":false}}}}]}]}"];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
        [self.mapView setOption:option];
        [self.mapView loadEcharts];
        
        
        [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", self.timeAry[0], self.timeAry[1]] forState:(UIControlStateNormal)];
        if (self.timeAry.count == 0) {
            NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
            [date_formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
            NSTimeInterval  oneDay = 24*60*60*1;
            NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
            NSString *the_date_str = [date_formatter stringFromDate:theDate];
            [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", the_date_str, current_date_str] forState:(UIControlStateNormal)];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        AreaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AreaTableViewCell"];
        cell.modelAry = self.modelAry;
        return cell;
    }
}

@end
