//
//  THNEditToolButton.m
//  banmen
//
//  Created by FLYang on 2017/7/5.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditToolButton.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNEditToolButton ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation THNEditToolButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)thn_setViewUI {
    [self addSubview:self.editButton];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.left.right.equalTo(self).with.offset(0);
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.left.right.equalTo(self).with.offset(0);
        make.top.equalTo(_editButton.mas_bottom).with.offset(10);
    }];
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] init];
        [_editButton setTitleColor:[UIColor colorWithHexString:kColorTool] forState:(UIControlStateNormal)];
        _editButton.layer.cornerRadius = 10;
        _editButton.layer.masksToBounds = YES;
    }
    return _editButton;
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

- (void)enableClick {
    
}

- (void)disableClick {
    
}


@end
