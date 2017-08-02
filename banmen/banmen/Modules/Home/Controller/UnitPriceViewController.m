//
//  UnitPriceViewController.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UnitPriceViewController.h"
#import "UnitPriceTableViewCell.h"
#import "UnitPriceModel.h"
#import "HotelCalendarViewController.h"
#import "THNRepeatBuyModel.h"
#import "THNRepeatPurchaseRateTableViewCell.h"

@interface UnitPriceViewController ()<UITableViewDelegate,UITableViewDataSource, UnitPriceModelDelegate, RepeatBuyModelDelegate>

@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) UnitPriceModel *u;
@property (nonatomic, strong) THNRepeatBuyModel *r;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) NSArray *repeatModelAry;

@end

@implementation UnitPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    self.u.uDelegate = self;
    [self.u NetGetUnitPriceModel:the_date_str andEndTime:current_date_str];
    self.r.delegate = self;
    [self.r repeatBuyModel:the_date_str andEndTime:current_date_str];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contenTableView];
}

-(UnitPriceModel *)u{
    if (!_u) {
        _u = [UnitPriceModel new];
    }
    return _u;
}

-(THNRepeatBuyModel *)r{
    if (!_r) {
        _r = [THNRepeatBuyModel new];
    }
    return _r;
}

-(void)updateUnitPriceModel:(NSArray *)modelAry{
    self.modelAry = modelAry;
    [self.contenTableView reloadData];
}

-(void)repeatBuyModel:(NSArray *)modelAry{
    self.repeatModelAry = modelAry;
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
        _contenTableView.rowHeight = 245;
        [_contenTableView registerClass:[UnitPriceTableViewCell class] forCellReuseIdentifier:@"UnitPriceTableViewCell"];
        [_contenTableView registerClass:[THNRepeatPurchaseRateTableViewCell class] forCellReuseIdentifier:@"THNRepeatPurchaseRateTableViewCell"];
        _contenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _contenTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UnitPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitPriceTableViewCell"];
        cell.modelAry = self.modelAry;
        [cell.dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    THNRepeatPurchaseRateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNRepeatPurchaseRateTableViewCell"];
    cell.modelAry = self.repeatModelAry;
    [cell.dateSelectBtn addTarget:self action:@selector(dateSelectR:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(void)dateSelectR:(UIButton *)sender{
    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc] init];
    [vc setSelectCheckDateBlock:^(NSString *startDateStr, NSString *endDateStr, NSString *daysStr) {
        [sender setTitle:[NSString stringWithFormat:@"%@至%@", startDateStr, endDateStr] forState:(UIControlStateNormal)];
        [self.r repeatBuyModel:startDateStr andEndTime:endDateStr];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dateSelect:(UIButton *)sender{
    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc] init];
    [vc setSelectCheckDateBlock:^(NSString *startDateStr, NSString *endDateStr, NSString *daysStr) {
        [sender setTitle:[NSString stringWithFormat:@"%@至%@", startDateStr, endDateStr] forState:(UIControlStateNormal)];
        [self.u NetGetUnitPriceModel:startDateStr andEndTime:endDateStr];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
