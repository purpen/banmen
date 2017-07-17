//
//  LogUpView.m
//  banmen
//
//  Created by dong on 2017/7/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "LogInView.h"
#import "Masonry.h"
#import "OtherMacro.h"
#import "UIColor+Extension.h"
#import "LogUpview.h"

@interface LogInView () <UITextFieldDelegate>

@end

@implementation LogInView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.logoImageView];
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(236/2);
            make.top.mas_equalTo(self.mas_top).mas_offset(188/2);
            make.centerX.mas_equalTo(self.mas_centerX).mas_offset(0);
        }];
        
        [self addSubview:self.logInView];
        [_logInView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(40);
            make.height.mas_equalTo(343/2);
        }];
        
        [self.logInView addSubview:self.accountView];
        [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(40);
            make.height.mas_equalTo(33);
        }];
        
        [self.accountView addSubview:self.accountImageView];
        [_accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountView.mas_left).mas_offset(3);
            make.centerY.mas_equalTo(self.accountView.mas_centerY).mas_offset(0);
            make.width.mas_equalTo(24/2);
            make.height.mas_equalTo(32/2);
        }];
        
        [self.accountView addSubview:self.accountLabel];
        [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountImageView.mas_right).mas_offset(3);
            make.centerY.mas_equalTo(self.accountView.mas_centerY).mas_offset(0);
            make.width.mas_equalTo(30);
        }];
        
        [self.accountView addSubview:self.accountTF];
        [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountLabel.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.accountView.mas_top).mas_offset(0);
            make.right.mas_equalTo(self.accountView.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.accountView.mas_bottom).mas_offset(0);
        }];
        
        [self.logInView addSubview:self.psdView];
        [_psdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.accountView.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(33);
        }];
        
        [self.psdView addSubview:self.psdImageView];
        [_psdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.psdView.mas_left).mas_offset(3);
            make.centerY.mas_equalTo(self.psdView.mas_centerY).mas_offset(0);
            make.width.mas_equalTo(24/2);
            make.height.mas_equalTo(32/2);
        }];
        
        [self.psdView addSubview:self.psdLabel];
        [_psdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.psdImageView.mas_right).mas_offset(3);
            make.centerY.mas_equalTo(self.psdView.mas_centerY).mas_offset(0);
            make.width.mas_equalTo(30);
        }];
        
        [self.psdView addSubview:self.psdTF];
        [_psdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.psdLabel.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.psdView.mas_top).mas_offset(0);
            make.right.mas_equalTo(self.psdView.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(self.psdView.mas_bottom).mas_offset(0);
        }];
        
        [self.logInView addSubview:self.logInBtn];
        [_logInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountView.mas_left).mas_offset(0);
            make.right.mas_equalTo(self.accountView.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.psdView.mas_bottom).mas_offset(15);
            make.height.mas_equalTo(33);
        }];
        
        [self.logInView addSubview:self.taihuoniaoAccountBtn];
        [_taihuoniaoAccountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountView.mas_left).mas_offset(4);
            make.top.mas_equalTo(self.logInBtn.mas_bottom).mas_offset(10);
        }];
        
        [self.logInView addSubview:self.forgetPsdBtn];
        [_forgetPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.accountView.mas_right).mas_offset(-4);
            make.top.mas_equalTo(self.logInBtn.mas_bottom).mas_offset(10);
        }];
        
        [self addSubview:self.thirdLabel];
        [_thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.forgetPsdBtn.mas_bottom).mas_offset(50);
        }];
        
        [self addSubview:self.leftLineView];
        [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.accountView.mas_left).mas_offset(20);
            make.right.mas_equalTo(self.thirdLabel.mas_left).mas_offset(-20);
            make.centerY.mas_equalTo(self.thirdLabel.mas_centerY).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [self addSubview:self.rightLineView];
        [_rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.accountView.mas_right).mas_offset(-20);
            make.left.mas_equalTo(self.thirdLabel.mas_right).mas_offset(20);
            make.centerY.mas_equalTo(self.thirdLabel.mas_centerY).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [self addSubview:self.wechatBtn];
        [_wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(40);
            make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_offset(20);
            make.width.mas_equalTo((self.frame.size.width-80)/4);
            make.height.mas_equalTo(70);
        }];
        
        [self addSubview:self.quanBtn];
        [_quanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.wechatBtn.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_offset(20);
            make.width.mas_equalTo((self.frame.size.width-80)/4);
            make.height.mas_equalTo(70);
        }];
        
        [self addSubview:self.weiboBtn];
        [_weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.quanBtn.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_offset(20);
            make.width.mas_equalTo((self.frame.size.width-80)/4);
            make.height.mas_equalTo(70);
        }];
        
        [self addSubview:self.qqBtn];
        [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.weiboBtn.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.thirdLabel.mas_bottom).mas_offset(20);
            make.width.mas_equalTo((self.frame.size.width-80)/4);
            make.height.mas_equalTo(70);
        }];
        
        [self addSubview:self.tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(267/2*SCREEN_HEIGHT/667.0);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-20);
        }];
        
        [self addSubview:self.changBtn];
        [_changBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.tipLabel.mas_right).mas_offset(0);
            make.centerY.mas_equalTo(self.tipLabel.mas_centerY).mas_offset(0);
        }];
        
        [self addSubview:self.logUpView];
        [_logUpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.logInView.mas_right).mas_offset(0);
            make.top.mas_equalTo(self.logoImageView.mas_bottom).mas_offset(40);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(344/2);
        }];
        
        [self addSubview:self.cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(30);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

-(UIView *)logInView{
    if (!_logInView) {
        _logInView = [[UIView alloc] init];
        _logInView.backgroundColor = [UIColor clearColor];
    }
    return _logInView;
}

-(LogUpview *)logUpView{
    if (!_logUpView) {
        _logUpView = [[LogUpview alloc] init];
        _logUpView.backgroundColor = [UIColor whiteColor];
    }
    return _logUpView;
}

-(UIButton *)weiboBtn{
    if (!_weiboBtn) {
        _weiboBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _weiboBtn.backgroundColor = [UIColor clearColor];
        [_weiboBtn setTitle:@"新浪微博" forState:(UIControlStateNormal)];
        _weiboBtn.font = [UIFont systemFontOfSize:11];
        [_weiboBtn setImage:[UIImage imageNamed:@"weiBo"] forState:UIControlStateNormal];
        _weiboBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -35, -30, 0);
        _weiboBtn.imageEdgeInsets = UIEdgeInsetsMake(-35, 0, 0, -40);
        [_weiboBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _weiboBtn;
}

-(UIButton *)changBtn{
    if (!_changBtn) {
        _changBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _changBtn.backgroundColor = [UIColor clearColor];
        [_changBtn setTitle:@"立即注册?" forState:(UIControlStateNormal)];
        _changBtn.font = [UIFont systemFontOfSize:11];
        [_changBtn setTitleColor:[UIColor colorWithHexString:@"#3daaff"] forState:UIControlStateNormal];
        [_changBtn addTarget:self action:@selector(changState:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _changBtn;
}

-(void)changState:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        _tipLabel.text = @"已有帐号";
        [_changBtn setTitle:@"立即登录?" forState:(UIControlStateNormal)];
    }else{
        _tipLabel.text = @"还没有帐号";
        [_changBtn setTitle:@"立即注册?" forState:(UIControlStateNormal)];
    }
    // 退出键盘
    [_logInView endEditing:YES];
    
    if (sender.selected) {
        [_logInView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(-SCREEN_WIDTH);
        }];
    }else{
        [self.logInView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(0);
        }];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [_logInView layoutIfNeeded];
    }];
}

-(UIButton *)qqBtn{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _qqBtn.backgroundColor = [UIColor clearColor];
        [_qqBtn setTitle:@"QQ" forState:(UIControlStateNormal)];
        _qqBtn.font = [UIFont systemFontOfSize:11];
        [_qqBtn setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        _qqBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, -30, 0);
        _qqBtn.imageEdgeInsets = UIEdgeInsetsMake(-35, -10, 0, -25);
        [_qqBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _qqBtn;
}

-(UIButton *)quanBtn{
    if (!_quanBtn) {
        _quanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _quanBtn.backgroundColor = [UIColor clearColor];
        [_quanBtn setTitle:@"朋友圈" forState:(UIControlStateNormal)];
        _quanBtn.font = [UIFont systemFontOfSize:11];
        [_quanBtn setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
        _quanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, -30, 0);
        _quanBtn.imageEdgeInsets = UIEdgeInsetsMake(-35, 0, 0, -25);
        [_quanBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _quanBtn;
}

-(UIButton *)wechatBtn{
    if (!_wechatBtn) {
        _wechatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _wechatBtn.backgroundColor = [UIColor clearColor];
        [_wechatBtn setTitle:@"微信" forState:(UIControlStateNormal)];
        _wechatBtn.font = [UIFont systemFontOfSize:11];
        [_wechatBtn setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        _wechatBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -45, -30, 0);
        _wechatBtn.imageEdgeInsets = UIEdgeInsetsMake(-35, -10, 0, -25);
        [_wechatBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _wechatBtn;
}

-(UIView *)rightLineView{
    if (!_rightLineView) {
        _rightLineView = [[UIView alloc] init];
        _rightLineView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    }
    return _rightLineView;
}

-(UIView *)leftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = [UIColor colorWithHexString:@"#f1f1f1"];
    }
    return _leftLineView;
}

-(UIButton *)forgetPsdBtn{
    if (!_forgetPsdBtn) {
        _forgetPsdBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _forgetPsdBtn.backgroundColor = [UIColor clearColor];
        [_forgetPsdBtn setTitle:@"忘记密码" forState:(UIControlStateNormal)];
        _forgetPsdBtn.font = [UIFont systemFontOfSize:11];
        [_forgetPsdBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _forgetPsdBtn;
}

-(UIButton *)taihuoniaoAccountBtn{
    if (!_taihuoniaoAccountBtn) {
        _taihuoniaoAccountBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _taihuoniaoAccountBtn.backgroundColor = [UIColor clearColor];
        [_taihuoniaoAccountBtn setTitle:@"太火鸟账号登录" forState:(UIControlStateNormal)];
        _taihuoniaoAccountBtn.font = [UIFont systemFontOfSize:11];
        [_taihuoniaoAccountBtn setTitleColor:[UIColor colorWithHexString:@"#797979"] forState:UIControlStateNormal];
    }
    return _taihuoniaoAccountBtn;
}

-(UIButton *)logInBtn{
    if (!_logInBtn) {
        _logInBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _logInBtn.backgroundColor = [UIColor colorWithHexString:@"#ff5a5f"];
        [_logInBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        _logInBtn.font = [UIFont systemFontOfSize:14];
    }
    return _logInBtn;
}

-(UILabel *)accountLabel{
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.font = [UIFont systemFontOfSize:11];
        _accountLabel.text = @"账号";
        _accountLabel.textColor = [UIColor colorWithHexString:@"#838383"];
    }
    return _accountLabel;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:11];
        _tipLabel.text = @"还没有账号";
        _tipLabel.textColor = [UIColor colorWithHexString:@"#838383"];
    }
    return _tipLabel;
}

-(UILabel *)thirdLabel{
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.font = [UIFont systemFontOfSize:11];
        _thirdLabel.text = @"第三账号登录";
        _thirdLabel.textColor = [UIColor colorWithHexString:@"#585858"];
    }
    return _thirdLabel;
}

-(UILabel *)psdLabel{
    if (!_psdLabel) {
        _psdLabel = [[UILabel alloc] init];
        _psdLabel.font = [UIFont systemFontOfSize:11];
        _psdLabel.text = @"密码";
        _psdLabel.textColor = [UIColor colorWithHexString:@"#838383"];
    }
    return _psdLabel;
}

-(UIImageView *)accountImageView{
    if (!_accountImageView) {
        _accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account"]];
    }
    return _accountImageView;
}

-(UIImageView *)psdImageView{
    if (!_psdImageView) {
        _psdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"psd"]];
    }
    return _psdImageView;
}

-(UIView *)psdView{
    if (!_psdView) {
        _psdView = [[UIView alloc] init];
        _psdView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        _psdView.layer.borderWidth = 1;
        _psdView.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    }
    return _psdView;
}

-(UIView *)accountView{
    if (!_accountView) {
        _accountView = [[UIView alloc] init];
        _accountView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        _accountView.layer.borderWidth = 1;
        _accountView.layer.borderColor = [UIColor colorWithHexString:@"#eeeeee"].CGColor;
    }
    return _accountView;
}

-(UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF = [[UITextField alloc] init];
        _accountTF.borderStyle = UITextBorderStyleNone;
        _accountTF.returnKeyType = UIReturnKeyDone;
        _accountTF.delegate = self;
    }
    return _accountTF;
}

-(UITextField *)psdTF{
    if (!_psdTF) {
        _psdTF = [[UITextField alloc] init];
        _psdTF.borderStyle = UITextBorderStyleNone;
        _psdTF.returnKeyType = UIReturnKeyDone;
        _psdTF.delegate = self;
        _psdTF.secureTextEntry = YES;
    }
    return _psdTF;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _logoImageView.backgroundColor = [UIColor redColor];
        _logoImageView.layer.masksToBounds = YES;
        _logoImageView.layer.cornerRadius = 236/2/2;
        _logoImageView.layer.borderColor = [UIColor colorWithHexString:@"#cbcbcb"].CGColor;
        _logoImageView.layer.borderWidth = 1;
    }
    return _logoImageView;
}

@end
