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

@implementation THNwordCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        self.contentView.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.wordLabel];
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.contentView).mas_offset(10);
            make.right.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        }];
    }
    return self;
}

-(void)setGoodsWordModel:(THNGoodsWorld *)goodsWordModel{
    _goodsWordModel = goodsWordModel;
    self.wordLabel.text = goodsWordModel.describe;
}

-(void)setGoodsArticleModel:(THNGoodsArticleModel *)goodsArticleModel{
    _goodsArticleModel = goodsArticleModel;
    self.wordLabel.text = goodsArticleModel.article_describe;
}

-(UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.numberOfLines = 0;
        _wordLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _wordLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wordLabel;
}

@end
