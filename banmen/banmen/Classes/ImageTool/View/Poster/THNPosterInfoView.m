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

@interface THNPosterInfoView () <UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *textViewArray;
@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation THNPosterInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBlack];
    }
    return self;
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
    [self thn_addTextViewBorder:textView];
}

//  编辑时给textView添加边框
- (void)thn_addTextViewBorder:(UITextView *)textView {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = textView.frame;
    borderLayer.position = CGPointMake(CGRectGetMidX(textView.bounds), CGRectGetMidY(textView.bounds));
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:0].CGPath;
    borderLayer.lineWidth = 1;
    //  虚线边框
    borderLayer.lineDashPattern = @[@8, @8];
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
    
    [UIView animateWithDuration:1 animations:^{
        view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^{
            view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                view.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:1];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:1 animations:^{
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
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"poster_add_%@", model.name]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        imageView.tag = imageViewTag + idx;
        
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
