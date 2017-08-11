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
#import "THNShareActionView.h"

@interface THNDoneImageViewController ()

@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) UIButton *hintText;
@property (nonatomic, strong) UIButton *backHomeButton;
@property (nonatomic, strong) UIButton *againButton;
@property (nonatomic, strong) THNShareActionView *shareView;

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
    [self.view addSubview:self.previewImageView];
    [_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.centerX.equalTo(self.view);
    }];
    
    [self.view addSubview:self.hintText];
    [_hintText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 25));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_previewImageView.mas_bottom).with.offset(30);
    }];
    
    [self.view addSubview:self.againButton];
    [_againButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 40));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_hintText.mas_bottom).with.offset(15);
    }];
    
    [self.view addSubview:self.backHomeButton];
    [_backHomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.right.equalTo(self.view.mas_right).with.offset(-15);
        make.top.equalTo(self.view.mas_top).with.offset(20);
    }];
    
    [self.view addSubview:self.shareView];
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 130));
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.centerX.equalTo(self.view);
    }];
    
    [self thn_loadPreviewImageAndScale:self.doneImage];
}

#pragma mark - 预览图片
- (UIImageView *)previewImageView {
    if (!_previewImageView) {
        _previewImageView = [[UIImageView alloc] init];
        _previewImageView.contentMode = UIViewContentModeScaleAspectFill;
        _previewImageView.clipsToBounds = YES;
    }
    return _previewImageView;
}

//  加载图片并缩放
- (void)thn_loadPreviewImageAndScale:(UIImage *)image {
    if (image == nil) {
        [SVProgressHUD showInfoWithStatus:@"获取图片错误"];
        return;
    }
    CGFloat scaleNum = (SCREEN_WIDTH - 60) / image.size.height;
    CGFloat imageViewWidth = self.doneImage.size.width * scaleNum;
    CGFloat imageViewHeight = self.doneImage.size.height * scaleNum;
    
    [_previewImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageViewWidth, imageViewHeight));
    }];
    
    self.previewImageView.image = image;
}

#pragma mark - 提示文字
- (UIButton *)hintText {
    if (!_hintText) {
        _hintText = [[UIButton alloc] init];
        [_hintText setTitle:@"已保存到相册" forState:(UIControlStateNormal)];
        [_hintText setTitleColor:[UIColor colorWithHexString:kColorWhite] forState:(UIControlStateNormal)];
        _hintText.titleLabel.font = [UIFont systemFontOfSize:16];
        [_hintText setImage:[UIImage imageNamed:@"icon_done_photo"] forState:(UIControlStateNormal)];
        [_hintText setImageEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, 105))];
        [_hintText setTitleEdgeInsets:(UIEdgeInsetsMake(0, -24, 0, 0))];
        _hintText.userInteractionEnabled = NO;
    }
    return _hintText;
}

#pragma mark - 返回首页
- (UIButton *)backHomeButton {
    if (!_backHomeButton) {
        _backHomeButton = [[UIButton alloc] init];
        [_backHomeButton setTitle:@"返回首页" forState:(UIControlStateNormal)];
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
        _againButton.layer.cornerRadius = 3;
        _againButton.backgroundColor = [UIColor colorWithHexString:@"#3E4044"];
        [_againButton addTarget:self action:@selector(againButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _againButton;
}

- (void)againButtonClick:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 分享
- (THNShareActionView *)shareView {
    if (!_shareView) {
        _shareView = [[THNShareActionView alloc] init];
        [_shareView thn_showShareViewController:self messageObject:[self shareMessageObject] shareImage:self.doneImage];
    }
    return _shareView;
}

#pragma mark - 创建分享消息对象
- (UMSocialMessageObject *)shareMessageObject {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    shareObject.shareImage = self.doneImage;
    messageObject.shareObject = shareObject;
    return messageObject;
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"分享";
}

@end
