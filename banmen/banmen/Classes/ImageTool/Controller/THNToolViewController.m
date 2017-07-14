//
//  THNToolViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNToolViewController.h"
#import "THNLayoutViewController.h"
#import "THNImageToolNavigationController.h"

@interface THNToolViewController ()

@property (nonatomic, strong) UIButton *puzzleButton;

@end

@implementation THNToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.puzzleButton];
}

- (UIButton *)puzzleButton {
    if (!_puzzleButton) {
        _puzzleButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 200, SCREEN_WIDTH - 30, 120)];
        [_puzzleButton setTitle:@"拼图" forState:(UIControlStateNormal)];
        _puzzleButton.backgroundColor = [UIColor orangeColor];
        [_puzzleButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _puzzleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _puzzleButton.layer.cornerRadius = 5;
        [_puzzleButton addTarget:self action:@selector(puzzleButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _puzzleButton;
}

- (void)puzzleButtonClick:(UIButton *)button {
    [self thn_initImageToolViewController];
}

- (void)thn_initImageToolViewController {
    THNLayoutViewController *imageLayoutController = [[THNLayoutViewController alloc] init];
    THNImageToolNavigationController *imageToolNavController = [[THNImageToolNavigationController alloc] initWithRootViewController:imageLayoutController];
    [self presentViewController:imageToolNavController animated:YES completion:nil];
}

@end
