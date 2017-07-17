//
//  THNJointViewController.m
//  banmen
//
//  Created by FLYang on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNJointViewController.h"
#import "UIColor+Extension.h"
#import "MainMacro.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface THNJointViewController () <
    THNImageToolNavigationBarItemsDelegate
>

@end

@implementation THNJointViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"拼接";
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    [self thn_saveDoneJointImage];
}

#pragma mark 保存图片
- (void)thn_saveDoneJointImage {
    [SVProgressHUD showSuccessWithStatus:@"拼接图片完成"];
}

@end
