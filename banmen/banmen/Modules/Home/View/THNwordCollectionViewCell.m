//
//  THNwordCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNwordCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@implementation THNwordCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        self.contentView.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.wordLabel];
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-10);
            make.top.mas_greaterThanOrEqualTo(self.contentView.mas_top).mas_offset(10);
            make.centerX.mas_equalTo(self.contentView.mas_centerX).mas_offset(0);
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
        }];
    }
    return self;
}

-(void)setGoodsWordModel:(THNGoodsWorld *)goodsWordModel{
    _goodsWordModel = goodsWordModel;
    self.wordLabel.text = goodsWordModel.describe;
    [UILabel changeLineSpaceForLabel:self.wordLabel WithSpace:5];
}


-(UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.numberOfLines = 8;
        _wordLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _wordLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wordLabel;
}

@end
