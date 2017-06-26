//
//  BaseTarBarViewController.m
//  banmen
//
//  Created by dong on 2017/6/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "BaseTarBarViewController.h"
#import "UIColor+Extension.h"
#import "HomeViewController.h"
#import "PostersViewController.h"
#import "RepositoryViewController.h"
#import "UserViewController.h"
#import "BaseTarBar.h"
#import "BaseNavController.h"

@interface BaseTarBarViewController ()

@end

@implementation BaseTarBarViewController

+ (BaseTarBarViewController *)sharedManager
{
    static BaseTarBarViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#666666"];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#222222"];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self setupChildVc:[[HomeViewController alloc] init] title:@"首页" image:@"home" selectedImage:@"home_selected"];
    
    [self setupChildVc:[[RepositoryViewController alloc] init] title:@"资源库" image:@"media" selectedImage:@"media_selected"];
    
    [self setupChildVc:[[PostersViewController alloc] init] title:@"海报" image:@"found" selectedImage:@"found_selected"];
    
    [self setupChildVc:[[UserViewController alloc] init] title:@"我的" image:@"me" selectedImage:@"me_selected"];
    
    // 更换tabBar
    [self setValue:[[BaseTarBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
