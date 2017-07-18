//
//  LogUpview.m
//  banmen
//
//  Created by dong on 2017/7/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "LogUpview.h"
#import "Masonry.h"
#import "UIColor+Extension.h"

@interface LogUpview () <UITextFieldDelegate>

@end

@implementation LogUpview

-(instancetype)init{
    if (self = [super init]) {
        [self addSubview:self.phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(0);
            make.height.mas_equalTo(33);
        }];
        
        [self addSubview:self.validationTF];
        [_validationTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(33);
        }];
        
        [self addSubview:self.validationBtn];
        [_validationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.validationTF.mas_right).mas_offset(0);
            make.top.bottom.mas_equalTo(self.validationTF).mas_offset(0);
            make.width.mas_equalTo(140/2);
        }];
        
        [self addSubview:self.psdUpTF];
        [_psdUpTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.validationTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(33);
        }];
        
        [self addSubview:self.logUpBtn];
        [_logUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phoneTF.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.phoneTF.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.psdUpTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(33);
        }];
        
    }
    return self;
}

-(UIButton *)logUpBtn{
    if (!_logUpBtn) {
        _logUpBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _logUpBtn.backgroundColor = [UIColor colorWithHexString:@"#ff5a5f"];
        [_logUpBtn setTitle:@"注册" forState:(UIControlStateNormal)];
        _logUpBtn.font = [UIFont systemFontOfSize:14];
    }
    return _logUpBtn;
}

-(UITextField *)validationTF{
    if (!_validationTF) {
        _validationTF = [[UITextField alloc] init];
        _validationTF.borderStyle = UITextBorderStyleNone;
        _validationTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        [_validationTF setLeftViewMode:UITextFieldViewModeAlways];
        _validationTF.layer.borderWidth = 1;
        _validationTF.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _validationTF.font = [UIFont systemFontOfSize:11];
        _validationTF.returnKeyType = UIReturnKeyDone;
        _validationTF.placeholder = @"输入验证码";
        _validationTF.delegate = self;
    }
    return _validationTF;
}

-(UIButton *)validationBtn{
    if (!_validationBtn) {
        _validationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _validationBtn.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
        [_validationBtn setTitle:@"验证码" forState:(UIControlStateNormal)];
        _validationBtn.font = [UIFont systemFontOfSize:11];
        _validationBtn.layer.borderWidth = 1;
        _validationBtn.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        [_validationBtn setTitleColor:[UIColor colorWithHexString:@"#9b9b9b"] forState:UIControlStateNormal];
    }
    return _validationBtn;
}

-(UITextField *)phoneTF{
    if (!_phoneTF) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.borderStyle = UITextBorderStyleNone;
        _phoneTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        [_phoneTF setLeftViewMode:UITextFieldViewModeAlways];
        _phoneTF.layer.borderWidth = 1;
        _phoneTF.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _phoneTF.font = [UIFont systemFontOfSize:11];
        _phoneTF.returnKeyType = UIReturnKeyDone;
        _phoneTF.placeholder = @"手机号";
        _phoneTF.delegate = self;
    }
    return _phoneTF;
}

-(UITextField *)psdUpTF{
    if (!_psdUpTF) {
        _psdUpTF = [[UITextField alloc] init];
        _psdUpTF.borderStyle = UITextBorderStyleNone;
        _psdUpTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        [_psdUpTF setLeftViewMode:UITextFieldViewModeAlways];
        _psdUpTF.layer.borderWidth = 1;
        _psdUpTF.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _psdUpTF.font = [UIFont systemFontOfSize:11];
        _psdUpTF.returnKeyType = UIReturnKeyDone;
        _psdUpTF.placeholder = @"密码";
        _psdUpTF.delegate = self;
        _psdUpTF.secureTextEntry = YES;
    }
    return _psdUpTF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

@end
