//
//  THNShowPuzzleView.h
//  banmen
//
//  Created by FLYang on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNShowPuzzleView : UIView

/**
 展示多个图片的视图
 */
@property (nonatomic, strong) UIImageView *firstView;
@property (nonatomic, strong) UIImageView *secondView;
@property (nonatomic, strong) UIImageView *thirdView;
@property (nonatomic, strong) UIImageView *fourthView;
@property (nonatomic, strong) UIImageView *fifthView;
@property (nonatomic, strong) UIImageView *sixthView;

/**
 保存AssetItem的数据
 */
@property (nonatomic, strong) NSMutableArray *photoAssetArray;

@property (nonatomic, strong) NSMutableArray *imageViewArray;

/**
 布局样式配置文件
 */
@property (nonatomic, strong) NSString     *styleFileName;
@property (nonatomic, strong) NSDictionary *styleDict;
@property (nonatomic, assign) NSInteger     styleTag;

/**
 图片尺寸大小位置的相关设置
 */
+ (CGRect)thn_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale;
+ (CGSize)thn_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale;
+ (CGPoint)thn_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale;

/**
 重置布局样式
 */
- (void)thn_resetStyle;

/**
 初始化视图
 */
- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag;

- (void)thn_setPuzzleViewStyleData:(NSMutableArray *)array styleTag:(NSInteger)tag;

@end
