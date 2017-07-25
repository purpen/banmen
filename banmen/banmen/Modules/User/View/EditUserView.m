//
//  EditUserView.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "EditUserView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"

@implementation EditUserView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        
        [self addSubview:self.topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.mas_top).mas_offset(10);
            make.height.mas_equalTo((170+88)/2);
        }];
        
        [self addSubview:self.changPsdView];
        [_changPsdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

-(UIView *)changPsdView{
    if (!_changPsdView) {
        
        _changPsdView = [[UIView alloc] init];
        _changPsdView.backgroundColor = [UIColor whiteColor];
        
        [_changPsdView addSubview:self.changPsdLabel];
        [_changPsdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_changPsdView.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(_changPsdView.mas_centerY).mas_offset(0);
        }];
        
        [_changPsdView addSubview:self.changPsdGoImageView];
        [_changPsdGoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_changPsdView.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(_changPsdView.mas_centerY).mas_offset(0);
        }];
        
        [_changPsdView addSubview:self.changPsdBtn];
        [_changPsdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.bottom.mas_equalTo(_changPsdView).mas_offset(0);
        }];
        
    }
    return _changPsdView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_topView.mas_right).mas_offset(-44);
            make.top.mas_equalTo(_topView.mas_top).mas_offset(12);
            make.width.height.mas_equalTo(60);
        }];
        
        [_topView addSubview:self.headTipLabel];
        [_headTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_topView.mas_left).mas_offset(15);
            make.centerY.mas_equalTo(self.headImageView.mas_centerY).mas_offset(0);
        }];
        
        [_topView addSubview:self.goImageView];
        [_goImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_topView.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.headImageView.mas_centerY).mas_offset(0);
        }];
        
        [_topView addSubview:self.lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_topView).mas_offset(0);
            make.top.mas_equalTo(self.headImageView.mas_bottom).mas_offset(12);
            make.height.mas_equalTo(1);
        }];
        
        [_topView addSubview:self.nameTipLabel];
        [_nameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headTipLabel.mas_left).mas_offset(0);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(14);
        }];
        
        [_topView addSubview:self.nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameTipLabel.mas_centerY).mas_offset(0);
            make.right.mas_equalTo(self.goImageView.mas_right).mas_offset(0);
        }];
        
        [_topView addSubview:self.changHeadImageBtn];
        [_changHeadImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(_topView).mas_offset(0);
            make.bottom.mas_equalTo(self.lineView.mas_bottom).mas_offset(0);
        }];
    }
    return _topView;
}

-(UIButton *)changHeadImageBtn{
    if (!_changHeadImageBtn) {
        _changHeadImageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _changHeadImageBtn;
}

-(UIButton *)changPsdBtn{
    if (!_changPsdBtn) {
        _changPsdBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _changPsdBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _lineView;
}

-(UIImageView *)goImageView{
    if (!_goImageView) {
        _goImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _goImageView;
}

-(UIImageView *)changPsdGoImageView{
    if (!_changPsdGoImageView) {
        _changPsdGoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _changPsdGoImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#777777"];
    }
    return _nameLabel;
}

-(UILabel *)nameTipLabel{
    if (!_nameTipLabel) {
        _nameTipLabel = [[UILabel alloc] init];
        _nameTipLabel.font = [UIFont systemFontOfSize:14];
        _nameTipLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        _nameTipLabel.text = @"用户名";
    }
    return _nameTipLabel;
}

-(UILabel *)changPsdLabel{
    if (!_changPsdLabel) {
        _changPsdLabel = [[UILabel alloc] init];
        _changPsdLabel.font = [UIFont systemFontOfSize:14];
        _changPsdLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        _changPsdLabel.text = @"修改密码";
    }
    return _changPsdLabel;
}

-(UILabel *)headTipLabel{
    if (!_headTipLabel) {
        _headTipLabel = [[UILabel alloc] init];
        _headTipLabel.font = [UIFont systemFontOfSize:14];
        _headTipLabel.textColor = [UIColor colorWithHexString:@"#282828"];
        _headTipLabel.text = @"头像";
    }
    return _headTipLabel;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 60/2;
    }
    return _headImageView;
}

-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.srcfile] placeholderImage:[UIImage imageNamed:@"userDefault"]];
    self.nameLabel.text = userModel.account;
}

@end
