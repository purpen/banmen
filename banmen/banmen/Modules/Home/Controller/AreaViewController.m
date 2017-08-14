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
#import "THNMapTapView.h"

@interface AreaViewController ()<UITableViewDelegate,UITableViewDataSource, THNOrderAreaModelDelegate, THNDateSelectViewControllerDelegate>

@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) THNOrderAreaModel *a;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) PYEchartsView *mapView;
@property (strong,nonatomic) UIButton *dateSelectBtn;
@property (strong,nonatomic) UILabel *tipLabel;
@property (strong,nonatomic) NSArray *timeAry;
@property (assign,nonatomic) NSInteger *numFlag;
@property (strong,nonatomic) THNMapTapView *mapTapView;

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

-(THNMapTapView *)mapTapView{
    if (!_mapTapView) {
        _mapTapView = [[THNMapTapView alloc] init];
    }
    return _mapTapView;
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
            NSString *str2 = [NSString stringWithFormat:@"{\"z\":\"%f\",\"name\":\"%@\",\"value\":%@,\"itemStyle\":{\"normal\":{\"color\":\"rgba(240,180,0,%f)\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"#fff\",\"fontSize\":15}}},\"emphasis\":{\"borderWidth\":1,\"borderColor\":\"#B48212\",\"color\":\"#F7A113\",\"label\":{\"show\":false,\"textStyle\":{\"color\":\"blue\"}}}}}", ahpa, str, strValue, ahpa];
            [strAry addObject:str2];
        }
        
        NSString *str3 = [strAry componentsJoinedByString:@","];
//        NSString *str4 = [str3 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        NSString *jsonStr = [NSString stringWithFormat:@"{\"series\":[{\"name\":\"\",\"type\":\"map\",\"mapLocation\":{\"x\":\"center\",\"y\":\"top\",\"height\":220},\"selectedMode\":\"linkEdit\",\"itemStyle\":{\"normal\":{\"borderWidth\":1,\"borderColor\":\"#DDA10D\",\"color\":\"rgba(240,180,0,0.1)\",\"label\":{\"show\":false}},\"\":{\"borderWidth\":1,\"borderColor\":\"#fff\",\"color\":\"#32cd32\",\"label\":{\"show\":true,\"textStyle\":{\"color\":\"#B48212\"}}}},\"data\":[%@],\"\":{\"itemStyle\":{\"normal\":{\"color\":\"skyblue\"}},\"data\":[{\"name\":\"天津\",\"value\":350},{\"name\":\"上海\",\"value\":103},{\"name\":\"echarts\",\"symbolSize\":21,\"x\":150,\"y\":50}]},\"geoCoord\":{\"上海\":[121.4648,31.2891],\"天津\":[117.4219,39.4189]}}]}", str3];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
        [self.mapView setOption:option];
        [self.mapView loadEcharts];
        
        __weak typeof(self) weakSelf = self;
        [self.mapView addHandlerForAction:PYEchartActionClick withBlock:^(NSDictionary *params) {
            NSLog(@"dsasdasd  %@", params);
            
            [weakSelf.mapTapView removeFromSuperview];
            CGFloat x = [params[@"event"][@"zrenderX"] floatValue];
            CGFloat y = [params[@"event"][@"zrenderY"] floatValue];
            weakSelf.mapTapView.width = 60;
            weakSelf.mapTapView.height = 64;
            weakSelf.mapTapView.x = x-10/667.0*SCREEN_HEIGHT;
            weakSelf.mapTapView.y = y-10/667.0*SCREEN_HEIGHT;
            weakSelf.mapTapView.areaNameLabel.text = params[@"data"][@"name"];
            weakSelf.mapTapView.salesLabel.text = [NSString stringWithFormat:@"销售额:\n%@", params[@"value"]];
            weakSelf.mapTapView.accountedLabel.text = [NSString stringWithFormat:@"占比:%.2f%%", [params[@"data"][@"z"] floatValue]*100];
            [weakSelf.view addSubview:weakSelf.mapTapView];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.mapTapView removeFromSuperview];
}

@end
