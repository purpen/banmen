//
//  AppDelegate+Guide.m
//  banmen
//
//  Created by dong on 2017/6/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "AppDelegate+Guide.h"
#import "BaseTarBarViewController.h"
#import "GuidePageViewController.h"

@implementation AppDelegate (Guide)

-(void)windowShow{
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    NSArray *arr = [NSArray arrayWithObjects:@"01",@"02",@"03",@"04", nil];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        GuidePageViewController *vc = [[GuidePageViewController alloc] initWithPicArr:arr andRootVC:[BaseTarBarViewController sharedManager]];
        vc.flag = shouYe;
        self.window.rootViewController = vc;

        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        self.window.rootViewController = [BaseTarBarViewController sharedManager];
    }
    [self.window makeKeyAndVisible];
}

@end
