//
//  THNRepeatPurchaseRateTableViewCell.m
//  banmen
//
//  Created by dong on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNRepeatPurchaseRateTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"
#import "ChartsSwift.h"
#import "DateValueFormatter.h"
#import "THNRepeatBuyModel.h"
#import "ColorMacro.h"

@interface THNRepeatPurchaseRateTableViewCell() <ChartViewDelegate>

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;
@property (strong,nonatomic) BarChartView *barChartView;

@end

@implementation THNRepeatPurchaseRateTableViewCell

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
        
        [self.contentView addSubview:self.barChartView];
        [_barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
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

-(void)setTimeAry2:(NSArray *)timeAry2{
    _timeAry2 = timeAry2;
    [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", timeAry2[0], timeAry2[1]] forState:(UIControlStateNormal)];
    if (timeAry2.count == 0) {
        NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
        [date_formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
        NSTimeInterval  oneDay = 24*60*60*1;
        NSDate *theDate = [NSDate dateWithTimeInterval:-oneDay*365 sinceDate:[NSDate date]];
        NSString *the_date_str = [date_formatter stringFromDate:theDate];
        [self.dateSelectBtn setTitle:[NSString stringWithFormat:@"%@ 至 %@", the_date_str, current_date_str] forState:(UIControlStateNormal)];
    }
}


-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    THNRepeatBuyModel *model0 = modelAry[0];
    self.topLeftTwoLabel.text = [NSString stringWithFormat:@"重复购买%.@次：%@%%", model0.count, model0.proportion];
    
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < modelAry.count; i++) {
        THNRepeatBuyModel *model = modelAry[i];
        [xVals addObject:model.count];
    }
    _barChartView.xAxis.valueFormatter = [[DateValueFormatter alloc] initWithArr:xVals];
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < modelAry.count; i++)
    {
        THNRepeatBuyModel *model = modelAry[i];
        CGFloat val = [model.proportion floatValue];
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
    BarChartDataSet *set1 = nil;
    if (_barChartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_barChartView.data.dataSets[0];
        set1.values = yVals;
        [_barChartView.data notifyDataChanged];
        [_barChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
        set1.highlightEnabled = YES;//点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        set1.drawValuesEnabled = NO;
        [set1 setColor:[UIColor colorWithHexString:kColorDefalut]];//设置柱形图颜色
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _barChartView.data = data;
    }
}

-(BarChartView *)barChartView{
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.delegate = self;
        _barChartView.noDataText = @"暂无数据";
        _barChartView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        
        _barChartView.descriptionText = @"";//不显示，就设为空字符串即可
        
        _barChartView.drawBarShadowEnabled = NO;
        _barChartView.drawValueAboveBarEnabled = YES;
        _barChartView.scaleYEnabled = NO;//取消Y轴缩放
        _barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _barChartView.dragEnabled = NO;//启用拖拽图表
        
        _barChartView.maxVisibleCount = 60;
        
        [_barChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:10];
        
        ChartXAxis *xAxis = _barChartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelFont = [UIFont systemFontOfSize:8.f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.labelCount = 7;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.gridAntialiasEnabled = YES;//开启抗锯齿
        
        NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
        leftAxisFormatter.minimumFractionDigits = 0;
        leftAxisFormatter.maximumFractionDigits = 1;
        
        _barChartView.rightAxis.enabled = NO;//不绘制右边轴
        
        ChartYAxis *leftAxis = _barChartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.labelCount = 5;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.spaceTop = 0.15;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        leftAxis.drawGridLinesEnabled = NO;
        leftAxis.axisLineDashPhase = 20;
        
        _barChartView.legend.enabled = NO;//不显示图例说明
        [_barChartView animateWithXAxisDuration:1.5];
    }
    return _barChartView;
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
        _salesLabel.text = @"重复购买率";
        _salesLabel.textColor = [UIColor colorWithHexString:@"#2f2f2f"];
        _salesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salesLabel;
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
    THNRepeatBuyModel *model = self.modelAry[(NSInteger)entry.x];
    self.topLeftTwoLabel.text = [NSString stringWithFormat:@"重复购买%.@次：%@%%", model.count, model.proportion];
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
