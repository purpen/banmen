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
        [self thn_setHintViewUI];
    }
    return self;
}

- (void)thn_setHintViewUI {
    [self addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
    }];
}

- (void)thn_showHintInfoViewWithText:(NSString *)text fontOfSize:(CGFloat)size color:(NSString *)color {
    self.textLabel.font = [UIFont boldSystemFontOfSize:size];
    self.textLabel.textColor = [UIColor colorWithHexString:color];
    self.textLabel.text = text;
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
