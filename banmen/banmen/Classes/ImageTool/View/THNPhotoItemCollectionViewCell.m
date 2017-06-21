//
//  THNPhotoItemCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPhotoItemCollectionViewCell.h"

@implementation THNPhotoItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.photoImageView];
        [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, self.bounds.size.width));
        }];
    }
    return self;
}

- (void)thn_setPhotoAssetItemImageData:(THNAssetItem *)assetItem {
    [self thn_getPhotoAsset:assetItem.asset];
}

#pragma mark - 获取图片资源的图像
- (void)thn_getPhotoAsset:(PHAsset *)asset {
    PHImageManager *imageManager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    
    CGSize imageSize = CGSizeMake(asset.pixelWidth/10, asset.pixelHeight/10);
    [imageManager requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.photoImageView.image = result;
    }];
}

- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc] init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.center = self.contentView.center;
        _photoImageView.clipsToBounds = YES;
    }
    return _photoImageView;
}

@end
