//
//  THNPosterImageView.h
//  banmen
//
//  Created by FLYang on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNPosterImageView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger imageTag;
@property (nonatomic, retain) UIScrollView *contentView;
@property (nonatomic, strong) UIImageView *loadImageView;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;

- (void)thn_setImageViewData:(UIImage *)imageData;
- (void)thn_setImageViewData:(UIImage *)imageData rect:(CGRect)rect;

@end
