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
        [self thn_setCollecitonCellViewUI];
    }
    return self;
}

#pragma mark - 绑定图片数据
- (void)thn_setPhotoAssetItemImageData:(THNAssetItem *)assetItem {
    [self thn_getPhotoAsset:assetItem.asset];
    [self setSelected:assetItem.selected];
}

#pragma mark - 获取图片资源的图像
- (void)thn_getPhotoAsset:(PHAsset *)asset {
    PHImageManager *imageManager = [PHImageManager defaultManager];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    CGSize imageSize = CGSizeMake(100, 100);
    [imageManager requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.photoImageView.image = result;
    }];
}

#pragma mark - 设置界面控件
- (void)thn_setCollecitonCellViewUI {
    [self addSubview:self.photoImageView];
    [_photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.bounds.size.width, self.bounds.size.width));
    }];
    
    [self addSubview:self.doneIcon];
    [_doneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
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

- (UIImageView *)doneIcon {
    if (!_doneIcon) {
        _doneIcon = [[UIImageView alloc] init];
        _doneIcon.contentMode = UIViewContentModeScaleAspectFill;
        _doneIcon.image = [UIImage imageNamed:@"icon_done_selected"];
        _doneIcon.alpha = 0;
    }
    return _doneIcon;
}

#pragma mark - 选中照片时的状态
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.photoImageView.alpha = selected ? 0.5 : 1;
    self.layer.borderWidth = selected ? 2 : 0;
    self.layer.borderColor = [UIColor colorWithHexString:kColorMain alpha:1].CGColor;
    self.doneIcon.alpha = selected ? 1 : 0;
}

@end
