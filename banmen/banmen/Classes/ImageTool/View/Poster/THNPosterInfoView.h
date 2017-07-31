//
//  THNPosterInfoView.h
//  banmen
//
//  Created by FLYang on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelData.h"
#import "THNPosterImageView.h"

@protocol THNPosterInfoViewDelegate <NSObject>

@optional
- (void)thn_tapWithImageViewAndSelectPhoto:(NSInteger)tag;

@end

@interface THNPosterInfoView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *controlView;
@property (nonatomic, weak) id <THNPosterInfoViewDelegate> tap_delegate;

- (void)thn_allTextViewResignFirstResponder;

- (void)thn_setPosterStyleInfoData:(THNPosterModelData *)data;

- (void)thn_setPosterPhotoSelectImage:(UIImage *)image withTag:(NSInteger)tag;

@end
