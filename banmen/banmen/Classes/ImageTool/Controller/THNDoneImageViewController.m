//
//  THNDoneImageViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/23.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNDoneImageViewController.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface THNDoneImageViewController ()

@property (nonatomic, strong) UIButton *hintText;
@property (nonatomic, strong) UIButton *backHomeButton;
@property (nonatomic, strong) UIButton *againButton;
@property (nonatomic, strong) UIButton *shareButton;

@end

@implementation THNDoneImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_setControllerViewUI];
}

#pragma mark - 设置视图
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.againButton];
    [_againButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 40));
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_centerY).with.offset(0);
    }];
    
    [self.view addSubview:self.backHomeButton];
    [_backHomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 44));
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.top.equalTo(self.view.mas_top).with.offset(20);
    }];
    
    [self.view addSubview:self.hintText];
    [_hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 20));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.againButton.mas_top).with.offset(-15);
    }];
    
    [self.view addSubview:self.shareButton];
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark - 提示文字
- (UIButton *)hintText {
    if (!_hintText) {
        _hintText = [[UIButton alloc] init];
        [_hintText setTitle:@"已保存到相册" forState:(UIControlStateNormal)];
        [_hintText setTitleColor:[UIColor colorWithHexString:kColorWhite] forState:(UIControlStateNormal)];
        _hintText.titleLabel.font = [UIFont systemFontOfSize:16];
        [_hintText setImage:[UIImage imageNamed:@"icon_done_selected"] forState:(UIControlStateNormal)];
        [_hintText setTitleEdgeInsets:(UIEdgeInsetsMake(0, 10, 0, 0))];
    }
    return _hintText;
}


#pragma mark - 返回首页
- (UIButton *)backHomeButton {
    if (!_backHomeButton) {
        _backHomeButton = [[UIButton alloc] init];
        [_backHomeButton setTitle:@"首页" forState:(UIControlStateNormal)];
        [_backHomeButton setTitleColor:[UIColor colorWithHexString:kColorWhite] forState:(UIControlStateNormal)];
        _backHomeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_backHomeButton addTarget:self action:@selector(backHomeButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_backHomeButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    }
    return _backHomeButton;
}

- (void)backHomeButtonClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 再做一张
- (UIButton *)againButton {
    if (!_againButton) {
        _againButton = [[UIButton alloc] init];
        [_againButton setTitle:@"再做一张" forState:(UIControlStateNormal)];
        [_againButton setTitleColor:[UIColor colorWithHexString:kColorWhite] forState:(UIControlStateNormal)];
        _againButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _againButton.layer.cornerRadius = 4;
        _againButton.layer.borderColor = [UIColor colorWithHexString:kColorWhite].CGColor;
        _againButton.layer.borderWidth = 0.5;
        [_againButton addTarget:self action:@selector(againButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _againButton;
}

- (void)againButtonClick:(UIButton *)button {
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"歇一歇吧～\n\n_(:_」∠)_"];
}

#pragma mark - 分享
- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] init];
        [_shareButton setTitle:@"分享" forState:(UIControlStateNormal)];
        [_shareButton setTitleColor:[UIColor colorWithHexString:kColorWhite] forState:(UIControlStateNormal)];
        _shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _shareButton.backgroundColor = [UIColor colorWithHexString:kColorGreen];
        [_shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _shareButton;
}

- (void)shareButtonClick:(UIButton *)button {
    [self systemShareWithImage:self.doneImage];
}

- (void)systemShareWithImage:(UIImage *)image {
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:image, nil] applicationActivities:nil];
    [self presentViewController:activityController animated:true completion:nil];
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"分享";
}

@end
