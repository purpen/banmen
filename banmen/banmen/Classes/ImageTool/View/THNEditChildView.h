//
//  THNEditChildView.h
//  banmen
//
//  Created by FLYang on 2017/7/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THNEditDirection) {
    THNEditDirectionNone = 0,
    THNEditDirectionTop,
    THNEditDirectionLeft,
    THNEditDirectionBottom,
    THNEditDirectionRight
};

@interface THNNeighborElement : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) THNEditDirection direction;

@end

/**
 调整大小的delegate
 */
@protocol THNEditChildViewResizableDelegate;

@interface THNEditChildView : UIView <UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *contentView;
@property (nonatomic, strong) UIImageView *loadImageView;
@property (nonatomic, assign) CGRect oldRect;

/**
 相邻信息
 */
@property (nonatomic, retain) NSMutableArray *topArray;
@property (nonatomic, retain) NSMutableArray *leftArray;
@property (nonatomic, retain) NSMutableArray *bottomArray;
@property (nonatomic, retain) NSMutableArray *rightArray;

/**
 frame的属性
 */
@property (nonatomic, strong) UIView *topBoarderView;   //  最上部用于检测手势
@property (nonatomic, strong) UIView *rightBoarderView;
@property (nonatomic, strong) UIView *bottomBoarderView;
@property (nonatomic, strong) UIView *leftBoarderView;

/**
 加内部边框时用的layer
 */
@property (nonatomic, strong) UIView *topBoarderLayer;
@property (nonatomic, strong) UIView *rightBoarderLayer;
@property (nonatomic, strong) UIView *bottomBoarderLayer;
@property (nonatomic, strong) UIView *leftBoarderLayer;

/**
 中间的粗边框，在外层判断
 */
@property (nonatomic, strong) UIView *topMiddleView;
@property (nonatomic, strong) UIView *rightMiddleView;
@property (nonatomic, strong) UIView *bottomMiddleView;
@property (nonatomic, strong) UIView *leftMiddleView;

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat minHeight;

@property (nonatomic, weak) id <THNEditChildViewResizableDelegate> resizeDelegate;

- (void)thn_setImageViewData:(UIImage *)imageData;
- (void)thn_setImageViewData:(UIImage *)imageData rect:(CGRect)rect;
- (void)thn_setNotReloadFrame:(CGRect)frame;

/**
 添加和删除选中边框
 */
- (void)drawInnerBoarder;
- (void)clearInnerBoarder;

@end


//@protocol THNEditChildViewDelegate <NSObject>
//
//- (void)thn_tapWithEditView:(THNEditChildView *)sender;
//
//@end


@protocol THNEditChildViewResizableDelegate <NSObject>

/**
 触摸开始
 */
- (void)thn_editChildViewDidBeginEditing:(THNEditChildView *)editChildView;

/**
 触摸结束
 */
- (void)thn_editChildViewDidEndEditing:(THNEditChildView *)editChildView;

@end

