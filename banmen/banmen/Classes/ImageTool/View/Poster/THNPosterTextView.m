//
//  THNPosterTextView.m
//  banmen
//
//  Created by FLYang on 2017/8/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterTextView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNPosterTextView () <UITextViewDelegate>

@property (nonatomic, strong) UIView *layerView;

@end

@implementation THNPosterTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.layerView];
        [self addSubview:self.posterTextView];
    }
    return self;
}

#pragma mark - 设置文本的内容
- (void)thn_setPosterTextViewModel:(THNPosterModelText *)model {
    self.posterTextView.textColor = [UIColor colorWithHexString:model.color];
    self.posterTextView.font = [UIFont systemFontOfSize:model.fontSize weight:[self thn_getTextViewFontWeight:model.weight]];
    self.posterTextView.textAlignment =  (NSTextAlignment)model.align;
    self.posterTextView.text = model.content;
}

//  获取字体的粗细等样式
- (CGFloat)thn_getTextViewFontWeight:(NSInteger)weight {
    switch (weight) {
        case 0:
            return UIFontWeightRegular;
            break;
        case 1:
            return UIFontWeightUltraLight;
            break;
        case 2:
            return UIFontWeightThin;
            break;
        case 3:
            return UIFontWeightLight;
            break;
        case 4:
            return UIFontWeightMedium;
            break;
        case 5:
            return UIFontWeightSemibold;
            break;
        case 6:
            return UIFontWeightBold;
            break;
        case 7:
            return UIFontWeightHeavy;
            break;
        case 8:
            return UIFontWeightBlack;
            break;
        default:
            return UIFontWeightRegular;
            break;
    }
    return UIFontWeightRegular;
}

- (void)thn_showPosterTextViewBorder:(BOOL)show {
    CGFloat layerAlpha = show ? 1 : 0;
    self.layerView.alpha = layerAlpha;
}

#pragma mark - 边框
- (UIView *)layerView {
    if (!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:self.bounds];
        _layerView.alpha = 0;
        
        [self drawLayerView:_layerView];
    }
    return _layerView;
}

- (void)drawLayerView:(UIView *)view {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = view.bounds;
    borderLayer.position = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:0].CGPath;
    borderLayer.lineWidth = 3;
    borderLayer.lineDashPattern = @[@10, @10];
    borderLayer.fillColor = [UIColor colorWithHexString:kColorRed alpha:0].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexString:kColorRed alpha:1].CGColor;
    [view.layer addSublayer:borderLayer];
}

#pragma mark - 输入框
- (UITextView *)posterTextView {
    if (!_posterTextView) {
        _posterTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _posterTextView.returnKeyType = UIReturnKeyDone;
        _posterTextView.delegate = self;
        
        UIView *keyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        keyView.userInteractionEnabled = NO;
        _posterTextView.inputAccessoryView = keyView;
        _posterTextView.keyboardAppearance = UIKeyboardAppearanceDark;
        _posterTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _posterTextView.backgroundColor = [UIColor colorWithHexString:kColorWhite alpha:0];
    }
    return _posterTextView;
}

#pragma mark textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
//    [self thn_showPosterTextViewBorder:YES];
    if ([self.delegate respondsToSelector:@selector(thn_textViewDidBeginEditing:)]) {
        [self.delegate thn_textViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
//    [self thn_showPosterTextViewBorder:NO];
    if ([self.delegate respondsToSelector:@selector(thn_textViewDidBeginEditing:)]) {
        [self.delegate thn_textViewDidBeginEditing:self];
    }
}

- (void)thn_resignFirstResponder {
    [self.posterTextView resignFirstResponder];
}

- (void)thn_becomeFirstResponder {
    [self.posterTextView becomeFirstResponder];
}

@end
