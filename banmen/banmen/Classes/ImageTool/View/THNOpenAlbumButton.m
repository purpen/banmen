//
//  THNOpenAlbumButton.m
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNOpenAlbumButton.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "UILable+Frame.h"

@implementation THNOpenAlbumButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self thn_setButtonViewUI];
        [self addTarget:self action:@selector(openAlbumButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

#pragma mark - 按钮点击响应操作
- (void)openAlbumButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(thn_albumButtonTouchUpInside:)]) {
        [self.delegate thn_albumButtonTouchUpInside:button];
    }
    
    [self thn_rotateButtonIcon:button.selected];
}

- (void)thn_rotateButtonIcon:(BOOL)rotate {
    [UIView animateWithDuration:.3 animations:^{
        self.icon.transform = CGAffineTransformIdentity;
        self.icon.transform = CGAffineTransformMakeRotation(rotate ? (M_PI * (180)/180.0) : 0);
    }];
}

#pragma mark - 绑定按钮的数据
- (void)thn_setButtonTitleText:(NSString *)text iconImage:(NSString *)imageName {
    self.nameLabel.text = text;
    CGSize nameSize = [self.nameLabel boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, 40)];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(nameSize.width +10, 40));
    }];
    
    self.icon.image = [UIImage imageNamed:imageName];
}

#pragma mark - 设置界面
- (void)thn_setButtonViewUI {
    [self addSubview:self.nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_centerX).with.offset(-10);
    }];
    
    [self addSubview:self.icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(8, 8));
        make.left.equalTo(_nameLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - init
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHexString:kColorMain];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}

@end
