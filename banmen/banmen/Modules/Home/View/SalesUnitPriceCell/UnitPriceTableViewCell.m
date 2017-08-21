//
//  UnitPriceTableViewCell.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UnitPriceTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"
#import "ChartsSwift.h"
#import "UnitPriceModel.h"
#import "DateValueFormatter.h"
#import "ColorMacro.h"
#import "THNUnitPriceValueFormatter.h"

@interface UnitPriceTableViewCell() <ChartViewDelegate>

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;

@end

@implementation UnitPriceTableViewCell

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
        
        [self.contentView addSubview:self.lineChartView];
        [_lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-15);
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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    UnitPriceModel *model = modelAry[0];
    if (model.range == NULL) {
        self.topLeftTwoLabel.text = [NSString stringWithFormat:@"客单价0：0%%"];
    } else {
        self.topLeftTwoLabel.text = [NSString stringWithFormat:@"客单价%@：%@%%", model.range, model.proportion];
    }
    
    
    CGFloat maxMoney = [model.proportion floatValue];
    CGFloat minMoney = [model.proportion floatValue];
    for (int i = 0; i < modelAry.count; i++) {
        UnitPriceModel *model = modelAry[i];
        if ([model.proportion floatValue] > maxMoney) {
            maxMoney = [model.proportion floatValue];
        }
        if ([model.proportion floatValue] < minMoney) {
            minMoney = [model.proportion floatValue];
        }
    }
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.axisMaximum = maxMoney*1.2;
    leftAxis.axisMinimum = minMoney;
    
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < modelAry.count; i++)
    {
        UnitPriceModel *model = modelAry[i];
        CGFloat val = [model.proportion floatValue];
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    NSInteger xVals_count = modelAry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        UnitPriceModel *model = modelAry[i];
        [xVals addObject:model.range];
    }
    self.lineChartView.xAxis.valueFormatter = [[DateValueFormatter alloc] initWithArr:xVals];
    
    LineChartDataSet *set1 = nil;
    if (_lineChartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_lineChartView.data.dataSets[0];
        set1.values = values;
        self.lineChartView.maxVisibleCount = 6;
        [_lineChartView.data notifyDataChanged];
        [_lineChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:nil];
        
        
        set1.drawIconsEnabled = NO;
        set1.drawValuesEnabled = NO;
        
        
        set1.mode = LineChartModeHorizontalBezier;
        
        set1.lineDashLengths = @[@100.f, @0.f];
        set1.highlightLineDashLengths = @[@5.f, @2.5f];
        [set1 setColor:UIColor.blackColor];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 1.0;
        set1.circleRadius = 3.0;
        set1.drawCircleHoleEnabled = YES;
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawFilledEnabled = NO;//是否填充颜色
        set1.fillColor = [UIColor colorWithHexString:kColorDefalut];
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
        self.lineChartView.maxVisibleCount = 6;//设置能够显示的数据数量
    }
}

-(void)setTimeAry:(NSArray *)timeAry{
    _timeAry = timeAry;
    [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", timeAry[0], timeAry[1]] forState:(UIControlStateNormal)];
    if (timeAry.count == 0) {
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
        NSTimeInterval  oneDay = 24*60*60*1;
        NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
        NSString *the_date_str = [date_formatter stringFromDate:theDate];
        [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", the_date_str, current_date_str] forState:(UIControlStateNormal)];
    }
}

-(LineChartView *)lineChartView{
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
        _lineChartView.noDataText = @"暂无数据";
        _lineChartView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        _lineChartView.delegate = self;
        _lineChartView.chartDescription.enabled = NO;
        _lineChartView.dragEnabled = YES;
        [_lineChartView setScaleEnabled:NO];
        _lineChartView.pinchZoomEnabled = NO;
        _lineChartView.drawGridBackgroundEnabled = NO;
        
        [_lineChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:10];
        
        _lineChartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
        _lineChartView.xAxis.drawGridLinesEnabled = NO;
        _lineChartView.xAxis.gridLineDashPhase = 0.f;
        _lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
        _lineChartView.maxVisibleCount = 6;//设置能够显示的数据数量
        _lineChartView.xAxis.labelFont = [UIFont systemFontOfSize:7];
        _lineChartView.xAxis.gridColor = [UIColor colorWithHexString:@"#E7E7E7"];
        
        ChartYAxis *leftAxis = _lineChartView.leftAxis;
        [leftAxis removeAllLimitLines];
        leftAxis.gridLineDashLengths = @[@1.f, @1.f];
        leftAxis.gridColor = [UIColor colorWithHexString:@"#E7E7E7"];
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.drawLimitLinesBehindDataEnabled = YES;
        leftAxis.axisLineDashLengths = @[@0.f, @0.0f];
        leftAxis.spaceTop = 0.0;
        leftAxis.valueFormatter = [[THNUnitPriceValueFormatter alloc] init];
        
        
        _lineChartView.rightAxis.enabled = NO;
        
        _lineChartView.legend.enabled = NO;
        
        ChartMarkerView *marker = [[ChartMarkerView alloc] init];
        marker.backgroundColor = [UIColor blackColor];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dot"]];
        image.frame = CGRectMake(0, 0, 10, 10);
        image.center = marker.center;
        [marker addSubview:image];
        //        marker.size = CGSizeMake(80.f, 40.f);
        _lineChartView.marker = marker;
        
        [_lineChartView animateWithXAxisDuration:1.5];
        
    }
    return _lineChartView;
}


-(UIButton *)dateSelectBtn{
    if (!_dateSelectBtn) {
        _dateSelectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _dateSelectBtn.layer.borderColor = [UIColor colorWithHexString:@"#e9e9e9"].CGColor;
        _dateSelectBtn.layer.borderWidth = 1;
        _dateSelectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
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

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"销售客单价";
        _salesLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _salesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salesLabel;
}

-(UILabel *)topLeftTwoLabel{
    if (!_topLeftTwoLabel) {
        _topLeftTwoLabel = [[UILabel alloc] init];
        _topLeftTwoLabel.text = @"销售额：123232312";
        _topLeftTwoLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _topLeftTwoLabel.font = [UIFont systemFontOfSize:10];
    }
    return _topLeftTwoLabel;
}

#pragma mark - ChartViewDelegate
-(void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight{
    UnitPriceModel *model = self.modelAry[(NSInteger)entry.x];
    self.topLeftTwoLabel.text = [NSString stringWithFormat:@"客单价%@：%@%%", model.range, model.proportion];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}


@end
