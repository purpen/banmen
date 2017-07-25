//
//  THNToolViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNToolViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import "THNLayoutViewController.h"
#import "THNImageToolNavigationController.h"
#import "THNPosterListViewController.h"

@interface THNToolViewController ()

@property (nonatomic, strong) UIButton *puzzleButton;
@property (nonatomic, strong) UIButton *posterButton;

@end

@implementation THNToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.puzzleButton];
    [self.view addSubview:self.posterButton];
}

#pragma mark - 海报模版按钮
- (UIButton *)posterButton {
    if (!_posterButton) {
        _posterButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 150)];
        [_posterButton setTitle:@"海报模版" forState:(UIControlStateNormal)];
        [_posterButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _posterButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_posterButton setTitleEdgeInsets:(UIEdgeInsetsMake(50, -60, 0, 0))];
        [_posterButton setBackgroundImage:[UIImage imageNamed:@"bg_tool_poster"] forState:(UIControlStateNormal)];
        [_posterButton setImage:[UIImage imageNamed:@"icon_poster"] forState:(UIControlStateNormal)];
        [_posterButton setImageEdgeInsets:(UIEdgeInsetsMake(40, (SCREEN_WIDTH - 70)/2, 70, (SCREEN_WIDTH - 70)/2))];
        _posterButton.layer.cornerRadius = 5;
        [_posterButton addTarget:self action:@selector(posterButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _posterButton;
}

- (void)posterButtonClick:(UIButton *)button {
    [self thn_openPosterListViewController];
}

- (void)thn_openPosterListViewController {
    THNPosterListViewController *posterController = [[THNPosterListViewController alloc] init];
    [self.navigationController pushViewController:posterController animated:YES];
}

#pragma mark - 拼图拼接按钮
- (UIButton *)puzzleButton {
    if (!_puzzleButton) {
        _puzzleButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 180, SCREEN_WIDTH - 30, 150)];
        [_puzzleButton setTitle:@"拼图拼接" forState:(UIControlStateNormal)];
        [_puzzleButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _puzzleButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_puzzleButton setTitleEdgeInsets:(UIEdgeInsetsMake(50, -60, 0, 0))];
        [_puzzleButton setBackgroundImage:[UIImage imageNamed:@"bg_tool_photo"] forState:(UIControlStateNormal)];
        [_puzzleButton setImage:[UIImage imageNamed:@"icon_photo"] forState:(UIControlStateNormal)];
        [_puzzleButton setImageEdgeInsets:(UIEdgeInsetsMake(40, (SCREEN_WIDTH - 70)/2, 70, (SCREEN_WIDTH - 70)/2))];
        _puzzleButton.layer.cornerRadius = 5;
        [_puzzleButton addTarget:self action:@selector(puzzleButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _puzzleButton;
}

- (void)puzzleButtonClick:(UIButton *)button {
    [self thn_openImageToolViewController];
}

#pragma mark - 打开拼图工具视图
- (void)thn_openImageToolViewController {
    THNLayoutViewController *imageLayoutController = [[THNLayoutViewController alloc] init];
    THNImageToolNavigationController *imageToolNavController = [[THNImageToolNavigationController alloc] initWithRootViewController:imageLayoutController];
    [self presentViewController:imageToolNavController animated:YES completion:nil];
}

@end
