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

@implementation SalesChannelsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.mas_top).mas_offset(0);
            make.height.mas_equalTo(490/2);
        }];
        
        [self.topView addSubview:self.pieChartView];
//        [self pieChartViewDraw];
    }
    return self;
}

-(PieChartView *)pieChartView{
    if (!_pieChartView) {
        _pieChartView = [[PieChartView alloc] initWithFrame:self.topView.frame];
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
        _pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
        _pieChartView.legend.formToTextSpace = 5;//文本间隔
        _pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
        _pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
        _pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
        _pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
        _pieChartView.legend.formSize = 12;//图示大小
    }
    return _pieChartView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
    }
    return _topView;
}

@end
