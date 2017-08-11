//
//  UserView.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UserView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "UIImageView+WebCache.h"

@implementation UserView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        
        [self addSubview:self.topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.mas_top).mas_offset(10);
            make.height.mas_equalTo(310/2);
        }];
        
        [self addSubview:self.middleView];
        [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(8);
            make.height.mas_equalTo(88/2*3);
        }];
        
        [self addSubview:self.logOutBtn];
        [_logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self.middleView.mas_bottom).mas_offset(30);
            make.height.mas_equalTo(44);
        }];
    }
    return self;
}

-(UIButton *)updatePersonalInformationBtn{
    if (!_updatePersonalInformationBtn) {
        _updatePersonalInformationBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _updatePersonalInformationBtn;
}

-(UIButton *)aboutBtn{
    if (!_aboutBtn) {
        _aboutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _aboutBtn;
}

-(UIButton *)adjustBtn{
    if (!_adjustBtn) {
        _adjustBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _adjustBtn;
}

-(UIButton *)welcomeBtn{
    if (!_welcomeBtn) {
        _welcomeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _welcomeBtn;
}

-(UIButton *)logOutBtn{
    if (!_logOutBtn) {
        _logOutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_logOutBtn setTitle:@"退出登录" forState:(UIControlStateNormal)];
        _logOutBtn.backgroundColor = [UIColor whiteColor];
        [_logOutBtn setTitleColor:[UIColor colorWithHexString:@"#BE8914"] forState:(UIControlStateNormal)];
    }
    return _logOutBtn;
}

-(UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor whiteColor];
        
        [_middleView addSubview:self.onelineView];
        [_onelineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.top.mas_equalTo(_middleView.mas_top).mas_offset(0);
            make.height.mas_equalTo(1);
        }];
        
        [_middleView addSubview:self.twolineView];
        [_twolineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.top.mas_equalTo(_middleView.mas_top).mas_offset(43);
            make.height.mas_equalTo(1);
        }];
        
        [_middleView addSubview:self.threelineView];
        [_threelineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.bottom.mas_equalTo(self.twolineView.mas_bottom).mas_offset(44);
            make.height.mas_equalTo(1);
        }];
        
        [_middleView addSubview:self.fourlineView];
        [_fourlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.bottom.mas_equalTo(self.threelineView.mas_bottom).mas_offset(44);
            make.height.mas_equalTo(1);
        }];
        
        [_middleView addSubview:self.aboutLabel];
        [_aboutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_middleView.mas_left).mas_offset(15);
            make.top.mas_equalTo(_middleView.mas_top).mas_offset(14);
        }];
        
        [_middleView addSubview:self.onegoImageView];
        [_onegoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_middleView.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.aboutLabel.mas_centerY).mas_offset(0);
        }];
        
        [_middleView addSubview:self.adjustLabel];
        [_adjustLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_middleView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.twolineView.mas_top).mas_offset(14);
        }];
        
        [_middleView addSubview:self.twogoImageView];
        [_twogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_middleView.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.adjustLabel.mas_centerY).mas_offset(0);
        }];
        
        [_middleView addSubview:self.welcomeLabel];
        [_welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_middleView.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.threelineView.mas_top).mas_offset(14);
        }];
        
        [_middleView addSubview:self.threegoImageView];
        [_threegoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_middleView.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.welcomeLabel.mas_centerY).mas_offset(0);
        }];
        
        [_middleView addSubview:self.aboutBtn];
        [_aboutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(_middleView).mas_offset(0);
            make.bottom.mas_equalTo(self.twolineView.mas_bottom).mas_offset(0);
        }];
        
        [_middleView addSubview:self.adjustBtn];
        [_adjustBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.top.mas_equalTo(self.twolineView.mas_bottom).mas_offset(0);
            make.bottom.mas_equalTo(self.threelineView.mas_bottom).mas_offset(0);
        }];
        
        [_middleView addSubview:self.welcomeBtn];
        [_welcomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_middleView).mas_offset(0);
            make.top.mas_equalTo(self.threelineView.mas_top).mas_offset(0);
            make.bottom.mas_equalTo(self.fourlineView.mas_top).mas_offset(0);
        }];
    }
    return _middleView;
}

-(UIView *)threelineView{
    if (!_threelineView) {
        _threelineView = [[UIView alloc] init];
        _threelineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _threelineView;
}

-(UIView *)fourlineView{
    if (!_fourlineView) {
        _fourlineView = [[UIView alloc] init];
        _fourlineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _fourlineView;
}

-(UIView *)twolineView{
    if (!_twolineView) {
        _twolineView = [[UIView alloc] init];
        _twolineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _twolineView;
}

-(UIView *)onelineView{
    if (!_onelineView) {
        _onelineView = [[UIView alloc] init];
        _onelineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _onelineView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        
        [_topView addSubview:self.headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_topView.mas_left).mas_offset(15);
            make.top.mas_equalTo(_topView.mas_top).mas_offset(12);
            make.width.height.mas_equalTo(60);
        }];
        
        [_topView addSubview:self.nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(10);
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
        
        [_topView addSubview:self.goodLabel];
        [_goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_topView.mas_left).mas_offset(86/2);
            make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(15);
        }];
        
        [_topView addSubview:self.goodCountLabel];
        [_goodCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.goodLabel.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.goodLabel.mas_bottom).mas_offset(5);
        }];
        
        [_topView addSubview:self.salesLabel];
        [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_topView.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.goodLabel.mas_top).mas_offset(0);
        }];
        
        [_topView addSubview:self.salesCountLabel];
        [_salesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.salesLabel.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.salesLabel.mas_bottom).mas_offset(5);
        }];
        
        [_topView addSubview:self.orderLabel];
        [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_topView.mas_right).mas_offset(-86/2);
            make.top.mas_equalTo(self.goodLabel.mas_top).mas_offset(0);
        }];
        
        [_topView addSubview:self.orderCountLabel];
        [_orderCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.orderLabel.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.orderLabel.mas_bottom).mas_offset(5);
        }];
        
        [_topView addSubview:self.updatePersonalInformationBtn];
        [_updatePersonalInformationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(_topView).mas_offset(0);
            make.bottom.mas_equalTo(self.lineView.mas_bottom).mas_offset(0);
        }];
    }
    return _topView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#e2e2e2"];
    }
    return _lineView;
}

-(UILabel *)aboutLabel{
    if (!_aboutLabel) {
        _aboutLabel = [[UILabel alloc] init];
        _aboutLabel.font = [UIFont systemFontOfSize:14];
        _aboutLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _aboutLabel.text = @"关于我们";
    }
    return _aboutLabel;
}

-(UILabel *)adjustLabel{
    if (!_adjustLabel) {
        _adjustLabel = [[UILabel alloc] init];
        _adjustLabel.font = [UIFont systemFontOfSize:14];
        _adjustLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _adjustLabel.text = @"意见反馈";
    }
    return _adjustLabel;
}

-(UILabel *)welcomeLabel{
    if (!_welcomeLabel) {
        _welcomeLabel = [[UILabel alloc] init];
        _welcomeLabel.font = [UIFont systemFontOfSize:14];
        _welcomeLabel.textColor = [UIColor colorWithHexString:@"#222222"];
        _welcomeLabel.text = @"查看欢迎页";
    }
    return _welcomeLabel;
}

-(UILabel *)goodLabel{
    if (!_goodLabel) {
        _goodLabel = [[UILabel alloc] init];
        _goodLabel.font = [UIFont systemFontOfSize:14];
        _goodLabel.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
        _goodLabel.text = @"合作产品";
    }
    return _goodLabel;
}

-(UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = [UIFont systemFontOfSize:14];
        _orderLabel.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
        _orderLabel.text = @"订单数";
    }
    return _orderLabel;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.font = [UIFont systemFontOfSize:14];
        _salesLabel.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
        _salesLabel.text = @"销售额";
    }
    return _salesLabel;
}

-(UILabel *)goodCountLabel{
    if (!_goodCountLabel) {
        _goodCountLabel = [[UILabel alloc] init];
        _goodCountLabel.font = [UIFont systemFontOfSize:15];
        _goodCountLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    }
    return _goodCountLabel;
}

-(UILabel *)orderCountLabel{
    if (!_orderCountLabel) {
        _orderCountLabel = [[UILabel alloc] init];
        _orderCountLabel.font = [UIFont systemFontOfSize:15];
        _orderCountLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    }
    return _orderCountLabel;
}

-(UILabel *)salesCountLabel{
    if (!_salesCountLabel) {
        _salesCountLabel = [[UILabel alloc] init];
        _salesCountLabel.font = [UIFont systemFontOfSize:15];
        _salesCountLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    }
    return _salesCountLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    }
    return _nameLabel;
}

-(UIImageView *)onegoImageView{
    if (!_onegoImageView) {
        _onegoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _onegoImageView;
}

-(UIImageView *)threegoImageView{
    if (!_threegoImageView) {
        _threegoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _threegoImageView;
}

-(UIImageView *)twogoImageView{
    if (!_twogoImageView) {
        _twogoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _twogoImageView;
}

-(UIImageView *)goImageView{
    if (!_goImageView) {
        _goImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];
    }
    return _goImageView;
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
    self.goodCountLabel.text = userModel.cooperation_count;
    self.salesCountLabel.text = userModel.sales_volume;
    self.orderCountLabel.text = userModel.order_quantity;
}

@end
