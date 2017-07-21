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
        
    }
    return self;
}

-(UIImageView *)goodsImageView{
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
}

@end
