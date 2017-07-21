//
//  ForgetPsdView.m
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "ForgetPsdView.h"
#import "Masonry.h"
#import "OtherMacro.h"
#import "UIColor+Extension.h"

@interface ForgetPsdView () <UITextFieldDelegate>

@end

@implementation ForgetPsdView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.navView];
        [_navView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self).mas_offset(0);
            make.height.mas_equalTo(64);
        }];
        
        [self addSubview:self.tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.navView.mas_bottom).mas_offset(30);
        }];
        
        [self addSubview:self.phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.tipLabel.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.validationTF];
        [_validationTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.phoneTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.validationBtn];
        [_validationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.validationTF.mas_right).mas_offset(0);
            make.top.bottom.mas_equalTo(self.validationTF).mas_offset(0);
            make.width.mas_equalTo(210/2);
        }];
        
        [self addSubview:self.psdUpTF];
        [_psdUpTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.validationTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(44);
        }];
        
        [self addSubview:self.commitBtn];
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.phoneTF.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.phoneTF.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.psdUpTF.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(44);
        }];

        
    }
    return self;
}

-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] init];
        
        [_navView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(_navView).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [_navView addSubview:self.backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_navView.mas_left).mas_offset(15);
            make.bottom.mas_equalTo(_navView.mas_bottom).mas_offset(-15);
        }];
        
        [_navView addSubview:self.navTitleLabel];
        [_navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_navView.mas_centerX).mas_offset(0);
            make.bottom.mas_equalTo(_navView.mas_bottom).mas_offset(-15);
        }];
    }
    return _navView;
}

-(UILabel *)navTitleLabel{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.text = @"忘记密码";
        _navTitleLabel.font = [UIFont systemFontOfSize:17 weight:(15)];
        _navTitleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    }
    return _navTitleLabel;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    }
    return _backBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    }
    return _lineView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _commitBtn.backgroundColor = [UIColor colorWithHexString:@"#be8914"];
        [_commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        _commitBtn.font = [UIFont systemFontOfSize:16];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = 2;
    }
    return _commitBtn;
}

-(UITextField *)validationTF{
    if (!_validationTF) {
        _validationTF = [[UITextField alloc] init];
        _validationTF.borderStyle = UITextBorderStyleNone;
        _validationTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 1)];
        [_validationTF setLeftViewMode:UITextFieldViewModeAlways];
        _validationTF.layer.borderWidth = 1;
        _validationTF.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
        _validationTF.font = [UIFont systemFontOfSize:14];
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
        _validationBtn.font = [UIFont systemFontOfSize:14];
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
        _phoneTF.font = [UIFont systemFontOfSize:14];
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
        _psdUpTF.font = [UIFont systemFontOfSize:14];
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


-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _tipLabel.text = @"如果您忘记了你的密码，可以通过手机号找回密码。";
    }
    return _tipLabel;
}

@end
