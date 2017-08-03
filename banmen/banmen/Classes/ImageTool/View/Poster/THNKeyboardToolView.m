//
//  THNKeyboardToolView.m
//  banmen
//
//  Created by FLYang on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNKeyboardToolView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@implementation THNKeyboardToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#222222"];
        [self setViewUI];
    }
    return self;
}

- (void)thn_setHiddenExtendingFunction:(BOOL)hidden {
    self.changeTextColor.hidden = hidden;
    self.fontStyle.hidden = hidden;
    self.fontSize.hidden = hidden;
}

- (void)setViewUI {
    [self addSubview:self.changeTextColor];
    [_changeTextColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.width.mas_equalTo(@44);
    }];
    
    [self addSubview:self.closeKeybord];
    [_closeKeybord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self).with.offset(0);
        make.width.mas_equalTo(@44);
    }];
}

- (UIButton *)changeTextColor {
    if (!_changeTextColor) {
        _changeTextColor = [[UIButton alloc] init];
        [_changeTextColor setImage:[UIImage imageNamed:@"icon_change_color"] forState:(UIControlStateNormal)];
        [_changeTextColor setImage:[UIImage imageNamed:@"icon_change_colorClick"] forState:(UIControlStateSelected)];
        [_changeTextColor addTarget:self action:@selector(changeTextColorClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _changeTextColor.selected = NO;
    }
    return _changeTextColor;
}

- (UIButton *)closeKeybord {
    if (!_closeKeybord) {
        _closeKeybord = [[UIButton alloc] init];
        [_closeKeybord setImage:[UIImage imageNamed:@"icon_keyboard_gray"] forState:(UIControlStateNormal)];
        [_closeKeybord addTarget:self action:@selector(closeKeybordClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeKeybord;
}


- (void)changeTextColorClick:(UIButton *)button {
    if (button.selected == NO) {
        button.selected = YES;
        if ([self.delegate respondsToSelector:@selector(thn_writeInputBoxChangeTextColor)]) {
            [self.delegate thn_writeInputBoxChangeTextColor];
        }
        
    } else {
        button.selected = NO;
        
    }
    
}

- (void)closeKeybordClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(thn_writeInputBoxResignFirstResponder)]) {
        [self.delegate thn_writeInputBoxResignFirstResponder];
    }
}

@end
