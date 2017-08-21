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
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

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
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(5);
            make.bottom.mas_lessThanOrEqualTo(self.fromLabel.mas_top).mas_offset(-5);
        }];
        
        [self.contentView addSubview:self.bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(-2);
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
            make.bottom.mas_lessThanOrEqualTo(self.bgImageView.mas_top).mas_offset(0);
        }];
    }
    return self;
}

-(void)setGoodsArticleModel:(THNGoodsArticleModel *)goodsArticleModel{
    _goodsArticleModel = goodsArticleModel;
    self.wordLabel.text = goodsArticleModel.title;
    self.timeLabel.text = goodsArticleModel.article_time;
    self.contentLabel.text = goodsArticleModel.article_describe;
    [UILabel changeLineSpaceForLabel:self.contentLabel WithSpace:5];
    self.fromLabel.text = [NSString stringWithFormat:@"来源：%@", goodsArticleModel.site_from];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:goodsArticleModel.cover_srcfile] placeholderImage:[UIImage imageNamed:@"articlePlaceholder"]];
    if (goodsArticleModel.cover_srcfile.length == 0) {
        self.imageView.hidden = YES;
        self.contentLabel.hidden = NO;

    } else {
        self.imageView.hidden = NO;
        self.contentLabel.hidden = YES;

    }
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"Gradient"];
    }
    return _bgImageView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _contentLabel.font = [UIFont systemFontOfSize:10];
    }
    return _contentLabel;
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

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _timeLabel.font = [UIFont systemFontOfSize:9];
    }
    return _timeLabel;
}

-(UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.numberOfLines = 0;
        _wordLabel.textAlignment = NSTextAlignmentLeft;
        _wordLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _wordLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wordLabel;
}

@end
