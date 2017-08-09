//
//  SalesChannelsViewController.m
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesChannelsViewController.h"
#import "SalesChannelsModel.h"
#import "SalesChannelsView.h"
#import "HotelCalendarViewController.h"
#import "THNDateSelectViewController.h"

@interface SalesChannelsViewController () <SalesChannelsModelDelegate, THNDateSelectViewControllerDelegate>
@property (nonatomic, strong) SalesChannelsModel *s;
@property (nonatomic, strong) SalesChannelsView *channelView;
@property (nonatomic, strong) NSArray *modelAry;
@property (nonatomic, strong) NSArray *timeAry;
@end

@implementation SalesChannelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.channelView];
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSTimeInterval  oneDay = 24*60*60*1;
    NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    self.s.sDelegate = self;
    [self.s getSalesChannelsModelItem:current_date_str andEndTime:the_date_str];
}

-(SalesChannelsView *)channelView{
    if (!_channelView) {
        _channelView = [[SalesChannelsView alloc] initWithFrame:self.view.frame];
        [_channelView.dateSelectBtn addTarget:self action:@selector(dateSelect:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _channelView;
}

-(void)dateSelect:(UIButton *)sender{
//    HotelCalendarViewController *vc = [[HotelCalendarViewController alloc] init];
//    [vc setSelectCheckDateBlock:^(NSString *startDateStr, NSString *endDateStr, NSString *daysStr) {
//        self.timeAry = @[startDateStr, endDateStr];
//        [sender setTitle:[NSString stringWithFormat:@"%@至%@", startDateStr, endDateStr] forState:(UIControlStateNormal)];
//        [self.s getSalesChannelsModelItem:startDateStr andEndTime:endDateStr];
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
    self.timeAry = @[startstr, endStr];
    [self.s getSalesChannelsModelItem:startstr andEndTime:endStr];
}

-(void)updateSalesChannelsModel:(NSArray *)modelAry{
    self.modelAry = modelAry;
    self.channelView.modelAry = modelAry;
    self.channelView.timeAry = self.timeAry;
}

-(SalesChannelsModel *)s{
    if (!_s) {
        _s = [SalesChannelsModel new];
    }
    return _s;
}

@end
