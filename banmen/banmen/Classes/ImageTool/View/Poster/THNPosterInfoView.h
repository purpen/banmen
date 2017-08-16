//
//  THNPosterInfoView.h
//  banmen
//
//  Created by FLYang on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelData.h"
#import "THNPosterImageView.h"
#import "THNPosterTextView.h"

@protocol THNPosterInfoViewDelegate <NSObject>

@optional
- (void)thn_tapWithImageViewAndSelectPhoto:(NSInteger)tag;
- (void)thn_didBeginEditingTextView:(THNPosterTextView *)textView;
- (void)thn_getEditingTextViewFrameMaxY:(CGFloat)maxY fontSize:(CGFloat)fontSize maxFontSize:(CGFloat)maxSize;

@end

@interface THNPosterInfoView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *controlView;
@property (nonatomic, weak) id <THNPosterInfoViewDelegate> tap_delegate;

- (void)thn_allTextViewResignFirstResponder;

- (void)thn_allTextViewBecomeFirstResponder;

- (void)thn_changeTextColor:(NSString *)color;

- (void)thn_changeTextAlignment:(NSTextAlignment)align;

- (void)thn_changeTextFontSize:(CGFloat)fontSize;

- (void)thn_setPosterStyleInfoData:(THNPosterModelData *)data;

- (void)thn_setPosterPhotoSelectImage:(UIImage *)image withTag:(NSInteger)tag;

@end
