//
//  AppDelegate.h
//  banmen
//
//  Created by FLYang on 2017/6/15.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

