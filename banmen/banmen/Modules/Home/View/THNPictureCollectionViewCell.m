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
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
        }];
    }
    return self;
}

-(void)setModel:(THNGoodsPictureModel *)model{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    self.discribeLabel.text = model.describe;
}

-(UILabel *)discribeLabel{
    if (!_discribeLabel) {
        _discribeLabel = [[UILabel alloc] init];
        _discribeLabel.font = [UIFont systemFontOfSize:10];
        _discribeLabel.textColor = [UIColor colorWithHexString:@"#545454"];
    }
    return _discribeLabel;
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
