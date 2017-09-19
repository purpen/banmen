//
//  THNTipLoginView.m
//  banmen
//
//  Created by dong on 2017/9/11.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNTipLoginView.h"
#import "UIColor+Extension.h"
#import "Masonry.h"
#import "OtherMacro.h"

@implementation THNTipLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        
        [self addSubview:self.showView];
        [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self).mas_offset(0);
            make.width.mas_equalTo(200/667.0*SCREEN_HEIGHT);
            make.height.mas_equalTo(100/667.0*SCREEN_HEIGHT);
        }];
    }
    return self;
}

-(UIView *)showView{
    if (!_showView) {
        _showView = [UIView new];
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 3;
        
        _showView.backgroundColor = [UIColor whiteColor];
        
        [_showView addSubview:self.tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_showView.center);
        }];
    }
    return _showView;
}

-(UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor colorWithHexString:@"be8914" alpha:1];
        _tipLabel.text = @"请点击个人中心登录";
    }
    return _tipLabel;
}

@end
