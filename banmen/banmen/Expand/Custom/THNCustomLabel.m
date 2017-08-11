//
//  THNCustomLabel.m
//  banmen
//
//  Created by dong on 2017/8/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNCustomLabel.h"

@implementation THNCustomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
