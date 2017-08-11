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

static NSInteger const textViewTag = 3521;
static NSInteger const imageViewTag = 3821;

@interface THNPosterInfoView () <UITextViewDelegate, THNPosterTextViewDelegate> {
    THNPosterImageView *_selectImageView;
    CGFloat _frameHeight;
}

@property (nonatomic, strong) NSMutableArray *textViewArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;
@property (nonatomic, strong) THNPosterTextView *tempTextView;

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
    [self.tempTextView thn_resignFirstResponder];
}

- (void)thn_allTextViewBecomeFirstResponder {
    [self.tempTextView thn_becomeFirstResponder];
}

- (void)thn_changeTextColor:(NSString *)color {
    self.tempTextView.posterTextView.textColor = [UIColor colorWithHexString:color];
}

#pragma mark - 添加海报默认信息
- (UIView *)controlView {
    if (!_controlView) {
        _controlView = [[UIView alloc] init];
        _controlView.clipsToBounds = YES;
    }
    return _controlView;
}

- (void)thn_setPosterStyleInfoData:(THNPosterModelData *)data {
    _frameHeight = data.size.height;
    
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
        
        THNPosterTextView *textView = [[THNPosterTextView alloc] initWithFrame:CGRectMake(model.position.left, model.position.top, model.width, model.height)];
        [textView thn_setPosterTextViewModel:model];
        textView.delegate = self;
        textView.tag = textViewTag + idx;
        
        [self.controlView addSubview:textView];
        [self thn_loadFlashingAnimationOfView:textView background:model.background flash:YES];
        [self.textViewArray addObject:textView];
    }
}

//  开始编辑文字
- (void)thn_textViewDidBeginEditing:(THNPosterTextView *)textView {
    self.tempTextView = textView;
    
    CGFloat frameScale = (SCREEN_HEIGHT - 94) / _frameHeight;
    CGFloat textViewMaxY = CGRectGetMaxY(textView.frame) * frameScale;
    
    if ([self.tap_delegate respondsToSelector:@selector(thn_getEditingTextViewFrameMaxY:)]) {
        [self.tap_delegate thn_getEditingTextViewFrameMaxY:textViewMaxY];
    }
}

//  结束编辑文字
- (void)thn_textViewDidEndEditing:(THNPosterTextView *)textView {
    
}

//  控件闪烁提示
- (void)thn_loadFlashingAnimationOfView:(UIView *)view background:(NSString *)background flash:(BOOL)flash {
    if (flash == NO) {
        view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        return;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.4 animations:^{
                    view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4 animations:^{
                        if (background.length > 1) {
                            view.backgroundColor = [UIColor colorWithHexString:background alpha:1];
                        } else {
                            view.backgroundColor = [UIColor colorWithHexString:kColorWhite alpha:0];
                        }
                    }];
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
        [imageView thn_setImageViewData:[UIImage imageNamed:[NSString stringWithFormat:@"poster_add_%@", model.imageUrl]]];
        imageView.tag = imageViewTag + idx;
        imageView.imageType = model.type;
        imageView.logoType = model.name;
        if (model.radius > 0) {
            imageView.layer.cornerRadius = model.radius;
        }
        
        if (model.editType == 1) {
            imageView.userInteractionEnabled = YES;
        } else if (model.editType == 0) {
            imageView.userInteractionEnabled = NO;
        }
        
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
