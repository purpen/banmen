//
//  THNArticleBlockCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/8/4.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNArticleBlockCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

@implementation THNArticleBlockCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(0);
            make.width.mas_equalTo(170/2/667.0*SCREEN_HEIGHT);
            make.height.mas_equalTo(60/667.0*SCREEN_HEIGHT);
        }];
        
        [self.contentView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [self.contentView addSubview:self.wordLabel];
        [_wordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.imageView.mas_top).mas_offset(2/667.0*SCREEN_HEIGHT);
        }];
        
        [self.contentView addSubview:self.fromLabel];
        [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.wordLabel.mas_bottom).mas_offset(3/667.0*SCREEN_HEIGHT);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.fromLabel.mas_bottom).mas_offset(3/667.0*SCREEN_HEIGHT);
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(3);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        }];
    }
    return self;
}

-(void)setGoodsArticleModel:(THNGoodsArticleModel *)goodsArticleModel{
    _goodsArticleModel = goodsArticleModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:goodsArticleModel.cover_srcfile] placeholderImage:[UIImage imageNamed:@"articlePlaceholder"]];
    self.fromLabel.text = [NSString stringWithFormat:@"来源：%@", goodsArticleModel.site_from];
    self.timeLabel.text = goodsArticleModel.article_time;
    self.contentLabel.text = goodsArticleModel.article_describe;
    [UILabel changeLineSpaceForLabel:self.contentLabel WithSpace:5];
    self.wordLabel.text = goodsArticleModel.title;
    if (goodsArticleModel.cover_srcfile.length == 0) {
        self.imageView.hidden = YES;
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
        [_wordLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10/667.0*SCREEN_HEIGHT);
        }];
        
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
//            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(6/667.0*SCREEN_HEIGHT);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10/667.0*SCREEN_HEIGHT);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        }];
        [self.contentView layoutIfNeeded];
    } else {
        self.imageView.hidden = NO;
        [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(170/2);
        }];
        [_wordLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.imageView.mas_top).mas_offset(2/667.0*SCREEN_HEIGHT);
        }];
        
        [_contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
//            make.top.mas_equalTo(self.timeLabel.mas_bottom).mas_offset(6/667.0*SCREEN_HEIGHT);
            make.height.mas_equalTo(12);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(0/667.0*SCREEN_HEIGHT);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-15);
        }];
    }
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
//        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _contentLabel.font = [UIFont systemFontOfSize:10];
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
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
        _wordLabel.numberOfLines = 1;
        _wordLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _wordLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wordLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#d2d2d2"];
    }
    return _lineView;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
