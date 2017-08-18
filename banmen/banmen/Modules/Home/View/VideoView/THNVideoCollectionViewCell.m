//
//  THNVideoCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNVideoCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"

@implementation THNVideoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.contentView.centerY).mas_offset(-5);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(142/2);
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
            make.top.mas_equalTo(self.imageView.mas_top).mas_offset(3);
        }];
        
        [self.contentView addSubview:self.creatAtLabel];
        [_creatAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.imageView.mas_right).mas_offset(10);
            make.top.mas_equalTo(self.wordLabel.mas_bottom).mas_offset(6);
        }];
        
        [self.contentView addSubview:self.fromLabel];
        [_fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.wordLabel.mas_bottom).mas_offset(1);
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.creatAtLabel.mas_bottom).mas_offset(5);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(0);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        }];
        
        [self.contentView addSubview:self.sizeImageView];
        [_sizeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wordLabel.mas_left).mas_offset(0);
            make.bottom.mas_equalTo(self.imageView.mas_bottom).mas_offset(-2);
        }];
        
        [self.contentView addSubview:self.sizeLabel];
        [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sizeImageView.mas_right).mas_offset(2);
            make.bottom.mas_equalTo(self.sizeImageView.mas_bottom).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.timeImageView];
        [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sizeLabel.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.sizeImageView.mas_bottom).mas_offset(0);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeImageView.mas_right).mas_offset(2);
            make.bottom.mas_equalTo(self.sizeImageView.mas_bottom).mas_offset(0);
        }];
        
    }
    return self;
}

-(UIImageView *)timeImageView{
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc] init];
        _timeImageView.image = [UIImage imageNamed:@"time"];
    }
    return _timeImageView;
}

-(UILabel *)sizeLabel{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.numberOfLines = 0;
        _sizeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _sizeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _sizeLabel;
}

-(UILabel *)creatAtLabel{
    if (!_creatAtLabel) {
        _creatAtLabel = [[UILabel alloc] init];
        _creatAtLabel.numberOfLines = 0;
        _creatAtLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _creatAtLabel.font = [UIFont systemFontOfSize:10];
    }
    return _creatAtLabel;
}

-(UIImageView *)sizeImageView{
    if (!_sizeImageView) {
        _sizeImageView = [[UIImageView alloc] init];
        _sizeImageView.image = [UIImage imageNamed:@"Filesize"];
    }
    return _sizeImageView;
}

-(void)setModel:(THNGoodsVideoModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.video_image] placeholderImage:[UIImage imageNamed:@"articlePlaceholder"]];
//    self.fromLabel.text = [NSString stringWithFormat:@"来源：%@", goodsArticleModel.site_from];
    self.creatAtLabel.text = model.video_created;
    self.wordLabel.text = model.describe;
    self.sizeLabel.text = [NSString stringWithFormat:@"%.0fMB", [model.video_size floatValue]/1024/1024];
    self.timeLabel.text = model.video_length;
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
        _wordLabel.numberOfLines = 2;
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
        
        [_imageView addSubview:self.playImageView];
        [_playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_imageView.center).mas_offset(0);
            make.width.height.mas_equalTo(30);
        }];
    }
    return _imageView;
}

-(UIImageView *)playImageView{
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc] init];
        _playImageView.image = [UIImage imageNamed:@"PlayButton"];
    }
    return _playImageView;
}

@end
