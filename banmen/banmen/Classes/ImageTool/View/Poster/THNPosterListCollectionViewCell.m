//
//  THNPosterListCollectionViewCell.m
//  banmen
//
//  Created by FLYang on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterListCollectionViewCell.h"
#import "UIColor+Extension.h"

@implementation THNPosterListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
        [self addSubview:self.posterImageView];
    }
    return self;
}

- (UIImageView *)posterImageView {
    if (!_posterImageView) {
        _posterImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _posterImageView.contentMode = UIViewContentModeScaleAspectFill;
        _posterImageView.clipsToBounds = YES;
    }
    return _posterImageView;
}

@end
