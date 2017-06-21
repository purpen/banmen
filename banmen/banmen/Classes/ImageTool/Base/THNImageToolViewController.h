//
//  THNImageToolViewController.h
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THNImageToolNavigationBarItemsDelegate <NSObject>

@optional
- (void)thn_leftBarItemSelected;
- (void)thn_rightBarItemSelected;

@end

@interface THNImageToolViewController : UIViewController

@property (nonatomic, strong) UIView   *navView;        //  Nav视图
@property (nonatomic, strong) UILabel  *navTitle;       //  控制器标题
@property (nonatomic, strong) UIButton *navCloseButton; //  关闭按钮
@property (nonatomic, strong) UIButton *navBackButton;  //  返回按钮
@property (nonatomic, strong) UIButton *navLeftItem;    //  ligthItem
@property (nonatomic, strong) UIButton *navRightItem;   //  rightItem

- (void)thn_addNavCloseButton;

/*
 *  在Nav上添加返回按钮
 */
- (void)thn_addNavBackButton;

/*
 *  在Nav上添加leftItem
 */
- (void)thn_addBarItemLeftBarButton:(NSString *)title image:(NSString *)image;

/*
 *  在Nav上添加rightItem
 */
- (void)thn_addBarItemRightBarButton:(NSString *)title image:(NSString *)image;

/**
 *  提示语
 */
- (void)thn_showMessage:(NSString *)message;

/**
 *  navigationItem代理点击事件
 */
@property (nonatomic, weak) id <THNImageToolNavigationBarItemsDelegate> delegate;

@end
