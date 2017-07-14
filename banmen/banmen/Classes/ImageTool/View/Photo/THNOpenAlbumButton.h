//
//  THNOpenAlbumButton.h
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THNOpenAlbumButtonClickDelegate <NSObject>

@optional
- (void)thn_albumButtonTouchUpInside:(UIButton *)button;

@end

@interface THNOpenAlbumButton : UIButton

/**
 标题
 */
@property (nonatomic, strong) UILabel *nameLabel;

/**
 下拉标志icon
 */
@property (nonatomic, strong) UIImageView *icon;

/**
 设置按钮的名称&图标
 
 @param text 名称
 @param imageName 图标名称
 */
- (void)thn_setButtonTitleText:(NSString *)text iconImage:(NSString *)imageName;

/**
 按钮点击的代理
 */
@property (nonatomic, weak) id <THNOpenAlbumButtonClickDelegate> delegate;

/**
 使按钮的图标旋转
 
 @param rotate 是否旋转
 */
- (void)thn_rotateButtonIcon:(BOOL)rotate;

@end
