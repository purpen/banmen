//
//  THNPosterTextView.h
//  banmen
//
//  Created by FLYang on 2017/8/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelText.h"

@class THNPosterTextView;

@protocol THNPosterTextViewDelegate <NSObject>

@optional
- (void)thn_textViewDidBeginEditing:(THNPosterTextView *)textView;
- (void)thn_textViewDidEndEditing:(THNPosterTextView *)textView;

@end

@interface THNPosterTextView : UIView

@property (nonatomic, strong) UITextView *posterTextView;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat maxFontSize;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) NSTextAlignment textAlignment;
@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, weak) id <THNPosterTextViewDelegate> delegate;

- (void)thn_setPosterTextViewModel:(THNPosterModelText *)model;

- (void)thn_resignFirstResponder;

- (void)thn_becomeFirstResponder;

- (void)thn_showPosterTextViewBorder:(BOOL)show;

- (void)thn_changeTextViewFontSize:(CGFloat)fontSize;

@end
