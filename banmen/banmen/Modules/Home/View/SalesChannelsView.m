//
//  SalesChannelsView.m
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesChannelsView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "SalesChannelsModel.h"
#import "SalesChannelsTableViewCell.h"

@interface SalesChannelsView () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation SalesChannelsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[SalesChannelsTableViewCell class] forCellReuseIdentifier:@"SalesChannelsTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
        [cell.contentView addSubview:self.dateSelectBtn];
        [_dateSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(cell.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(10);
            make.height.mas_equalTo(46/2);
            make.width.mas_equalTo(288/2);
        }];
        
        [cell.contentView addSubview:self.pieChartView];
        [_pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(cell.contentView).mas_offset(0);
            make.top.mas_equalTo(cell.contentView.mas_top).mas_offset(40);
            make.right.mas_equalTo(cell.contentView.mas_right).mas_offset(0);
        }];
        
        cell.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        SalesChannelsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalesChannelsTableViewCell"];
        cell.modelAry = self.modelAry;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 490/2;
    } else {
        return (60/2) * (self.modelAry.count + 1)+15;
    }
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

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.tableView reloadData];
    // 循环字典数组 创建data
    NSMutableArray *values = [[NSMutableArray alloc] init];
    for (int i = 0; i < modelAry.count; i++) {
        SalesChannelsModel *model = modelAry[i];
        if ([model.proportion intValue] != 0) {
            [values addObject:[[PieChartDataEntry alloc] initWithValue:[model.proportion doubleValue] label:[NSString stringWithFormat:@"%@%@%%", model.name, model.proportion]]];
        }
    }
    
    _pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    _pieChartView.legend.formToTextSpace = 5;//文本间隔
    _pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    _pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    _pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    _pieChartView.legend.form = ChartLegendFormSquare;//图示样式: 方形、线条、圆形
    _pieChartView.legend.formSize = 12;//图示大小
    
    if (values.count > 0) {
        //dataSet
        PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
        dataSet.drawValuesEnabled = NO;//是否绘制显示数据
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        [colors addObject:[UIColor colorWithHexString:@"#00CBCB"]];
        [colors addObject:[UIColor colorWithHexString:@"#30B3F5"]];
        [colors addObject:[UIColor colorWithHexString:@"#BAA0E2"]];
        [colors addObjectsFromArray:ChartColorTemplates.liberty];
        [colors addObjectsFromArray:ChartColorTemplates.pastel];
        [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        dataSet.colors = colors;//区块颜色
        dataSet.sliceSpace = 0;//相邻区块之间的间距
        dataSet.selectionShift = 8;//选中区块时, 放大的半径
        dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
        dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
        //数据与区块之间的用于指示的折线样式
        dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
        dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
        dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
        dataSet.valueLineWidth = 0;//折线的粗细
        dataSet.valueLineColor = [UIColor brownColor];//折线颜色
        //data
        PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterPercentStyle;
        formatter.maximumFractionDigits = 0;//小数位数
        formatter.multiplier = @1.f;
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];//设置显示数据格式
        [data setValueTextColor:[UIColor whiteColor]];
        [data setValueFont:[UIFont systemFontOfSize:10]];
        self.pieChartView.data = data;
        //设置动画效果
        [self.pieChartView animateWithXAxisDuration:1.0f easingOption:ChartEasingOptionEaseOutExpo];
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

-(PieChartView *)pieChartView{
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] init];
        _pieChartView.noDataText = @"暂无数据";
        _pieChartView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        [_pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
        _pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
        _pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
        _pieChartView.drawSliceTextEnabled = YES;//是否显示区块文本
        _pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
        _pieChartView.holeRadiusPercent = 0.5;//空心半径占比
        _pieChartView.holeColor = [UIColor clearColor];//空心颜色
        _pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
        _pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
        
        _pieChartView.descriptionText = @"";
    }
    return _pieChartView;
}

@end
