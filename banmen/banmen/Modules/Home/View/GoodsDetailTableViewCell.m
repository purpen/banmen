//
//  GoodsDetailTableViewCell.m
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodsDetailTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"

@implementation GoodsDetailTableViewCell

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"货号：%@", model.number];
    self.categoryLabel.text = [NSString stringWithFormat:@"类别：%@", model.category];
    self.shortNameLabel.text = [NSString stringWithFormat:@"商品简称：%@", model.short_name];
    self.pleasedToLabel.text = [NSString stringWithFormat:@"进货价(元)：￥%@", model.price];
    self.weightLabel.text = [NSString stringWithFormat:@"重量(kg)：%@kg", model.weight];
    NSString *str = @"SKU：";
    for (int i = 0; i<model.skus.count; i++) {
        NSDictionary *dict = model.skus[i];
        NSString *str1 = dict[@"mode"];
        NSString *str2 = [NSString stringWithFormat:@"/%@", str1];
        [str stringByAppendingString:str2];
    }
    self.skuLabel.text = str;
    if (model.status == 1) {
        self.relationshipBtn.selected = YES;
    } else {
        self.relationshipBtn.selected = NO;
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.goodsImageView];
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
            make.width.mas_equalTo(200/2);
            make.height.mas_equalTo(71);
        }];
        
        [self.contentView addSubview:self.goodsNumLabel];
        [_goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.goodsImageView.mas_top).mas_offset(3);
        }];
        
        [self.contentView addSubview:self.categoryLabel];
        [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.goodsNumLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.shortNameLabel];
        [_shortNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.categoryLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.pleasedToLabel];
        [_pleasedToLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.shortNameLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.weightLabel];
        [_weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.pleasedToLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.skuLabel];
        [_skuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.weightLabel.mas_bottom).mas_offset(5);
        }];
        
        [self.contentView addSubview:self.relationshipBtn];
        [_relationshipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNumLabel.mas_left).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-75/2);
        }];
        
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView).mas_offset(0);
            make.height.mas_equalTo(5);
        }];
        
        [self.contentView addSubview:self.editPicturesMaterialBtn];
        [_editPicturesMaterialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.relationshipBtn.mas_right).mas_offset(8);
            make.centerY.mas_equalTo(self.relationshipBtn.mas_centerY).mas_offset(0);
        }];
    }
    return self;
}

-(UIButton *)editPicturesMaterialBtn{
    if (!_editPicturesMaterialBtn) {
        _editPicturesMaterialBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _editPicturesMaterialBtn.font = [UIFont systemFontOfSize:13];
        [_editPicturesMaterialBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_editPicturesMaterialBtn setTitle:@"编辑图片素材" forState:UIControlStateNormal];
        [_editPicturesMaterialBtn setBackgroundImage:[UIImage imageNamed:@"blackbuttonBg"] forState:UIControlStateNormal];
    }
    return _editPicturesMaterialBtn;
}

-(UIButton *)relationshipBtn{
    if (!_relationshipBtn) {
        _relationshipBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _relationshipBtn.font = [UIFont systemFontOfSize:13];
        [_relationshipBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_relationshipBtn setTitle:@"+ 添加合作产品" forState:UIControlStateNormal];
        [_relationshipBtn setTitle:@"— 已合作产品" forState:UIControlStateSelected];
        [_relationshipBtn setBackgroundImage:[UIImage imageNamed:@"blackbuttonBg"] forState:UIControlStateNormal];
        [_relationshipBtn setBackgroundImage:[UIImage imageNamed:@"redbuttonBg"] forState:UIControlStateSelected];
    }
    return _relationshipBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    }
    return _lineView;
}

-(UILabel *)skuLabel{
    if (!_skuLabel) {
        _skuLabel = [[UILabel alloc] init];
        _skuLabel.font = [UIFont systemFontOfSize:11];
        _skuLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _skuLabel;
}

-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] init];
        _weightLabel.font = [UIFont systemFontOfSize:11];
        _weightLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _weightLabel;
}

-(UILabel *)pleasedToLabel{
    if (!_pleasedToLabel) {
        _pleasedToLabel = [[UILabel alloc] init];
        _pleasedToLabel.font = [UIFont systemFontOfSize:11];
        _pleasedToLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _pleasedToLabel;
}

-(UILabel *)shortNameLabel{
    if (!_shortNameLabel) {
        _shortNameLabel = [[UILabel alloc] init];
        _shortNameLabel.font = [UIFont systemFontOfSize:11];
        _shortNameLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _shortNameLabel;
}

-(UILabel *)categoryLabel{
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.font = [UIFont systemFontOfSize:11];
        _categoryLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _categoryLabel;
}

-(UILabel *)goodsNumLabel{
    if (!_goodsNumLabel) {
        _goodsNumLabel = [[UILabel alloc] init];
        _goodsNumLabel.font = [UIFont systemFontOfSize:11];
        _goodsNumLabel.textColor = [UIColor colorWithHexString:@"#5d5d5d"];
    }
    return _goodsNumLabel;
}

-(UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

@end
