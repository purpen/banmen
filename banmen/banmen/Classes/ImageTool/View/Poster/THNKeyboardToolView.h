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
- (void)thn_writeInputBoxBeginEditTextTool;
- (void)thn_writeInputBoxEndEditTextTool;
- (void)thn_selectColorForChangeTextColor:(NSString *)color;
- (void)thn_selectAlignForChangeTextAlign:(NSTextAlignment)align;
- (void)thn_changeTextFontSize:(CGFloat)fontSize;
- (void)thn_changeTextFontStyleName:(NSString *)fontName;

@end

@interface THNKeyboardToolView : UIView

/**
 键盘工具菜单按钮
 */
@property (nonatomic, strong) UIButton *selectButton;

///**
// 改变字体颜色
// */
//@property (nonatomic, strong) UIButton *changeTextColor;
//
///**
// 字体样式
// */
//@property (nonatomic, strong) UIButton *fontStyle;
//
///**
// 字体样式
// */
//@property (nonatomic, strong) UIButton *fontSize;

/**
 关闭键盘
 */
@property (nonatomic, strong) UIButton *closeKeybord;

@property (nonatomic, weak) id <THNKeyboardToolViewDelegate> delegate;

- (void)thn_refreshColorCollectionData;

- (void)thn_setChnageFontMaxSize:(CGFloat)fontSize maxFontSize:(CGFloat)maxSize;

@end
