//
//  THNSuccessfulOrderHoursAdayTableViewCell.m
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNSuccessfulOrderHoursAdayTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "BezierCurveView.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"
#import "DateValueFormatter.h"
#import "ColorMacro.h"

@interface THNSuccessfulOrderHoursAdayTableViewCell() <ChartViewDelegate>

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;
@property (assign,nonatomic) CGFloat sliderXValue;
@property (assign,nonatomic) CGFloat sliderYValue;

@end

@implementation THNSuccessfulOrderHoursAdayTableViewCell

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
            make.top.mas_equalTo(self.salesLabel.mas_bottom).mas_offset(10);
        }];
        
        [self.contentView addSubview:self.lineChartView];
        [_lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.dateSelectBtn.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
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
    _modelAry = modelAry;
    
    THNHourOrderModel *model = modelAry[0];
    if (model.sum_money == NULL) {
        self.topLeftTwoLabel.text = [NSString stringWithFormat:@"销售额：0"];
    } else {
        self.topLeftTwoLabel.text = [NSString stringWithFormat:@"销售额：%@", model.sum_money];
    }
    if (model.time == NULL) {
        self.timeLabel.text = @" ";
    } else {
        self.timeLabel.text = model.time;
    }
    
    CGFloat maxMoney = [model.sum_money floatValue];
    CGFloat minMoney = [model.sum_money floatValue];
    for (int i = 0; i < modelAry.count; i++) {
        THNHourOrderModel *model = modelAry[i];
        if ([model.sum_money floatValue] > maxMoney) {
            maxMoney = [model.sum_money floatValue];
        }
        if ([model.sum_money floatValue] < minMoney) {
            minMoney = [model.sum_money floatValue];
        }
    }
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.axisMaximum = maxMoney;
    leftAxis.axisMinimum = minMoney;
    
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < modelAry.count; i++)
    {
        THNHourOrderModel *model = modelAry[i];
        CGFloat val = [model.sum_money floatValue];
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    NSInteger xVals_count = modelAry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        THNHourOrderModel *model = modelAry[i];
        [xVals addObject:model.time];
    }
    self.lineChartView.xAxis.valueFormatter = [[DateValueFormatter alloc] initWithArr:xVals];
    
    LineChartDataSet *set1 = nil;
    if (_lineChartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_lineChartView.data.dataSets[0];
        set1.values = values;
        [_lineChartView.data notifyDataChanged];
        [_lineChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:nil];
        
        
        set1.drawIconsEnabled = NO;
        set1.drawValuesEnabled = NO;
        
        set1.lineDashLengths = @[@5.f, @2.5f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = YES;
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawFilledEnabled = NO;//是否填充颜色
        set1.valueFont = [UIFont systemFontOfSize:9.f];
        set1.formLineDashLengths = @[@5.f, @2.5f];
        set1.formLineWidth = 1.0;
        set1.formSize = 15.0;
        [set1 setColor:[UIColor colorWithHexString:kColorDefalut]];//折线颜色
        
        NSArray *gradientColors = @[
                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
                                    ];
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
        set1.fillAlpha = 1.f;
        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        
        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _lineChartView.data = data;
        _lineChartView.maxVisibleCount = 6;//设置能够显示的数据数量
    }
}

-(void)setTimeAry:(NSArray *)timeAry{
    _timeAry = timeAry;
    [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", timeAry[0], timeAry[1]] forState:(UIControlStateNormal)];
}

-(LineChartView *)lineChartView{
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
        _lineChartView.delegate = self;
        _lineChartView.noDataText = @"暂无数据";
        _lineChartView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        _lineChartView.chartDescription.enabled = NO;
        _lineChartView.dragEnabled = YES;
        [_lineChartView setScaleEnabled:NO];
        _lineChartView.pinchZoomEnabled = NO;
        _lineChartView.drawGridBackgroundEnabled = NO;
        
        _lineChartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
        _lineChartView.xAxis.gridLineDashPhase = 0.f;
        _lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
        _lineChartView.maxVisibleCount = 6;//设置能够显示的数据数量
        _lineChartView.xAxis.labelFont = [UIFont systemFontOfSize:7];
        _lineChartView.xAxis.gridColor = [UIColor colorWithHexString:@"#e7e7e7"];
        
        ChartYAxis *leftAxis = _lineChartView.leftAxis;
        [leftAxis removeAllLimitLines];
        leftAxis.gridLineDashLengths = @[@5.f, @5.f];
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.drawLimitLinesBehindDataEnabled = YES;
        leftAxis.gridColor = [UIColor colorWithHexString:@"#e7e7e7"];
        
        _lineChartView.rightAxis.enabled = NO;
        
        _lineChartView.legend.enabled = NO;
        
        [_lineChartView animateWithXAxisDuration:2.5];
    }
    return _lineChartView;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"24小时成功下单";
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
        _topLeftTwoLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _topLeftTwoLabel.font = [UIFont systemFontOfSize:10];
    }
    return _topLeftTwoLabel;
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    self.topLeftTwoLabel.text = [NSString stringWithFormat:@"销售额：%.2f", entry.y];
    THNHourOrderModel *model = self.modelAry[(NSInteger)entry.x];
    self.timeLabel.text = model.time;
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
