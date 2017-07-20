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

@interface UnitPriceTableViewCell() <ChartViewDelegate>

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@property (strong,nonatomic)UIView *lineview;
@property (strong,nonatomic) BarChartView *barChartView;

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
        
        [self.contentView addSubview:self.barChartView];
        [_barChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.height.mas_equalTo(340/2);
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
    int xVals_count = (int)modelAry.count;//X轴上要显示多少条数据
    double maxYVal = 0;//Y轴的最大值
    for (int i = 0; i < modelAry.count; i++) {
        UnitPriceModel *model = modelAry[i];
        if (maxYVal < [model.count doubleValue]) {
            maxYVal = [model.count doubleValue];
        }
    }
    
    ChartXAxis *xAxis = _barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置
    xAxis.drawGridLinesEnabled = NO;//绘制网格
    xAxis.labelFont = [UIFont systemFontOfSize:10.0f];//x数值字体大小
    xAxis.labelTextColor = [UIColor blackColor];//数值字体颜色
    xAxis.axisLineWidth = 1;//设置X轴线宽
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];//坐标数值样式
    leftAxisFormatter.maximumFractionDigits = 1;//Y轴坐标最多为1位小数
    ChartYAxis *leftAxis = _barChartView.leftAxis;
    leftAxis.drawZeroLineEnabled = YES;//从0开始绘画
    leftAxis.axisMaximum = maxYVal+50;//最大值
    leftAxis.axisMinimum = 0;//最小值
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];//字体大小
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//坐标数值的位置
    leftAxis.labelCount = 8;//数值分割个数
    leftAxis.labelTextColor = [UIColor blackColor];//坐标数值字体颜色
    leftAxis.spaceTop = 0.15;//最大值到顶部的范围比
    leftAxis.drawGridLinesEnabled = NO;//是否绘制网格
    leftAxis.axisLineWidth = 1;//Y轴线宽
    leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
    
    ChartYAxis *right = _barChartView.rightAxis;
    right.drawLabelsEnabled = NO;//是否显示Y轴坐标
    right.drawGridLinesEnabled = NO;//不绘制网格
    
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        UnitPriceModel *model = modelAry[i];
        [xVals addObject:model.range];
    }
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        UnitPriceModel *model = modelAry[i];
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[model.count doubleValue]];
        [yVals addObject:entry];
    }
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
    [set1 setColor:[UIColor colorWithHexString:@"#ff3266"]];//bar的颜色
    [set1 setValueTextColor: [UIColor lightGrayColor]];
    [set1 setDrawValuesEnabled:YES];//是否在bar上显示数值
    [set1 setHighlightEnabled:NO];//是否点击有高亮效果，为NO是不会显示marker的效果
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont systemFontOfSize:10]];
    self.barChartView.data = data;
    [self.barChartView notifyDataSetChanged];
}

-(BarChartView *)barChartView{
    if (!_barChartView) {
        _barChartView = [[BarChartView alloc] init];
        _barChartView.delegate = self;//设置代理
        _barChartView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        _barChartView.noDataText = @"暂无数据";//没有数据时的文字提示
        _barChartView.drawValueAboveBarEnabled = YES;//数值显示在柱形的上面还是下面
        _barChartView.drawBarShadowEnabled = YES;//是否绘制柱形的阴影背景
        _barChartView.scaleYEnabled = NO;//取消Y轴缩放
        _barChartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _barChartView.dragEnabled = YES;//启用拖拽图表
        _barChartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _barChartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        _barChartView.descriptionText = @"";
    }
    return _barChartView;
}

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight{
    NSLog(@"chartValueSelected");
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

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"销售客单价";
        _salesLabel.textColor = [UIColor colorWithHexString:@"#0f7efe"];
        _salesLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salesLabel;
}

-(UILabel *)topLeftTwoLabel{
    if (!_topLeftTwoLabel) {
        _topLeftTwoLabel = [[UILabel alloc] init];
        _topLeftTwoLabel.text = @"销售额：123232312";
        _topLeftTwoLabel.textColor = [UIColor colorWithHexString:@"#0f7efe"];
        _topLeftTwoLabel.font = [UIFont systemFontOfSize:10];
    }
    return _topLeftTwoLabel;
}


@end
