//
//  THNArticleListTableViewCell.m
//  banmen
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNArticleListTableViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"

@implementation THNArticleListTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        self.contentView.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-124/2);
        }];
        
        [self.contentView addSubview:self.fromLabel];
        [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-6);
        }];
        
        [self.contentView addSubview:self.wordLabel];
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
            make.bottom.mas_equalTo(self.fromLabel.mas_top).mas_offset(-5);
        }];
    }
    return self;
}

-(void)setGoodsArticleModel:(THNGoodsArticleModel *)goodsArticleModel{
    _goodsArticleModel = goodsArticleModel;
    self.wordLabel.text = goodsArticleModel.title;
    self.fromLabel.text = [NSString stringWithFormat:@"来源：%@", goodsArticleModel.site_from];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:goodsArticleModel.cover_srcfile] placeholderImage:[UIImage imageNamed:@"articlePlaceholder"]];
    if (goodsArticleModel.cover_srcfile.length == 0) {
        self.imageView.hidden = YES;
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
            make.bottom.mas_equalTo(self.fromLabel.mas_top).mas_offset(-5);
        }];
        [self.contentView layoutIfNeeded];
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)fromLabel{
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.numberOfLines = 0;
        _fromLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _fromLabel.font = [UIFont systemFontOfSize:10];
    }
    return _fromLabel;
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
