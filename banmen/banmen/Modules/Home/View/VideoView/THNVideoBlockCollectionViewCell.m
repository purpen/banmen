//
//  THNVideoBlockCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/8/4.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNVideoBlockCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "UIView+FSExtension.h"

@implementation THNVideoBlockCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#e7e7e7"].CGColor;
        self.contentView.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(self.contentView).mas_offset(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-124/2+20);
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

-(void)setModel:(THNGoodsVideoModel *)model{
    _model = model;
    self.wordLabel.text = model.describe;
//    self.fromLabel.text = [NSString stringWithFormat:@"来源：%@", goodsArticleModel.site_from];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.video_image] placeholderImage:[UIImage imageNamed:@"articlePlaceholder"]];
    self.sizeLabel.text = [NSString stringWithFormat:@"%.0fMB", [model.video_size floatValue]/1024/1024];
    self.creatAtLabel.text = [model.video_created substringToIndex:10];
    self.timeLabel.text = model.video_length;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
        [_imageView addSubview:self.playImageView];
        [_playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_imageView.center).mas_offset(0);
            make.width.height.mas_equalTo(30);
        }];
        
        [_imageView addSubview:self.bottomImageView];
        [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(_imageView).mas_offset(0);
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

-(UIImageView *)sizeImageView{
    if (!_sizeImageView) {
        _sizeImageView = [[UIImageView alloc] init];
        _sizeImageView.image = [UIImage imageNamed:@"Filesizewhite"];
    }
    return _sizeImageView;
}

-(UIImageView *)timeImageView{
    if (!_timeImageView) {
        _timeImageView = [[UIImageView alloc] init];
        _timeImageView.image = [UIImage imageNamed:@"timewhite"];
    }
    return _timeImageView;
}

-(UIImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.image = [UIImage imageNamed:@"Bottomgradient"];
        
        [_bottomImageView addSubview:self.sizeImageView];
        [_sizeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_bottomImageView.mas_left).mas_offset(7);
            make.centerY.mas_equalTo(_bottomImageView.centerY).mas_offset(0);
        }];
        
        [_bottomImageView addSubview:self.sizeLabel];
        [_sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sizeImageView.mas_right).mas_offset(2);
            make.centerY.mas_equalTo(_bottomImageView.centerY).mas_offset(0);
        }];
        
        [_bottomImageView addSubview:self.timeImageView];
        [_timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.sizeLabel.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(_bottomImageView.centerY).mas_offset(0);
        }];
        
        [_bottomImageView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.timeImageView.mas_right).mas_offset(2);
            make.centerY.mas_equalTo(_bottomImageView.centerY).mas_offset(0);
        }];
        
        [_bottomImageView addSubview:self.creatAtLabel];
        [_creatAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_bottomImageView.mas_right).mas_offset(-7);
            make.centerY.mas_equalTo(_bottomImageView.centerY).mas_offset(0);
        }];
    }
    return _bottomImageView;
}

-(UILabel *)sizeLabel{
    if (!_sizeLabel) {
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.numberOfLines = 0;
        _sizeLabel.textColor = [UIColor whiteColor];
        _sizeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _sizeLabel;
}

-(UILabel *)creatAtLabel{
    if (!_creatAtLabel) {
        _creatAtLabel = [[UILabel alloc] init];
        _creatAtLabel.numberOfLines = 0;
        _creatAtLabel.textColor = [UIColor whiteColor];
        _creatAtLabel.font = [UIFont systemFontOfSize:10];
    }
    return _creatAtLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.numberOfLines = 0;
        _timeLabel.textColor = [UIColor whiteColor];
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
        _wordLabel.numberOfLines = 0;
        _wordLabel.textColor = [UIColor colorWithHexString:@"#313131"];
        _wordLabel.font = [UIFont systemFontOfSize:12];
    }
    return _wordLabel;
}

@end
