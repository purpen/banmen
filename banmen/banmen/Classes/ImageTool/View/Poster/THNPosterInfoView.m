//
//  THNPosterInfoView.m
//  banmen
//
//  Created by FLYang on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterInfoView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import <YYText/YYText.h>

static NSInteger const textViewTag = 3521;
static NSInteger const imageViewTag = 3821;

@interface THNPosterInfoView () <YYTextViewDelegate> {
    THNPosterImageView *_selectImageView;
}

@property (nonatomic, strong) NSMutableArray *textViewArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation THNPosterInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor colorWithHexString:kColorBlack alpha:0];
    }
    return self;
}

#pragma mark - delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _controlView;
}

#pragma mark - 选择了图片进行加载
- (void)thn_setPosterPhotoSelectImage:(UIImage *)image withTag:(NSInteger)tag {
    for (THNPosterImageView *imageView in self.imageViewArray) {
        if (imageView.tag == tag) {
            [imageView thn_setImageViewData:image];
        }
    }
}

- (void)thn_allTextViewResignFirstResponder {
    for (UITextView *textView in self.textViewArray) {
        if ([textView isFirstResponder]) {
            [textView resignFirstResponder];
        }
    }
}

#pragma mark - 添加海报默认信息
- (UIView *)controlView {
    if (!_controlView) {
        _controlView = [[UIView alloc] init];
    }
    return _controlView;
}

- (void)thn_setPosterStyleInfoData:(THNPosterModelData *)data {
    self.contentSize = CGSizeMake(data.size.width, data.size.height);
    
    self.controlView.frame = CGRectMake(0, 0, data.size.width, data.size.height);
    self.controlView.backgroundColor = [UIColor colorWithHexString:data.backgroundColor];
    
    [self addSubview:self.controlView];
    [_controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(data.size.width, data.size.height));
        make.top.left.equalTo(self).with.offset(0);
    }];
    
    [self thn_setImageViewLoadImageInfo:data.image];
    [self thn_setTextViewLoadTextInfo:data.text];
    
    CGFloat minScale = self.bounds.size.width / data.size.width;
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = minScale;
    [self setZoomScale:1 animated:NO];
}

#pragma mark 设置文字
- (void)thn_setTextViewLoadTextInfo:(NSArray *)textArray {
    if (textArray.count == 0) {
        return;
    }
    for (NSInteger idx = 0; idx < textArray.count; ++ idx) {
        THNPosterModelText *model = textArray[idx];
        
        YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(model.position.left, model.position.top, model.width, model.height)];
        
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:model.content];
        text.yy_color = [UIColor colorWithHexString:model.color];
        text.yy_font = [UIFont systemFontOfSize:model.fontSize weight:[self thn_getTextViewFontWeight:model.weight]];
        text.yy_alignment = model.align;
        textView.attributedText = text;

        textView.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        textView.tag = textViewTag + idx;
        textView.delegate = self;
        
        [self.controlView addSubview:textView];
        
        [self thn_loadFlashingAnimationOfView:textView flash:YES];
        
        [self.textViewArray addObject:textView];
    }
}

#pragma mark textViewDelegate
- (void)textViewDidBeginEditing:(YYTextView *)textView {
    [self thn_addTextViewBorder:textView];
}

//  编辑时给textView添加边框
- (void)thn_addTextViewBorder:(YYTextView *)textView {
    
}

//  获取字体的粗细等样式
- (UIFontWeight)thn_getTextViewFontWeight:(NSInteger)weight {
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

//  控件闪烁提示
- (void)thn_loadFlashingAnimationOfView:(UIView *)view flash:(BOOL)flash {
    if (flash == NO) {
        view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        return;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
                }];
            }];
        }];
    }];
}

#pragma mark - 设置图片
- (void)thn_setImageViewLoadImageInfo:(NSArray *)imageArray {
    if (imageArray.count == 0) {
        return;
    }
    
    for (NSInteger idx = 0; idx < imageArray.count; ++ idx) {
        THNPosterModelImage *model = imageArray[idx];
        
        THNPosterImageView *imageView = [[THNPosterImageView alloc] initWithFrame:CGRectMake(model.position.left, model.position.top, model.width, model.height)];
        [imageView thn_setImageViewData:[UIImage imageNamed:[NSString stringWithFormat:@"poster_add_%@", model.name]]];
        imageView.tag = imageViewTag + idx;
        
        [self thn_imageViewAddTapGestureRecognizer:imageView];
        
        [self.controlView addSubview:imageView];
        
        [self.imageViewArray addObject:imageView];
    }
}

#pragma mark 图片选择操作
- (void)thn_imageViewAddTapGestureRecognizer:(THNPosterImageView *)imageView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tapGesture];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)tapGesture {
    if ([self.tap_delegate respondsToSelector:@selector(thn_tapWithImageViewAndSelectPhoto:)]) {
        [self.tap_delegate thn_tapWithImageViewAndSelectPhoto:tapGesture.view.tag];
    }
}

#pragma mark - initArray
- (NSMutableArray *)textViewArray {
    if (!_textViewArray) {
        _textViewArray = [NSMutableArray array];
    }
    return _textViewArray;
}

- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

@end
