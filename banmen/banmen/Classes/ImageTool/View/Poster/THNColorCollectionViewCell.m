//
//  THNColorCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/8/11.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNColorCollectionViewCell.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@implementation THNColorCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        [self thn_setCellViewUI];
//        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)thn_setColorInfo:(NSString *)color {
    self.colorView.backgroundColor = [UIColor colorWithHexString:color alpha:1];
    self.backView.backgroundColor = [UIColor colorWithHexString:kColorBlack alpha:1];
    self.backView.layer.borderColor = [UIColor colorWithHexString:color alpha:1].CGColor;
    self.backView.layer.borderWidth = 1.0f;
}

- (void)thn_setCellViewUI {
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, 36));
        make.centerX.centerY.equalTo(self);
    }];
    self.backView.layer.cornerRadius = 36/2;
    
    [self addSubview:self.colorView];
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerX.centerY.equalTo(self);
    }];
    self.colorView.layer.cornerRadius = 30/2;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.clipsToBounds = YES;
    }
    return _colorView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.clipsToBounds = YES;
        _backView.alpha = 0;
    }
    return _backView;
}

#pragma mark - 选中照片时的状态
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.backView.alpha = selected ? 1 : 0;
}

@end
