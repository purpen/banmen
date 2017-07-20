//
//  THNJointChildView.m
//  banmen
//
//  Created by FLYang on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNJointChildView.h"
#import "UIColor+Extension.h"
#import "MainMacro.h"

@implementation THNJointChildView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self thn_setViewUI];
        [self thn_setupDefaultAttributes];
    }
    return self;
}

- (void)thn_setViewUI {
    [self addSubview:self.loadImageView];
}

- (void)thn_setupDefaultAttributes {
    self.clipsToBounds = NO;
    self.layer.masksToBounds = NO;
}

- (UIImageView *)loadImageView {
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _loadImageView.userInteractionEnabled = YES;
        _loadImageView.contentMode = UIViewContentModeScaleAspectFill;
        _loadImageView.alpha = 0;
    }
    return _loadImageView;
}

- (void)thn_setJointImageViewData:(UIImage *)imageData {
    self.loadImageView.image = imageData;
    
    if (imageData == nil) {
        return;
    }
    
    CGRect rect = CGRectZero;
    CGFloat scale = imageData.size.height / imageData.size.width;
    CGFloat width = self.frame.size.width;
    CGFloat height = width * scale;
    
    rect.size = CGSizeMake(width, height);
    
    @synchronized(self){
        self.loadImageView.frame = rect;
        [UIView animateWithDuration:0.3 animations:^{
            self.loadImageView.alpha = 1;
        }];
        [self setNeedsLayout];
    }
}


@end
