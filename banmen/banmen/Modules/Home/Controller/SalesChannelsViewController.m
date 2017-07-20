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

@interface SalesChannelsViewController () <SalesChannelsModelDelegate>
@property (nonatomic, strong) SalesChannelsModel *s;
@property (nonatomic, strong) SalesChannelsView *channelView;
@property (nonatomic, strong) NSArray *modelAry;
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
    }
    return _channelView;
}

-(void)updateSalesChannelsModel:(NSArray *)modelAry{
    self.modelAry = modelAry;
    self.channelView.modelAry = modelAry;
}

-(SalesChannelsModel *)s{
    if (!_s) {
        _s = [SalesChannelsModel new];
    }
    return _s;
}

@end
