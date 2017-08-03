//
//  THNKeyboardToolView.h
//  banmen
//
//  Created by FLYang on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THNKeyboardToolViewDelegate <NSObject>

@optional
- (void)thn_writeInputBoxResignFirstResponder;
- (void)thn_writeInputBoxChangeTextColor;

@end

@interface THNKeyboardToolView : UIView

/**
 改变字体颜色
 */
@property (nonatomic, strong) UIButton *changeTextColor;

/**
 字体样式
 */
@property (nonatomic, strong) UIButton *fontStyle;

/**
 字体样式
 */
@property (nonatomic, strong) UIButton *fontSize;

/**
 关闭键盘
 */
@property (nonatomic, strong) UIButton *closeKeybord;

@property (nonatomic, weak) id <THNKeyboardToolViewDelegate> delegate;

/**
 开启键盘拓展功能
 
 @param hidden 开启
 */
- (void)thn_setHiddenExtendingFunction:(BOOL)hidden;

@end
