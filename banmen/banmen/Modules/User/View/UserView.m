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
        
    }
    return self;
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
        
    }
    return _topView;
}

-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 60/2;
    }
    return _headImageView;
}

@end
