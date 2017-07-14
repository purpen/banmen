//
//  THNEditContentView.h
//  banmen
//
//  Created by FLYang on 2017/7/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THNEditChildView;

@interface THNEditContentView : UIView {
    BOOL _contain;
    CGPoint _startPoint;
    CGPoint _originPoint;
}

@property (nonatomic, strong) THNEditChildView *firstView;
@property (nonatomic, strong) THNEditChildView *secondView;
@property (nonatomic, strong) THNEditChildView *thirdView;
@property (nonatomic, strong) THNEditChildView *fourthView;
@property (nonatomic, strong) THNEditChildView *fifthView;
@property (nonatomic, strong) THNEditChildView *sixthView;

/**
 图片资源
 */
@property (nonatomic, strong) NSMutableArray *photoAsset;

/**
 样式配置文件
 */
@property (nonatomic, strong) NSString *styleFileName;

/**
 style对应的tag
 */
@property (nonatomic, assign) NSInteger styleTag;
@property (nonatomic, strong) NSDictionary *styleDict;

/**
 被选中的子视图的index
 */
@property (nonatomic, assign) NSInteger childViewIndex;

/**
 保存各图片视图
 */
@property (nonatomic, strong) NSMutableArray *contentViewArray;

- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag;
- (void)resetStyle;

+ (CGRect)thn_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale;
+ (CGSize)thn_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale;
+ (CGPoint)thn_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale;

- (void)drawBoarderMiddleView:(THNEditChildView *)childEditView;
- (void)removeBoarderMiddleView:(THNEditChildView *)childEditView;

@end
