//
//  THNPosterImageView.m
//  banmen
//
//  Created by FLYang on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterImageView.h"
#import "UIColor+Extension.h"
#import "MainMacro.h"
#import <YYImage/YYImage.h>

@implementation THNPosterImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
        self.clipsToBounds = NO;
        self.layer.masksToBounds = NO;
        [self thn_setViewUI];
    }
    return self;
}

#pragma mark - set
- (void)thn_setViewUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.loadImageView];
    
    CGFloat minimumScale = self.frame.size.width / self.loadImageView.frame.size.width;
    self.contentView.minimumZoomScale = 1.0;
    self.contentView.maximumZoomScale = 3.0;
    self.contentView.zoomScale = minimumScale;
}

#pragma mark - init
- (UIImageView *)loadImageView {
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _loadImageView.userInteractionEnabled = YES;
        _loadImageView.contentMode = UIViewContentModeScaleAspectFill;
        _loadImageView.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
    }
    return _loadImageView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
    }
    return _contentView;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _loadImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.contentView.contentOffset = CGPointMake(self.contentView.contentSize.width / 2.f - self.bounds.size.width / 2.f, self.contentView.contentSize.height / 2.f - self.bounds.size.height / 2.f);
}

#pragma mark - 设置图片
- (void)thn_setImageViewData:(UIImage *)imageData rect:(CGRect)rect {
    self.frame = rect;
    [self thn_setImageViewData:imageData];
}

- (void)thn_setImageViewData:(UIImage *)imageData {
    self.loadImageView.image = imageData;
    
    if (imageData == nil) {
        return;
    }
    
    CGRect rect = CGRectZero;
    CGFloat width = 0.f;
    CGFloat height = 0.f;
    if (self.contentView.frame.size.width > self.contentView.frame.size.height) {
        width = self.contentView.frame.size.width;
        height = width * imageData.size.height / imageData.size.width;
        if (height < self.contentView.frame.size.height) {
            height = self.contentView.frame.size.height;
            width = height * imageData.size.width / imageData.size.height;
        }
        
    } else {
        height = self.contentView.frame.size.height;
        width = height * imageData.size.width / imageData.size.height;
        if (width < self.contentView.frame.size.width) {
            width = self.contentView.frame.size.width;
            height = width * imageData.size.height / imageData.size.width;
        }
    }
    
    rect.size = CGSizeMake(width, height);
    
    @synchronized(self){
        self.loadImageView.frame = rect;
        [self.contentView setZoomScale:1 animated:YES];
        [self setNeedsLayout];
    }
}

@end
