//
//  THNHintInfoView.h
//  banmen
//
//  Created by FLYang on 2017/6/22.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNHintInfoView : UIView

/**
 提示文字
 */
@property (nonatomic, strong) UILabel *textLabel;

/**
 提示图标
 */
@property (nonatomic, strong) UIImageView *iconImageView;

- (void)thn_showHintInfoViewWithText:(NSString *)text fontOfSize:(CGFloat)size color:(NSString *)color;

- (void)thn_showHintInfoWithImage:(NSString *)imageName;

@end
