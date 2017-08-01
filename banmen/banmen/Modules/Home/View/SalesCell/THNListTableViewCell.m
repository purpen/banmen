//
//  THNListTableViewCell.m
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNListTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "BezierCurveView.h"
#import "OtherMacro.h"
#import "UIView+FSExtension.h"

@implementation THNListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"#f7f7f9"];
        
        [self.contentView addSubview:self.serialNumberLabel];
        [_serialNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.idLabel];
        [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(30/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(110/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
            make.width.mas_lessThanOrEqualTo(100/SCREEN_HEIGHT*667.0);
        }];
        
        [self.contentView addSubview:self.salesNumLabel];
        [_salesNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(220/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.salesLabel];
        [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(250/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.percentLabel];
        [_percentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_left).mas_offset(340/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
        }];
        
        
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.serialNumberLabel.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.percentLabel.mas_right).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e6"];
    }
    return _lineView;
}

-(UILabel *)salesNumLabel{
    if (!_salesNumLabel) {
        _salesNumLabel = [[UILabel alloc] init];
        _salesNumLabel.font = [UIFont systemFontOfSize:10];
        _salesNumLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _salesNumLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _salesNumLabel;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.font = [UIFont systemFontOfSize:10];
        _salesLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _salesLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _salesLabel;
}

-(UILabel *)percentLabel{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] init];
        _percentLabel.font = [UIFont systemFontOfSize:10];
        _percentLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _percentLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _percentLabel;
}

-(UILabel *)serialNumberLabel{
    if (!_serialNumberLabel) {
        _serialNumberLabel = [[UILabel alloc] init];
        _serialNumberLabel.font = [UIFont systemFontOfSize:10];
        _serialNumberLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _serialNumberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _serialNumberLabel;
}

-(UILabel *)goodsNameLabel{
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        _goodsNameLabel.font = [UIFont systemFontOfSize:10];
        _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _goodsNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNameLabel;
}

-(UILabel *)idLabel{
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.font = [UIFont systemFontOfSize:10];
        _idLabel.textColor = [UIColor colorWithHexString:@"#676769"];
        _idLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _idLabel;
}

-(void)setModel:(THNSalesListModel *)model{
    _model = model;
    self.idLabel.text = model.sku_number;
    self.goodsNameLabel.text = model.sku_name;
    self.salesNumLabel.text = model.sales_quantity;
    self.salesLabel.text = [NSString stringWithFormat:@"%.0f", [model.sum_money floatValue]];
    self.percentLabel.text = [NSString stringWithFormat:@"%@%%", model.proportion];
}

@end
