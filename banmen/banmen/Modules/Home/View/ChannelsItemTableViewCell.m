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
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(20);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.areaLael];
        [_areaLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.serialNumberLael.mas_centerX).mas_offset(166/2/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.salesLael];
        [_salesLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.areaLael.mas_centerX).mas_offset(166/2/SCREEN_HEIGHT*667.0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.percentageLael];
        [_percentageLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.salesLael.mas_centerX).mas_offset(166/2/SCREEN_HEIGHT*667.0);
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
    self.areaLael.text = model.name;
    self.salesLael.text = model.price;
    self.percentageLael.text = [NSString stringWithFormat:@"%@%%", model.proportion];
}

-(UILabel *)percentageLael{
    if (!_percentageLael) {
        _percentageLael = [[UILabel alloc] init];
        _percentageLael.font = [UIFont systemFontOfSize:14];
        _percentageLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _percentageLael.textAlignment = NSTextAlignmentLeft;
    }
    return _percentageLael;
}

-(UILabel *)salesLael{
    if (!_salesLael) {
        _salesLael = [[UILabel alloc] init];
        _salesLael.font = [UIFont systemFontOfSize:14];
        _salesLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _salesLael.textAlignment = NSTextAlignmentLeft;
    }
    return _salesLael;
}

-(UILabel *)areaLael{
    if (!_areaLael) {
        _areaLael = [[UILabel alloc] init];
        _areaLael.font = [UIFont systemFontOfSize:14];
        _areaLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _areaLael.textAlignment = NSTextAlignmentLeft;
    }
    return _areaLael;
}

-(UILabel *)serialNumberLael{
    if (!_serialNumberLael) {
        _serialNumberLael = [[UILabel alloc] init];
        _serialNumberLael.font = [UIFont systemFontOfSize:14];
        _serialNumberLael.textColor = [UIColor colorWithHexString:@"#222222"];
        _serialNumberLael.textAlignment = NSTextAlignmentLeft;
    }
    return _serialNumberLael;
}

@end
