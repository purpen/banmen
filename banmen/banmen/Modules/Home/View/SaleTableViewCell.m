//
//  SaleTableViewCell.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SaleTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "BezierCurveView.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"

@interface SaleTableViewCell()

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;

@end

@implementation SaleTableViewCell

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
        
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.dateSelectBtn.mas_right).mas_offset(0);
            make.centerY.mas_equalTo(self.topLeftTwoLabel.centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.lineChartView];
        [_lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.dateSelectBtn.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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
    int xVals_count = 12;//X轴上要显示多少条数据
    double maxYVal = 100;//Y轴的最大值
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i+1]];
    }
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        double mult = maxYVal + 1;
        double val = (double)(arc4random_uniform(mult));
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:0 data:yVals];
        [yVals addObject:entry];
    }
    LineChartDataSet *set1 = nil;
}

-(LineChartView *)lineChartView{
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
        _lineChartView.delegate = self;
        _lineChartView.noDataText = @"暂无数据";
        _lineChartView.chartDescription.enabled = YES;
        _lineChartView.scaleYEnabled = NO;//取消Y轴缩放
        _lineChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineChartView.dragEnabled = YES;//启用拖拽图标
        _lineChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //描述及图例样式
        [_lineChartView setDescriptionText:@""];
        _lineChartView.legend.enabled = NO;
        [_lineChartView animateWithXAxisDuration:1.0f];
        
    }
    return _lineChartView;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"销售额";
        _salesLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _salesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salesLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#848484"];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}

-(UILabel *)topLeftTwoLabel{
    if (!_topLeftTwoLabel) {
        _topLeftTwoLabel = [[UILabel alloc] init];
//        _topLeftTwoLabel.text = @"销售额：123232312";
        _topLeftTwoLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _topLeftTwoLabel.font = [UIFont systemFontOfSize:10];
    }
    return _topLeftTwoLabel;
}

@end
