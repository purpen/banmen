//
//  CooperationCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "CooperationCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"
#import "ColorMacro.h"

@implementation CooperationCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodImageView];
        [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-50);
        }];
        
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView).mas_offset(0);
            make.top.mas_equalTo(self.goodImageView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [self.contentView addSubview:self.goodLabel];
        [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(5);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(5);
            make.right.mas_lessThanOrEqualTo(self.contentView.mas_right).mas_offset(-5);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.goodLabel.mas_bottom).mas_offset(10);
        }];
        
        [self.contentView addSubview:self.inventoryLabel];
        [_inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-5);
            make.centerY.mas_equalTo(self.priceLabel.mas_centerY).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.cooperationIconImageView];
        [_cooperationIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(5);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        }];
    }
    return self;
}

-(UILabel *)inventoryLabel{
    if (!_inventoryLabel) {
        _inventoryLabel = [[UILabel alloc] init];
        _inventoryLabel.font = [UIFont systemFontOfSize:10];
        _inventoryLabel.textColor = [UIColor colorWithHexString:@"#c0c0c0"];
    }
    return _inventoryLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:11];
        _priceLabel.textColor = [UIColor colorWithHexString:kColorDefalut];
    }
    return _priceLabel;
}

-(UILabel *)goodLabel{
    if (!_goodLabel) {
        _goodLabel = [[UILabel alloc] init];
        _goodLabel.font = [UIFont systemFontOfSize:11];
        _goodLabel.textColor = [UIColor colorWithHexString:@"#737373"];
    }
    return _goodLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _lineView;
}

-(UIImageView *)cooperationIconImageView{
    if (!_cooperationIconImageView) {
        _cooperationIconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Cooperated"]];
    }
    return _cooperationIconImageView;
}

-(UIImageView *)goodImageView{
    if (!_goodImageView) {
        _goodImageView = [[UIImageView alloc] init];
    }
    return _goodImageView;
}

-(void)setModel:(Cooperation *)model{
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.goodLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.inventoryLabel.text = [NSString stringWithFormat:@"库存：%@", model.inventory];
}

-(void)setRecommendedModel:(RecommendedModel *)recommendedModel{
    [self.goodImageView sd_setImageWithURL:[NSURL URLWithString:recommendedModel.image] placeholderImage:nil];
    self.goodLabel.text = recommendedModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",recommendedModel.price];
    self.inventoryLabel.text = [NSString stringWithFormat:@"库存：%@", recommendedModel.inventory];
    self.cooperationIconImageView.hidden = ![recommendedModel.status integerValue];
}

@end
