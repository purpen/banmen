//
//  THNImageToolViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNImageToolViewController.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNImageToolViewController ()

@end

@implementation THNImageToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_initViewControllerUI];
}

#pragma mark - 初始化主视图
- (void)thn_initViewControllerUI {
    self.view.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    [self thn_initViewControllerNavViewUI];
}

#pragma mark - 初始化Nav视图
- (void)thn_initViewControllerNavViewUI {
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navTitle];
    [self thn_addNavBackButton];
}

#pragma mark Nav视图
- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        _navView.backgroundColor = [UIColor colorWithHexString:kColorNavView];
//        _navView.backgroundColor = [UIColor redColor];
    }
    return _navView;
}

- (UILabel *)navTitle {
    if (!_navTitle) {
        _navTitle = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, SCREEN_WIDTH - 120, 44)];
        _navTitle.textColor = [UIColor whiteColor];
        _navTitle.font = [UIFont boldSystemFontOfSize:16];
        _navTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _navTitle;
}

#pragma mark 返回按钮
- (UIButton *)navBackButton {
    if (!_navBackButton) {
        _navBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_navBackButton setImage:[UIImage imageNamed:@"icon_back_white"] forState:(UIControlStateNormal)];
        [_navBackButton addTarget:self action:@selector(popViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navBackButton;
}

- (void)popViewController {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)thn_addNavBackButton {
    if ([self.navigationController viewControllers].count > 1) {
        [self.navView addSubview:self.navBackButton];
    }
}

#pragma mark 关闭按钮
- (UIButton *)navCloseButton {
    if (!_navCloseButton) {
        _navCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_navCloseButton setImage:[UIImage imageNamed:@"icon_close_white"] forState:(UIControlStateNormal)];
        [_navCloseButton addTarget:self action:@selector(closeViewController) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navCloseButton;
}

- (void)closeViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)thn_addNavCloseButton {
    [self.navView addSubview:self.navCloseButton];
}

#pragma mark Nav左边按钮
- (UIButton *)navLeftItem {
    if (!_navLeftItem) {
        _navLeftItem = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 44, 44)];
        [_navLeftItem addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _navLeftItem;
}

- (void)leftAction {
    if ([self.delegate respondsToSelector:@selector(thn_leftBarItemSelected)]) {
        [self.delegate thn_leftBarItemSelected];
    }
}

#pragma mark Nav右边按钮
- (UIButton *)navRightItem {
    if (!_navRightItem) {
        _navRightItem = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 54, 20, 44, 44)];
        [_navRightItem addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_navRightItem setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _navRightItem.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _navRightItem;
}

- (void)rightAction {
    if ([self.delegate respondsToSelector:@selector(thn_rightBarItemSelected)]) {
        [self.delegate thn_rightBarItemSelected];
    }
}

#pragma mark - 设置操作控件
- (void)thn_addBarItemLeftBarButton:(NSString *)title image:(NSString *)image {
    if (image.length > 0) {
        [self.navLeftItem setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
        [self.navView addSubview:self.navLeftItem];
        return;
    }
}

- (void)thn_addBarItemRightBarButton:(NSString *)title image:(NSString *)image {
    if (image.length > 0 && title.length == 0) {
        [self.navRightItem setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
        self.navRightItem.frame = CGRectMake(SCREEN_WIDTH - 44, 20, 44, 44);
        [self.navView addSubview:self.navRightItem];
        return;
    }
    
    //  如果设置按钮为“纯文字”
    [self.navRightItem setTitle:title forState:UIControlStateNormal];
    CGFloat buttonWidth = [title boundingRectWithSize:CGSizeMake(320, 44) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:nil context:nil].size.width *1.5;
    self.navRightItem.frame = CGRectMake(SCREEN_WIDTH - buttonWidth - 10, 20, buttonWidth, 44);
    [self.navView addSubview:self.navRightItem];
}

#pragma mark - 显示文字状态提示
- (void)thn_showMessage:(NSString *)message {
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    [showview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200,44));
        make.bottom.equalTo(window.mas_bottom).with.offset(-100);
        make.centerX.equalTo(window);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0 , 200, 44)];
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    [showview addSubview:label];
    
    [UIView animateWithDuration:2.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

#pragma mark - 设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
