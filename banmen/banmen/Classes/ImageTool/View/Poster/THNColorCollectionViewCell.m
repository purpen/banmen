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
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerX.centerY.equalTo(self);
    }];
    self.backView.layer.cornerRadius = 32/2;
    
    [self addSubview:self.colorView];
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(26, 26));
        make.centerX.centerY.equalTo(self);
    }];
    self.colorView.layer.cornerRadius = 26/2;
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
