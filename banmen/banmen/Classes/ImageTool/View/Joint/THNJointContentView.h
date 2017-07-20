//
//  THNJointImageView.h
//  banmen
//
//  Created by FLYang on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNJointChildView.h"

@interface THNJointContentView : UIScrollView

/**
 图片视图
 */
@property (nonatomic, strong) THNJointChildView *firstView;
@property (nonatomic, strong) THNJointChildView *secondView;
@property (nonatomic, strong) THNJointChildView *thirdView;
@property (nonatomic, strong) THNJointChildView *fourthView;
@property (nonatomic, strong) THNJointChildView *fifthView;
@property (nonatomic, strong) THNJointChildView *sixthView;

/**
 图片资源
 */
@property (nonatomic, strong) NSMutableArray *photoAsset;
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 保存各图片视图的数组
 */
@property (nonatomic, strong) NSMutableArray *contentViewArray;

- (void)thn_setImageViewData;

@end
