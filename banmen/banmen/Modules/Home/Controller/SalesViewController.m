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
#import "THNSalesOrderTableViewCell.h"
#import "THNHourOrderModel.h"
#import "THNSuccessfulOrderHoursAdayTableViewCell.h"
#import "THNSalesListModel.h"
#import "THNSalesListTableViewCell.h"
#import "THNDateSelectViewController.h"

@interface SalesViewController () <UITableViewDelegate,UITableViewDataSource, SalesTrendsModelDelegate, THNHourOrderModelDelegate, THNSalesListModelDelegate, THNDateSelectViewControllerDelegate>
/**  */
@property (nonatomic, strong) UITableView *contenTableView;
@property (nonatomic, strong) SalesTrendsModel *s;
@property (nonatomic, strong) THNHourOrderModel *h;
@property (nonatomic, strong) THNSalesListModel *l;
@property (nonatomic, assign) BOOL sFlag;
@property (nonatomic, assign) BOOL hFlag;
@property (nonatomic, assign) BOOL lFlag;
@property (nonatomic, copy) NSString *startTimeStr;
@property (nonatomic, copy) NSString *endTimeStr;
@property (nonatomic, copy) NSString *numStr;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) NSArray *hourModelAry;
@property (nonatomic, strong) NSArray *listModelAry;
@property (nonatomic, strong) NSArray *hourTimeAry;
@property (nonatomic, assign) NSInteger rowNum;
@property (nonatomic, assign) BOOL reloadFlag;
@end

@implementation SalesViewController

-(SalesTrendsModel *)s{
    if (!_s) {
        _s = [SalesTrendsModel new];
    }
    return _s;
}

-(THNHourOrderModel *)h{
    if (!_h) {
        _h = [THNHourOrderModel new];
    }
    return _h;
}

-(THNSalesListModel *)l{
    if (!_l) {
        _l = [THNSalesListModel new];
    }
    return _l;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contenTableView];
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*30 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    self.hourTimeAry = @[the_date_str, current_date_str];
    self.s.sDelegate = self;
    [self.s getSalesTrendsModelItemList:the_date_str andEndTime:current_date_str];
    self.rowNum = 0;
    self.reloadFlag = YES;
    self.h.delegate = self;
    [self.h hourOrderModel:the_date_str andEndTime:current_date_str];
    self.l.delegate = self;
    [self.l salesListModel:the_date_str andEndTime:current_date_str];
}

-(void)salesListModel:(NSArray *)modelAry{
    _listModelAry = modelAry;
    [self.contenTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)hourOrderModel:(NSArray *)modelAry{
    _hourModelAry = modelAry;
    [self.contenTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)getSalesTrendsModel:(NSArray*)modelAry{
    self.modelAry = modelAry;
    if (self.reloadFlag) {
        [self.contenTableView reloadData];
    } else {
        [self.contenTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:self.rowNum inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(UITableView *)contenTableView{
    if (!_contenTableView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _contenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 1-44-35-20) style:UITableViewStyleGrouped];
        _contenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contenTableView.showsVerticalScrollIndicator = NO;
        _contenTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        _contenTableView.delegate = self;
        _contenTableView.dataSource = self;
        _contenTableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        _contenTableView.rowHeight = 245;
        [_contenTableView registerClass:[SaleTableViewCell class] forCellReuseIdentifier:@"SaleTableViewCell"];
        [_contenTableView registerClass:[THNSalesOrderTableViewCell class] forCellReuseIdentifier:@"THNSalesOrderTableViewCell"];
        [_contenTableView registerClass:[THNSuccessfulOrderHoursAdayTableViewCell class] forCellReuseIdentifier:@"THNSuccessfulOrderHoursAdayTableViewCell"];
        [_contenTableView registerClass:[THNSalesListTableViewCell class] forCellReuseIdentifier:@"THNSalesListTableViewCell"];
    }
    return _contenTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SaleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SaleTableViewCell"];
        cell.modelAry = self.modelAry;
        cell.dateSelectBtn.tag = indexPath.row;
        [cell.dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    } else if (indexPath.row == 1) {
        THNSalesOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNSalesOrderTableViewCell"];
        cell.modelAry = self.modelAry;
        cell.dateSelectBtn.tag = indexPath.row;
        [cell.dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    } else if (indexPath.row == 2) {
        THNSuccessfulOrderHoursAdayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNSuccessfulOrderHoursAdayTableViewCell"];
        cell.modelAry = self.hourModelAry;
        cell.timeAry = self.hourTimeAry;
        [cell.dateSelectBtn addTarget:self action:@selector(dateSelectHour:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    } else {
        THNSalesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THNSalesListTableViewCell"];
        cell.modelAry = self.listModelAry;
        [cell.dateSelectBtn addTarget:self action:@selector(dateSelectList:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
}

-(void)dateSelectList:(UIButton *)sender{
    self.sFlag = NO;
    self.lFlag = YES;
    self.hFlag = NO;
    THNDateSelectViewController *vc = [[THNDateSelectViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dateSelectHour:(UIButton *)sender{
    self.sFlag = NO;
    self.lFlag = NO;
    self.hFlag = YES;
    THNDateSelectViewController *vc = [[THNDateSelectViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dateSelect:(UIButton*)sender{
    self.rowNum = sender.tag;
    self.reloadFlag = NO;
    self.sFlag = YES;
    self.lFlag = NO;
    self.hFlag = NO;
//    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc] init];
//    __weak typeof(self) weakSelf = self;
//    [vc setSelectCheckDateBlock:^(NSString *startDateStr, NSString *endDateStr, NSString *daysStr) {
//        weakSelf.startTimeStr = startDateStr;
//        weakSelf.endTimeStr = endDateStr;
//        weakSelf.numStr = daysStr;
//        [sender setTitle:[NSString stringWithFormat:@"%@至%@", startDateStr, endDateStr] forState:(UIControlStateNormal)];
//        [self.s getSalesTrendsModelItemList:startDateStr andEndTime:endDateStr];
//    }];
//    [self.navigationController pushViewController:vc animated:YES];
    
    THNDateSelectViewController *vc = [[THNDateSelectViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)getDate:(NSDate *)startDate andEnd:(NSDate *)endDate{
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *startstr = [date_formatter stringFromDate:startDate];
    NSString *endStr = [date_formatter stringFromDate:endDate];
    if (self.hFlag) {
        [self.h hourOrderModel:startstr andEndTime:endStr];
    } else if (self.sFlag) {
        [self.s getSalesTrendsModelItemList:startstr andEndTime:endStr];
    } else if (self.hFlag) {
        self.hourTimeAry = @[startstr, endStr];
        [self.l salesListModel:startstr andEndTime:endStr];
    }
}

@end
