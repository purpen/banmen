//
//  THNEditToolButton.h
//  banmen
//
//  Created by FLYang on 2017/7/5.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNEditToolButton : UIView

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 图标
 */
@property (nonatomic, copy) UIImage *iconImage;

/**
 功能按钮
 */
@property (nonatomic, strong) UIButton *editButton;

- (void)enableClick;

- (void)disableClick;

@end
