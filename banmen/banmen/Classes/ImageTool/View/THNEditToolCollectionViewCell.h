//
//  THNEditToolCollectionViewCell.h
//  banmen
//
//  Created by FLYang on 2017/7/5.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNEditToolCollectionViewCell : UICollectionViewCell

/**
 标题
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 图标
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 背景
 */
@property (nonatomic, strong) UIView *backView;

/**
 加载图像工具显示内容
 
 @param title 标题
 @param icon 图标
 */
- (void)thn_setEditImageToolTitle:(NSString *)title withIcon:(NSString *)icon ;

@end
