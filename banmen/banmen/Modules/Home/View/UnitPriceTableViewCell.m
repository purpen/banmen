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
#import "BezierCurveView.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"

@interface UnitPriceTableViewCell()

@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *topLeftTwoLabel;
@property (strong,nonatomic)BezierCurveView *bezierView;
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
        
        [self.contentView addSubview:self.bezierView];
        [_bezierView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.salesLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.topLeftTwoLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.lineview];
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        //3.柱状图
        [self drawBaseChart];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(UIView *)lineview{
    if (!_lineview) {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    }
    return _lineview;
}

//画柱状图
-(void)drawBaseChart{
    [_bezierView drawBarChartViewWithX_Value_Names:self.x_names TargetValues:self.targets];
}

/**
 *  X轴值
 */
-(NSMutableArray *)x_names{
    if (!_x_names) {
        _x_names = [NSMutableArray arrayWithArray:@[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理"]];
    }
    return _x_names;
}

/**
 *  Y轴值
 */
-(NSMutableArray *)targets{
    if (!_targets) {
        _targets = [NSMutableArray arrayWithArray:@[@20,@40,@20,@50,@30,@90,@30,@100,@70]];
    }
    return _targets;
}

-(BezierCurveView *)bezierView{
    if (!_bezierView) {
        _bezierView = [BezierCurveView initWithFrame:CGRectMake(15, self.topLeftTwoLabel.y+self.topLeftTwoLabel.height+5, SCREEN_WIDTH-30, 170)];
    }
    return _bezierView;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.text = @"销售额";
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
