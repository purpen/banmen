//
//  ChannelsItemTableViewCell.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "ChannelsItemTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"

@implementation ChannelsItemTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.serialNumberLael];
        [_serialNumberLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).mas_offset(30/667.0*SCREEN_HEIGHT);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.areaLael];
        [_areaLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).mas_offset(110*SCREEN_HEIGHT/667.0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.salesLael];
        [_salesLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).mas_offset(200*SCREEN_HEIGHT/667.0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.percentageLael];
        [_percentageLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).mas_offset(300*SCREEN_HEIGHT/667.0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
    }
    return _lineView;
}

-(void)setModel:(SalesChannelsModel *)model{
    _model = model;
    self.areaLael.text = model.name;
    self.salesLael.text = model.price;
    self.percentageLael.text = [NSString stringWithFormat:@"%@%%", model.proportion];
}

-(void)setAreaModel:(THNOrderAreaModel *)areaModel{
    _areaModel = areaModel;
    self.areaLael.text = areaModel.buyer_province;
    self.salesLael.text = areaModel.sum_money;
    if (areaModel.proportion == NULL) {
        self.percentageLael.text = @"0%";
    } else {
        self.percentageLael.text = [NSString stringWithFormat:@"%@%%", areaModel.proportion];
    }
}

-(UILabel *)percentageLael{
    if (!_percentageLael) {
        _percentageLael = [[UILabel alloc] init];
        _percentageLael.font = [UIFont systemFontOfSize:10];
        _percentageLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _percentageLael.textAlignment = NSTextAlignmentCenter;
    }
    return _percentageLael;
}

-(UILabel *)salesLael{
    if (!_salesLael) {
        _salesLael = [[UILabel alloc] init];
        _salesLael.font = [UIFont systemFontOfSize:10];
        _salesLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _salesLael.textAlignment = NSTextAlignmentCenter;
    }
    return _salesLael;
}

-(UILabel *)areaLael{
    if (!_areaLael) {
        _areaLael = [[UILabel alloc] init];
        _areaLael.font = [UIFont systemFontOfSize:10];
        _areaLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _areaLael.textAlignment = NSTextAlignmentCenter;
    }
    return _areaLael;
}

-(UILabel *)serialNumberLael{
    if (!_serialNumberLael) {
        _serialNumberLael = [[UILabel alloc] init];
        _serialNumberLael.font = [UIFont systemFontOfSize:10];
        _serialNumberLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _serialNumberLael.textAlignment = NSTextAlignmentCenter;
    }
    return _serialNumberLael;
}

@end
