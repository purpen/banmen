//
//  THNPhotoAlbumTableViewCell.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPhotoAlbumTableViewCell.h"

@implementation THNPhotoAlbumTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:kColorWhite alpha:0];
        [self thn_setCellViewUI];
    }
    return self;
}

- (void)thn_setPhotoAlbumInfoData:(THNPhotoAlbumList *)albumInfo {
    [self thn_getPhotoAsset:albumInfo.coverPhoto];
    self.titleLabel.text = albumInfo.title;
    self.countLabel.text = [NSString stringWithFormat:@"%zi", albumInfo.count];
}

#pragma mark - 获取图片资源的图像
- (void)thn_getPhotoAsset:(PHAsset *)asset {
    PHImageManager *imageManager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    CGSize imageSize = CGSizeMake(asset.pixelWidth/20, asset.pixelHeight/20);
    [imageManager requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.coverImageView.image = result;
    }];
}

#pragma mark - 设置控件
- (void)thn_setCellViewUI {
    [self addSubview:self.coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49, 49));
        make.left.top.equalTo(self).with.offset(0);
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 49));
        make.left.equalTo(_coverImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self addSubview:self.countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 49));
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
    }];
    
    [self setNeedsDisplay];
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverImageView.center = self.contentView.center;
        _coverImageView.clipsToBounds = YES;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:kColorWhite];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"相机胶卷";
    }
    return _titleLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor colorWithHexString:@"CCCCCC"];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.text = @"15";
    }
    return _countLabel;
}

#pragma mark - 分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 50);
    CGPathAddLineToPoint(path, NULL, SCREEN_WIDTH, 50);
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:kColorWhite].CGColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
}

@end
