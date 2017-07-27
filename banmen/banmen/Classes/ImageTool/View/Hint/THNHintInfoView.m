//
//  THNHintInfoView.m
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNHintInfoView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@implementation THNHintInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    }
    return self;
}

- (void)thn_showHintInfoViewWithText:(NSString *)text fontOfSize:(CGFloat)size color:(NSString *)color {
    if (text.length == 0) {
        return;
    }
    
    [self addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
    }];
    
    self.textLabel.font = [UIFont boldSystemFontOfSize:size];
    self.textLabel.textColor = [UIColor colorWithHexString:color];
    self.textLabel.text = text;
}

- (void)thn_showHintInfoWithImage:(NSString *)imageName {
    if (imageName.length == 0) {
        return;
    }
    
    [self addSubview:self.iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    
    self.iconImageView.image = [UIImage imageNamed:imageName];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
