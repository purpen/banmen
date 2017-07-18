//
//  SalesViewController.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesViewController.h"
#import "SaleTableViewCell.h"
#import "SalesTrendsModel.h"
#import "HotelCalendarViewController.h"
#import "BaseNavController.h"

@interface SalesViewController () <UITableViewDelegate,UITableViewDataSource, SalesTrendsModelDelegate>
/**  */
@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) SalesTrendsModel *s;
@property (nonatomic, copy) NSString *startTimeStr;
@property (nonatomic, copy) NSString *endTimeStr;
@property (nonatomic, copy) NSString *numStr;
@property (nonatomic, strong) NSArray *modelAry;
@end

@implementation SalesViewController

-(SalesTrendsModel *)s{
    if (!_s) {
        _s = [SalesTrendsModel new];
    }
    return _s;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contenTableView];
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    self.s.sDelegate = self;
    [self.s getSalesTrendsModelItemList:current_date_str andEndTime:the_date_str];
}

-(void)getSalesTrendsModel:(NSArray*)modelAry{
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
        _contenTableView.rowHeight = 245;
        [_contenTableView registerClass:[SaleTableViewCell class] forCellReuseIdentifier:@"SaleTableViewCell"];
    }
    return _contenTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SaleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleTableViewCell"];
    if (self.modelAry.count != 0) {
        cell.modelAry = self.modelAry;
    }
    [cell.dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(void)dateSelect:(UIButton*)sender{
    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [vc setSelectCheckDateBlock:^(NSString *startDateStr, NSString *endDateStr, NSString *daysStr) {
        weakSelf.startTimeStr = startDateStr;
        weakSelf.endTimeStr = endDateStr;
        weakSelf.numStr = daysStr;
        SaleTableViewCell *cell = [self.contenTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        [cell.lineChart setXLabels:@[startDateStr,endDateStr]];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
