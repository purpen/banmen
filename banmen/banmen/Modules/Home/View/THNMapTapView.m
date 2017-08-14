//
//  THNMapTapView.m
//  banmen
//
//  Created by dong on 2017/8/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNMapTapView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"

@implementation THNMapTapView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self).mas_offset(0);
        }];
    }
    return self;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame"]];
        
        [_imageView addSubview:self.areaNameLabel];
        [_areaNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_imageView.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(_imageView.mas_top).mas_offset(4);
        }];
        
        [_imageView addSubview:self.salesLabel];
        [_salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_imageView.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.areaNameLabel.mas_bottom).mas_offset(4);
        }];
        
        [_imageView addSubview:self.accountedLabel];
        [_accountedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_imageView.mas_centerX).mas_offset(0);
            make.top.mas_equalTo(self.salesLabel.mas_bottom).mas_offset(2);
        }];
    }
    return _imageView;
}

-(UILabel *)areaNameLabel{
    if (!_areaNameLabel) {
        _areaNameLabel = [[UILabel alloc] init];
        _areaNameLabel.font = [UIFont systemFontOfSize:9];
        _areaNameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _areaNameLabel;
}

-(UILabel *)salesLabel{
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc] init];
        _salesLabel.font = [UIFont systemFontOfSize:9];
        _salesLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _salesLabel.numberOfLines = 2;
        _salesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _salesLabel;
}

-(UILabel *)accountedLabel{
    if (!_accountedLabel) {
        _accountedLabel = [[UILabel alloc] init];
        _accountedLabel.font = [UIFont systemFontOfSize:9];
        _accountedLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        _accountedLabel.numberOfLines = 2;
        _accountedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accountedLabel;
}

@end
