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
#import <IQKeyboardManager/IQKeyboardManager.h>

static NSInteger const textViewTag = 3521;
static NSInteger const imageViewTag = 3821;

@interface THNPosterInfoView () <UITextViewDelegate> {
    THNPosterImageView *_selectImageView;
}

@property (nonatomic, strong) NSMutableArray *textViewArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation THNPosterInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBlack];
        
        [self thn_setIQKeyboardManager];
    }
    return self;
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
- (void)thn_setPosterStyleInfoData:(THNPosterModelData *)data {
    [self thn_setImageViewLoadImageInfo:data.image];
    [self thn_setTextViewLoadTextInfo:data.text];
}

#pragma mark 设置文字
- (void)thn_setTextViewLoadTextInfo:(NSArray *)textArray {
    if (textArray.count == 0) {
        return;
    }
    
    for (NSInteger idx = 0; idx < textArray.count; ++ idx) {
        THNPosterModelText *model = textArray[idx];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.text = model.content;
        if (model.fontBold == 1) {
            textView.font = [UIFont boldSystemFontOfSize:model.fontSize];
        } else {
            textView.font = [UIFont systemFontOfSize:model.fontSize];
        }
        textView.textAlignment = model.align;
        textView.textColor = [UIColor colorWithHexString:model.color];
        textView.contentInset = UIEdgeInsetsMake(-13, 0, 0, 0);
        textView.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        textView.tag = textViewTag + idx;
        textView.delegate = self;
        
        [self addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(model.position.top);
            make.left.equalTo(self.mas_left).with.offset(model.position.left);
            make.right.equalTo(self.mas_right).with.offset(model.position.right);
            make.bottom.equalTo(self.mas_bottom).with.offset(model.position.bottom);
        }];
        
        [self thn_loadFlashingAnimationOfView:textView flash:YES];
        
        [self.textViewArray addObject:textView];
    }
}

#pragma mark textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

//  编辑时给textView添加边框
- (void)thn_addTextViewBorder:(UITextView *)textView {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = textView.bounds;
    borderLayer.position = CGPointMake(CGRectGetMidX(textView.bounds), CGRectGetMidY(textView.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:0].CGPath;
    borderLayer.lineWidth = 2;
    //  虚线边框
    borderLayer.lineDashPattern = @[@10, @10];
    borderLayer.fillColor = [UIColor colorWithHexString:kColorRed alpha:0].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexString:kColorRed alpha:1].CGColor;
    [textView.layer addSublayer:borderLayer];
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
        THNPosterImageView *imageView = [[THNPosterImageView alloc] initWithFrame:CGRectMake(0, 0, model.width, model.height)];
        [imageView thn_setImageViewData:[UIImage imageNamed:[NSString stringWithFormat:@"poster_add_%@", model.name]]];
        imageView.tag = imageViewTag + idx;
        
        [self thn_imageViewAddTapGestureRecognizer:imageView];
        
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(model.position.top);
            make.left.equalTo(self.mas_left).with.offset(model.position.left);
            make.right.equalTo(self.mas_right).with.offset(model.position.right);
            make.bottom.equalTo(self.mas_bottom).with.offset(model.position.bottom);
        }];
        
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
    if ([self.delegate respondsToSelector:@selector(thn_tapWithImageViewAndSelectPhoto:)]) {
        [self.delegate thn_tapWithImageViewAndSelectPhoto:tapGesture.view.tag];
    }
}

#pragma mark -
- (void)thn_setIQKeyboardManager {
    //  键盘弹起模式
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
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
