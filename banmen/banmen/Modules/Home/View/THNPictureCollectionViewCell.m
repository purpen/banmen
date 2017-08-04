//
//  THNPictureCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPictureCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"

@implementation THNPictureCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(1);
            make.width.mas_equalTo(SCREEN_WIDTH-30);
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
        }];
        
        [self.contentView addSubview:self.goodsImageView];
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.width.height.mas_equalTo(41);
        }];
        
        [self.contentView addSubview:self.discribeLabel];
        [_discribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.goodsImageView.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-20);
        }];
        
        [self.contentView addSubview:self.detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.discribeLabel.mas_bottom).mas_offset(10);
            make.width.mas_lessThanOrEqualTo(200*SCREEN_HEIGHT/667.0);
        }];
    }
    return self;
}

-(void)setModel:(THNGoodsPictureModel *)model{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    self.discribeLabel.text = model.describe;
    self.detailLabel.text = [NSString stringWithFormat:@"%.0fkb  %@", [model.image_size floatValue]/1024, model.image_created];
}

-(UILabel *)discribeLabel{
    if (!_discribeLabel) {
        _discribeLabel = [[UILabel alloc] init];
        _discribeLabel.font = [UIFont systemFontOfSize:10];
        _discribeLabel.textColor = [UIColor colorWithHexString:@"#545454"];
    }
    return _discribeLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:10];
        _detailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    return _detailLabel;
}

-(UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
    }
    return _lineView;
}

@end
