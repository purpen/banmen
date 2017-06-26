//
//  THNEditImageViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditImageViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIColor+Extension.h"
#import "MainMacro.h"

#import "THNDoneImageViewController.h"

@interface THNEditImageViewController () <
    THNImageToolNavigationBarItemsDelegate
>

@end

@implementation THNEditImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"编辑";
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    THNDoneImageViewController *doneController = [[THNDoneImageViewController alloc] init];
    [self.navigationController pushViewController:doneController animated:YES];
}

@end
