//
//  THNEditToolCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/7/5.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditToolCollectionViewCell.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@implementation THNEditToolCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
        [self thn_setViewUI];
    }
    return self;
}

- (void)thn_setEditImageToolTitle:(NSString *)title withIcon:(NSString *)icon {
    self.titleLabel.text = title;
    self.iconImageView.image = [UIImage imageNamed:icon];
}

- (void)thn_setViewUI {
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.left.right.equalTo(self).with.offset(0);
    }];
    
    [self addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.centerY.equalTo(_backView);
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.left.right.equalTo(self).with.offset(0);
        make.top.equalTo(_backView.mas_bottom).with.offset(10);
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexString:kColorTool];
        _backView.layer.cornerRadius = 10;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
