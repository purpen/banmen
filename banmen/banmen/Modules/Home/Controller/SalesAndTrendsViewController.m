//
//  SalesAndTrendsViewController.m
//  banmen
//
//  Created by dong on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesAndTrendsViewController.h"

@interface SalesAndTrendsViewController ()
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation SalesAndTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置顶部的标签栏
    [self setupTitlesView];
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor banmenColorWithRed:248 green:248 blue:248 alpha:1];
    titlesView.width = self.view.width;
    titlesView.height = XMGTitilesViewH;
    titlesView.y =XMGTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    NSArray *tittleAry = @[@"销售额", @"销售客单价", @"地域分布", @"TOP20标签"];
    
    // 内部的子标签
    CGFloat width = titlesView.width / tittleAry.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<tittleAry.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:tittleAry[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor colorWithHexString:@"#0076ff"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#0076ff"] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
        }
    }
}

- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
}


@end
