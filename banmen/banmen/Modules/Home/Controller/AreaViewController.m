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
@property (assign,nonatomic) NSInteger *numFlag;

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
    
    self.numFlag = 1;
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
        
        CGFloat maxNum = 0;
        
        for (int i = 0; i<self.modelAry.count; i++) {
            THNOrderAreaModel *model = self.modelAry[i];
            if ([model.sum_money floatValue] > maxNum) {
                maxNum = [model.sum_money floatValue];
            }
        }
        
        NSMutableArray *strAry = [NSMutableArray array];
        for (int i = 0; i<self.modelAry.count; i++) {
            THNOrderAreaModel *model = self.modelAry[i];
            NSString *str = model.buyer_province;
            CGFloat ahpa = [model.sum_money floatValue]/maxNum;
            if (ahpa < 0.1) {
                ahpa = 0.1;
            }
            NSString *strValue = model.sum_money;
            NSString *str2 = [NSString stringWithFormat:@"{\"name\":\"%@\",\"value\":%@,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,%f)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}}", str, strValue, ahpa];
            [strAry addObject:str2];
        }
        
        NSString *str3 = [strAry componentsJoinedByString:@","];
        NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSLog(@"efdewfwefwfwfwffwef %@", str4);
        NSString *jsonStr = [NSString stringWithFormat:@"{\"tooltip\":{\"trigger\":\"item\"},\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{b}\"},\"series\":[{\"name\":\"Map\",\"type\":\"map\",\"mapLocation\":{\"x\":\"center\",\"y\":\"top\",\"height\":220},\"selectedMode\":\"multiple\",\"itemStyle\":{\"normal\":{\"borderWidth\":1,\"borderColor\":\"#DDA10D\",\"color\":\"rgba(240,180,0,0.1)\",\"label\":{\"show\":false}},\"\":{\"borderWidth\":1,\"borderColor\":\"#fff\",\"color\":\"#32cd32\",\"label\":{\"show\":true,\"textStyle\":{\"color\":\"#B48212\"}}}},\"data\":[%@],\"\":{\"itemStyle\":{\"normal\":{\"color\":\"skyblue\"}},\"data\":[{\"name\":\"天津\",\"value\":350},{\"name\":\"上海\",\"value\":103},{\"name\":\"echarts\",\"symbolSize\":21,\"x\":150,\"y\":50}]},\"geoCoord\":{\"上海\":[121.4648,31.2891],\"天津\":[117.4219,39.4189]}}]}",
                             
                             @"{\"name\":\"上海\",\"value\":14476.08,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.041117)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"云南\",\"value\":28346.91,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.080514)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"内蒙古\",\"value\":325416.12,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.924288)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"北京\",\"value\":14733.47,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.041848)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"台湾\",\"value\":336034.04,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.954447)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"吉林\",\"value\":17491.66,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.049682)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"四川\",\"value\":21252.38,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.060364)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"天津\",\"value\":13966.32,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.039669)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"宁夏\",\"value\":21857.13,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.062081)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"安徽\",\"value\":40054.26,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.113767)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"山东\",\"value\":28152.26,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.079962)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"山西\",\"value\":40950.73,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.116313)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"广东\",\"value\":323464.11,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.918744)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"广西\",\"value\":22084.15,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.062726)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"新疆\",\"value\":31453.92,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.089339)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"江苏\",\"value\":25742.06,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.073116)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"江西\",\"value\":16365.03,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.046482)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"河北\",\"value\":12004.81,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.034098)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"河南\",\"value\":12500.11,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.035504)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"浙江\",\"value\":352072.12,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,1.000000)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"海南\",\"value\":20717.22,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.058844)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"港澳\",\"value\":36087.28,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.102500)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"湖北\",\"value\":14968.93,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.042517)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"湖南\",\"value\":9896.44,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.028109)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"甘肃\",\"value\":22399.03,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.063621)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"福建\",\"value\":46234.12,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.131320)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"西藏\",\"value\":16615.06,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.047192)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"贵州\",\"value\":5551.32,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.015768)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"辽宁\",\"value\":319634.11,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.907865)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"重庆\",\"value\":78525.95,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.223039)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"钓鱼岛\",\"value\":14371.29,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.040819)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"陕西\",\"value\":27297.06,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.077533)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"青海\",\"value\":344234.42,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.977738)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}},{\"name\":\"黑龙江\",\"value\":15246.18,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,0.043304)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}}"];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
        [self.mapView setOption:option];
        [self.mapView loadEcharts];
        __weak typeof(self) weakSelf = self;
        [self.mapView addHandlerForAction:PYEchartActionClick withBlock:^(NSDictionary *params) {
            NSLog(@"asdsada  %@", params);
            PYOption *option = [PYOption new];
        }];
        
        
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
