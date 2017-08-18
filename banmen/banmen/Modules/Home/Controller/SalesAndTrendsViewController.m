//
//  SalesAndTrendsViewController.m
//  banmen
//
//  Created by dong on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesAndTrendsViewController.h"
#import "SalesViewController.h"
#import "UnitPriceViewController.h"
#import "AreaViewController.h"
#import "TopViewController.h"
#import "SalesChannelsViewController.h"
#import "UIColor+Extension.h"
#import "Masonry.h"

@interface SalesAndTrendsViewController ()<UIScrollViewDelegate>
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation SalesAndTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化子控制器
    [self setupChildVces];
    // 设置顶部的标签栏
    [self setupTitlesView];
    // 底部的scrollView
    [self setupContentView];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    SalesViewController *salesVC = [[SalesViewController alloc] init];
    salesVC.title = @"销售额";
    salesVC.type = sale;
    [self addChildViewController:salesVC];
    
    SalesChannelsViewController *channelVC = [[SalesChannelsViewController alloc] init];
    channelVC.title = @"销售渠道";
    channelVC.type = channel;
    [self addChildViewController:channelVC];
    
    UnitPriceViewController *priceVC = [[UnitPriceViewController alloc] init];
    priceVC.title = @"销售客单价";
    priceVC.type = unitPrice;
    [self addChildViewController:priceVC];
    
    AreaViewController *areaVC = [[AreaViewController alloc] init];
    areaVC.title = @"地域分布";
    areaVC.type = regional;
    [self addChildViewController:areaVC];
    
    TopViewController *topVC = [[TopViewController alloc] init];
    topVC.title = @"TOP20标签";
    topVC.type = top;
    [self addChildViewController:topVC];
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [titlesView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(titlesView).mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
    [titlesView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(titlesView).mas_offset(0);
        make.height.mas_equalTo(1);
    }];
    titlesView.width = self.view.width;
    titlesView.height = 35+2;
    titlesView.y =XMGTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor colorWithHexString:@"#686868"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:kColorDefalut] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
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
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.scrollEnabled = NO;
    contentView.frame = CGRectMake(0, self.titlesView.y+self.titlesView.height, SCREEN_WIDTH, SCREEN_HEIGHT-contentView.y-30);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
