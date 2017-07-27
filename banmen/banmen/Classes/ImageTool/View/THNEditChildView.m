//
//  THNEditChildView.m
//  banmen
//
//  Created by FLYang on 2017/7/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditChildView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

static const CGFloat kTHNEditChildViewGlobalInset           = 15.0f;
static const NSInteger kTHNEditChildViewSelectedBorderWidth = 4;
static const CGFloat kTHNEditChildViewInnerBoarderWidth     = 2.0f;

@interface THNEditChildView ()

@property (nonatomic, assign) CGSize originalContentSize;
@property (nonatomic, assign) CGRect originalImageViewFrame;
@property (nonatomic, assign) CGSize originalSize;

@end

@implementation THNEditChildView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self thn_setViewUI];
        [self thn_setupDefaultAttributes];
    }
    return self;
}

#pragma mark - set
- (void)thn_setViewUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.loadImageView];
    
    CGFloat minimumScale = self.frame.size.width / self.loadImageView.frame.size.width;
    self.contentView.minimumZoomScale = minimumScale;
    self.contentView.zoomScale = minimumScale;
    
    [self thn_addBoarderView];
    [self thn_addBoarderLayer];
    [self thn_addCenterDragView];
}

- (void)thn_setupDefaultAttributes {
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
}

#pragma mark - init
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
    }
    return _contentView;
}

- (UIImageView *)loadImageView {
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _loadImageView.userInteractionEnabled = YES;
        _loadImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _loadImageView;
}

#pragma mark - 边框
- (void)thn_addBoarderView {
    [self addSubview:self.topBoarderView];
    [self addSubview:self.rightBoarderView];
    [self addSubview:self.bottomBoarderView];
    [self addSubview:self.leftBoarderView];
}

- (UIView *)topBoarderView {
    if (!_topBoarderView) {
        _topBoarderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    }
    return _topBoarderView;
}

- (UIView *)rightBoarderView {
    if (!_rightBoarderView) {
        _rightBoarderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    }
    return _rightBoarderView;
}

- (UIView *)bottomBoarderView {
    if (!_bottomBoarderView) {
        _bottomBoarderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    }
    return _bottomBoarderView;
}

- (UIView *)leftBoarderView {
    if (!_leftBoarderView) {
        _leftBoarderView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
    }
    return _leftBoarderView;
}

#pragma mark - 内边框的layer
- (void)thn_addBoarderLayer {
    [self addSubview:self.topBoarderLayer];
    [self addSubview:self.rightBoarderLayer];
    [self addSubview:self.bottomBoarderLayer];
    [self addSubview:self.leftBoarderLayer];
}

- (UIView *)topBoarderLayer {
    if (!_topBoarderLayer) {
        _topBoarderLayer = [[UIView alloc] init];
        _topBoarderLayer.userInteractionEnabled = NO;
    }
    return _topBoarderLayer;
}

- (UIView *)rightBoarderLayer {
    if (!_rightBoarderLayer) {
        _rightBoarderLayer = [[UIView alloc] init];
        _rightBoarderLayer.userInteractionEnabled = NO;
    }
    return _rightBoarderLayer;
}

- (UIView *)bottomBoarderLayer {
    if (!_bottomBoarderLayer) {
        _bottomBoarderLayer = [[UIView alloc] init];
        _bottomBoarderLayer.userInteractionEnabled = NO;
    }
    return _bottomBoarderLayer;
}

- (UIView *)leftBoarderLayer {
    if (!_leftBoarderLayer) {
        _leftBoarderLayer = [[UIView alloc] init];
        _leftBoarderLayer.userInteractionEnabled = NO;
    }
    return _leftBoarderLayer;
}

#pragma mark - 边框中部的拖动视图
- (void)thn_addCenterDragView {
    [self addSubview:self.topMiddleView];
    [self addSubview:self.rightMiddleView];
    [self addSubview:self.bottomMiddleView];
    [self addSubview:self.leftMiddleView];
}

- (UIView *)topMiddleView {
    if (!_topMiddleView) {
        _topMiddleView = [[UIView alloc] init];
        _topMiddleView.layer.cornerRadius = 5;
        _topMiddleView.userInteractionEnabled = NO;
    }
    return _topMiddleView;
}

- (UIView *)rightMiddleView {
    if (!_rightMiddleView) {
        _rightMiddleView = [[UIView alloc] init];
        _rightMiddleView.layer.cornerRadius = 5;
        _rightMiddleView.userInteractionEnabled = NO;
    }
    return _rightMiddleView;
}

- (UIView *)bottomMiddleView {
    if (!_bottomMiddleView) {
        _bottomMiddleView = [[UIView alloc] init];
        _bottomMiddleView.layer.cornerRadius = 5;
        _bottomMiddleView.userInteractionEnabled = NO;
    }
    return _bottomMiddleView;
}

- (UIView *)leftMiddleView {
    if (!_leftMiddleView) {
        _leftMiddleView = [[UIView alloc] init];
        _leftMiddleView.layer.cornerRadius = 5;
        _leftMiddleView.userInteractionEnabled = NO;
    }
    return _leftMiddleView;
}

#pragma mark - 重新设置frame
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.contentView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    //  缩放
    if (self.originalContentSize.width != 0) {
        if (frame.size.width > self.loadImageView.frame.size.width) {
            CGFloat widthRation = frame.size.width / self.loadImageView.frame.size.width;
            self.loadImageView.frame = CGRectMake(0, 0, self.loadImageView.frame.size.width * widthRation, self.loadImageView.frame.size.height);
            self.contentView.contentSize = CGSizeMake(_loadImageView.frame.size.width + 1, _loadImageView.frame.size.height + 1);
        }
        
        if(frame.size.height > self.loadImageView.frame.size.height) {
            CGFloat heightRation = frame.size.height / self.loadImageView.frame.size.height;
            self.loadImageView.frame = CGRectMake(0, 0, self.loadImageView.frame.size.width, self.loadImageView.frame.size.height * heightRation);
            self.contentView.contentSize = CGSizeMake(_loadImageView.frame.size.width + 1, _loadImageView.frame.size.height + 1);
        }
        
        if (frame.size.width < self.loadImageView.frame.size.width && frame.size.width > self.originalImageViewFrame.size.width) {
            CGFloat widthRation = frame.size.width / self.loadImageView.frame.size.width;
            self.loadImageView.frame = CGRectMake(0, 0, self.loadImageView.frame.size.width * widthRation, self.loadImageView.frame.size.height);
            self.contentView.contentSize = CGSizeMake(_loadImageView.frame.size.width + 1, _loadImageView.frame.size.height + 1);
        }
        
        if (frame.size.height < self.loadImageView.frame.size.height && frame.size.height > self.originalImageViewFrame.size.height) {
            CGFloat heightRation = frame.size.height / self.loadImageView.frame.size.height;
            self.loadImageView.frame = CGRectMake(0, 0, self.loadImageView.frame.size.width, self.loadImageView.frame.size.height * heightRation);
            self.contentView.contentSize = CGSizeMake(_loadImageView.frame.size.width + 1, _loadImageView.frame.size.height + 1);
        }
    }
    
    self.contentView.minimumZoomScale = 1.2;
    self.contentView.maximumZoomScale = 3.8;
    
    //  boarderView的frame
    self.topBoarderView.frame = CGRectMake(0, 0, self.bounds.size.width - kTHNEditChildViewGlobalInset, kTHNEditChildViewGlobalInset);
    self.rightBoarderView.frame = CGRectMake(self.bounds.size.width - kTHNEditChildViewGlobalInset, 0, kTHNEditChildViewGlobalInset, self.bounds.size.height - kTHNEditChildViewGlobalInset);
    self.bottomBoarderView.frame = CGRectMake(kTHNEditChildViewGlobalInset, self.bounds.size.height - kTHNEditChildViewGlobalInset, self.bounds.size.width - kTHNEditChildViewGlobalInset, kTHNEditChildViewGlobalInset);
    self.leftBoarderView.frame = CGRectMake(0, kTHNEditChildViewGlobalInset, kTHNEditChildViewGlobalInset, self.bounds.size.height - kTHNEditChildViewGlobalInset);
    
    //  改变frame时重置layer的frame
    self.topBoarderLayer.frame = CGRectMake(0, 0, self.frame.size.width, kTHNEditChildViewInnerBoarderWidth);
    self.rightBoarderLayer.frame = CGRectMake(self.frame.size.width - kTHNEditChildViewInnerBoarderWidth, 0, kTHNEditChildViewInnerBoarderWidth, self.frame.size.height);
    self.bottomBoarderLayer.frame = CGRectMake(0, self.frame.size.height - kTHNEditChildViewInnerBoarderWidth, self.frame.size.width, kTHNEditChildViewInnerBoarderWidth);
    self.leftBoarderLayer.frame = CGRectMake(0.0f, 0.0f, kTHNEditChildViewInnerBoarderWidth, self.frame.size.height);
    
    //  四个边中间的view
    self.topMiddleView.frame = CGRectMake(CGRectGetMaxX(self.bounds)/4.f, -kTHNEditChildViewSelectedBorderWidth, CGRectGetWidth(self.bounds)/2.f, kTHNEditChildViewSelectedBorderWidth * 2);
    self.rightMiddleView.frame = CGRectMake(CGRectGetMaxX(self.bounds) - kTHNEditChildViewSelectedBorderWidth, CGRectGetMaxY(self.bounds)/4.f, kTHNEditChildViewSelectedBorderWidth * 2, CGRectGetHeight(self.bounds)/2.f);
    self.bottomMiddleView.frame = CGRectMake(CGRectGetMaxX(self.bounds)/4.f, CGRectGetMaxY(self.bounds) - kTHNEditChildViewSelectedBorderWidth, CGRectGetWidth(self.bounds)/2.f, kTHNEditChildViewSelectedBorderWidth * 2);
    self.leftMiddleView.frame = CGRectMake(-kTHNEditChildViewSelectedBorderWidth, CGRectGetMaxY(self.bounds)/4.f, kTHNEditChildViewSelectedBorderWidth * 2, CGRectGetHeight(self.bounds)/2.f);
}

- (void)thn_setNotReloadFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)thn_setImageViewData:(UIImage *)imageData rect:(CGRect)rect {
    self.frame = rect;
    [self thn_setImageViewData:imageData];
}

- (void)thn_setImageViewData:(UIImage *)imageData {
    _loadImageView.image = imageData;
    
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
        [self.contentView setZoomScale:1.1 animated:YES];
        [self setNeedsLayout];
        self.originalContentSize = _contentView.contentSize;
        self.originalImageViewFrame = self.loadImageView.frame;
        self.originalSize = self.bounds.size;
    }
}

- (void)drawInnerBoarder {
    self.leftBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    self.rightBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    self.topBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    self.bottomBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
}

- (void)clearInnerBoarder {
    self.leftBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    self.topBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    self.rightBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    self.bottomBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _loadImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.contentView.contentOffset = CGPointMake(self.contentView.contentSize.width / 2.f - self.bounds.size.width / 2.f, self.contentView.contentSize.height / 2.f - self.bounds.size.height / 2.f);
}


@end
