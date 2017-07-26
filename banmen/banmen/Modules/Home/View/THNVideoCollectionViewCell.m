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
#import <AVFoundation/AVFoundation.h>

@implementation THNVideoCollectionViewCell

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
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
        }];
        
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.discribeLabel.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(10);
        }];
    }
    return self;
}

-(void)setModel:(THNGoodsVideoModel *)model{
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.video_image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    self.discribeLabel.text = model.describe;
    NSInteger second = [self durationWithVideo:[NSURL URLWithString:model.video]];
    
    NSString *str;
    if (second > 60) {
        NSInteger minutes = second / 60;
        NSString *str2;
        if (minutes >= 10) {
            str2 = [NSString stringWithFormat:@"%ld",minutes];
        } else {
            str2 = [NSString stringWithFormat:@"0%ld",minutes];
        }
        NSInteger seconds = second - minutes * 60;
        if (seconds >= 10) {
            str = [NSString stringWithFormat:@"%@:%ld",str2 ,seconds];
        } else {
            str = [NSString stringWithFormat:@"%@:0%ld",str2 ,seconds];
        }
    } else {
        if (second >= 10) {
            str = [NSString stringWithFormat:@"00:%ld",second];
        } else {
            str = [NSString stringWithFormat:@"00:0%ld",second];
        }
    }
    self.timeLabel.text = str;
}

-(NSInteger)durationWithVideo:(NSURL*)videoUrl{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts];
    NSInteger second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    return second;
}

-(UILabel *)discribeLabel{
    if (!_discribeLabel) {
        _discribeLabel = [[UILabel alloc] init];
        _discribeLabel.font = [UIFont systemFontOfSize:10];
        _discribeLabel.textColor = [UIColor colorWithHexString:@"#545454"];
    }
    return _discribeLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor colorWithHexString:@"#545454"];
    }
    return _timeLabel;
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
