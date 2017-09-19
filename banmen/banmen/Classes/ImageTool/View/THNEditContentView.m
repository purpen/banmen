//
//  THNEditContentView.m
//  banmen
//
//  Created by FLYang on 2017/7/10.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditContentView.h"
#import "THNEditChildView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNAssetItem.h"
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger, THNChildEditViewBoarder){
    THNChildEditViewBoarderNone = 0,
    THNChildEditViewBoarderTop,
    THNChildEditViewBoarderLeft,
    THNChildEditViewBoarderDown,
    THNChildEditViewBoarderRight
};

static const NSInteger kChildViewInitTag = 51;
static const CGFloat kMinWidth = 48;
static const CGFloat kMinHeight = 48;

@interface THNEditContentView ()

/**
 移动交换中间变量
 */
@property (nonatomic, strong) THNEditChildView *tempView;
@property (nonatomic, assign) CGFloat leftTopX;
@property (nonatomic, assign) CGFloat leftTopY;
@property (nonatomic, assign) CGFloat rightDownX;
@property (nonatomic, assign) CGFloat rightDownY;
@property (nonatomic, assign) CGRect originalFrame;

/**
 是否是最小
 */
@property (nonatomic, assign) BOOL reachSmallest;

@end

@implementation THNEditContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame tag:0];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
        self.styleTag = tag;
        [self resetAllView];
        [self thn_addChildView];
        [self addTapGesture];
    }
    return self;
}

#pragma mark - 读取样式配置
- (void)setStyleTag:(NSInteger)styleTag {
    _styleTag = styleTag;
    _styleFileName = nil;
    NSString *picCountFlag = @"";
    switch (_photoAsset.count) {
        case 1:
            picCountFlag = @"one";
            break;
        case 2:
            picCountFlag = @"two";
            break;
        case 3:
            picCountFlag = @"three";
            break;
        case 4:
            picCountFlag = @"four";
            break;
        case 5:
            picCountFlag = @"five";
            break;
        case 6:
            picCountFlag = @"six";
            break;
        case 7:
            picCountFlag = @"seven";
            break;
        case 8:
            picCountFlag = @"eight";
            break;
        case 9:
            picCountFlag = @"nine";
            break;
        default:
            break;
    }
    
    if (![picCountFlag isEqualToString:@""]) {
        _styleFileName = [NSString stringWithFormat:@"%@_style_%zi",picCountFlag,_styleTag];
        _styleDict = nil;
        _styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_styleFileName ofType:@"plist"]];
        if (_styleDict) {
            [self resetAllView];
            [self resetStyle];
        }
    }
}

#pragma mark - 设置所有视图
- (void)resetAllView {
    [self styleSettingWithView:self.firstView];
    [self styleSettingWithView:self.secondView];
    [self styleSettingWithView:self.thirdView];
    [self styleSettingWithView:self.fourthView];
    [self styleSettingWithView:self.fifthView];
    [self styleSettingWithView:self.sixthView];
    [self styleSettingWithView:self.sevenView];
    [self styleSettingWithView:self.eightView];
    [self styleSettingWithView:self.nineView];
    
    [self thn_arrayAddViewObject];
}

//  重置子视图的样式
- (void)styleSettingWithView:(THNEditChildView *)view {
    view.frame = CGRectZero;
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
    [view thn_setImageViewData:nil];
    view.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressView:)];
    [view addGestureRecognizer:longPressGesture];
}

#pragma mark - 替换图片，修改frame
- (void)resetStyle {
    if(_styleDict) {
        CGSize superSize = CGSizeFromString([[_styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
        superSize = [THNEditContentView thn_sizeScaleWithSize:superSize scale:2.0f];
        NSArray *subViewArray = [_styleDict objectForKey:@"SubViewArray"];
        if (self.photoAsset.count < subViewArray.count) {
            NSInteger difference = subViewArray.count - self.photoAsset.count;
            for (NSInteger i = 0; i < difference; i++) {
                PHAsset *asset = self.photoAsset.lastObject;
                [self.photoAsset addObject:asset];
            }
        }
        
        PHImageRequestOptions *requestOption = [[PHImageRequestOptions alloc] init];
        requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        for(NSInteger j = 0; j < subViewArray.count; j++) {
            CGRect rect = CGRectZero;
            UIBezierPath *path = nil;
            THNAssetItem *assetItem = [self.photoAsset objectAtIndex:j];
            NSDictionary *subDict = [subViewArray objectAtIndex:j];
            rect = [self thn_rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
            if ([subDict objectForKey:@"pointArray"]) {
                NSArray *pointArray = [subDict objectForKey:@"pointArray"];
                path = [UIBezierPath bezierPath];
                if (pointArray.count > 2) {
                    //  生成点的坐标
                    for (int i = 0; i < [pointArray count]; i++) {
                        NSString *pointString = [pointArray objectAtIndex:i];
                        if (pointString) {
                            CGPoint point = CGPointFromString(pointString);
                            point = [THNEditContentView thn_pointScaleWithPoint:point scale:2.0f];
                            point.x = (point.x) * self.frame.size.width / superSize.width - rect.origin.x;
                            point.y = (point.y) * self.frame.size.height / superSize.height - rect.origin.y;
                            if (i == 0) {
                                [path moveToPoint:point];
                            } else {
                                [path addLineToPoint:point];
                            }
                        }
                    }
                    
                } else {
                    //  当点的左边不能形成一个面的时候  至少三个点的时候 就是一个矩形
                    //  点的坐标就是rect的四个角
                    [path moveToPoint:CGPointMake(0, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
                    [path addLineToPoint:CGPointMake(0, rect.size.height)];
                }
                [path closePath];
            }
            
            if (j < [_contentViewArray count]) {
                THNEditChildView *childEditView = (THNEditChildView *)[_contentViewArray objectAtIndex:j];
                childEditView.frame = rect;
                childEditView.topArray = [[[subDict objectForKey:@"Top"] componentsSeparatedByString:@","] mutableCopy];
                childEditView.leftArray = [[[subDict objectForKey:@"Left"] componentsSeparatedByString:@","] mutableCopy];
                childEditView.bottomArray = [[[subDict objectForKey:@"Bottom"] componentsSeparatedByString:@","] mutableCopy];
                childEditView.rightArray = [[[subDict objectForKey:@"Right"] componentsSeparatedByString:@","] mutableCopy];
                childEditView.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
                if (assetItem.image != nil) {
                    [childEditView thn_setImageViewData:assetItem.image rect:rect];
                } else {
                    [[PHImageManager defaultManager] requestImageForAsset:assetItem.asset
                                                               targetSize:CGSizeMake(assetItem.asset.pixelWidth, assetItem.asset.pixelHeight)
                                                              contentMode:PHImageContentModeAspectFill
                                                                  options:requestOption
                                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                                [childEditView thn_setImageViewData:result rect:rect];
                                                            }];
                }
                childEditView.oldRect = rect;
            }
        }
    }
}

#pragma mark - 手势操作
- (void)addTapGesture {
    [self thn_imageViewAddTapGestureRecognizer:self.firstView];
    [self thn_imageViewAddTapGestureRecognizer:self.secondView];
    [self thn_imageViewAddTapGestureRecognizer:self.thirdView];
    [self thn_imageViewAddTapGestureRecognizer:self.fourthView];
    [self thn_imageViewAddTapGestureRecognizer:self.fifthView];
    [self thn_imageViewAddTapGestureRecognizer:self.sixthView];
    [self thn_imageViewAddTapGestureRecognizer:self.sevenView];
    [self thn_imageViewAddTapGestureRecognizer:self.eightView];
    [self thn_imageViewAddTapGestureRecognizer:self.nineView];
}

- (void)thn_imageViewAddTapGestureRecognizer:(THNEditChildView *)childEditView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    [childEditView addGestureRecognizer:tapGesture];
}

#pragma mark 点击里面的view
- (void)handleTapGesture:(UITapGestureRecognizer *)gesture {
    [self setValue:[NSNumber numberWithInteger:gesture.view.tag - kChildViewInitTag] forKey:@"childViewIndex"];
    
    [self.firstView clearInnerBoarder];
    [self.secondView clearInnerBoarder];
    [self.thirdView clearInnerBoarder];
    [self.fourthView clearInnerBoarder];
    [self.fifthView clearInnerBoarder];
    [self.sixthView clearInnerBoarder];
    [self.sevenView clearInnerBoarder];
    [self.eightView clearInnerBoarder];
    [self.nineView clearInnerBoarder];
    
    THNEditChildView *childEditView = (THNEditChildView *)gesture.view;
    [childEditView drawInnerBoarder];
    
    //  移除其他的提示拖动边框
    [self removeBoarderMiddleView:self.firstView];
    [self removeBoarderMiddleView:self.secondView];
    [self removeBoarderMiddleView:self.thirdView];
    [self removeBoarderMiddleView:self.fourthView];
    [self removeBoarderMiddleView:self.fifthView];
    [self removeBoarderMiddleView:self.sixthView];
    [self removeBoarderMiddleView:self.sevenView];
    [self removeBoarderMiddleView:self.eightView];
    [self removeBoarderMiddleView:self.nineView];
    
    //  加入拖动边框
    [self drawBoarderMiddleView:childEditView];
    
    //  点击事件
    if ([self.childViewDelegate respondsToSelector:@selector(thn_tapWithEditView:)]) {
        [self.childViewDelegate thn_tapWithEditView:childEditView];
    }
}

- (void)drawBoarderMiddleView:(THNEditChildView *)childEditView {
    self.leftTopX = self.frame.origin.x;
    self.leftTopY = self.frame.origin.y - 64;
    self.rightDownX = CGRectGetMaxX(self.frame);
    self.rightDownY = CGRectGetMaxY(self.frame) - 64;
    
    if (childEditView.frame.size.width == 0 || childEditView.frame.size.height == 0) {
        return;
    }
    
    if (childEditView.frame.origin.x != self.leftTopX) {
        childEditView.leftMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    }
    
    if (childEditView.frame.origin.y != self.leftTopY) {
        childEditView.topMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    }
    
    if (CGRectGetMaxX(childEditView.frame) != self.rightDownX) {
        childEditView.rightMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    }
    
    if (CGRectGetMaxY(childEditView.frame) != self.rightDownY) {
        childEditView.bottomMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:1];
    }
}

- (void)removeBoarderMiddleView:(THNEditChildView *)childEditView {
    childEditView.leftMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.rightMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.topMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.bottomMiddleView.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
}

#pragma mark 长按交换位置的操作
- (void)handleLongPressView:(UILongPressGestureRecognizer *)gesture {
    THNEditChildView *childView = (THNEditChildView *)gesture.view;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _startPoint = [gesture locationInView:gesture.view];
        _originPoint = childView.center;
        [self bringSubviewToFront:childView];
        [UIView animateWithDuration:0.2f animations:^{
            childView.transform = CGAffineTransformMakeScale(1.1, 1.1);
            childView.alpha = 0.7;
        }];
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint newPoint = [gesture locationInView:gesture.view];
        CGFloat deltaX = newPoint.x - _startPoint.x;
        CGFloat deltaY = newPoint.y - _startPoint.y;
        childView.center = CGPointMake(childView.center.x + deltaX, childView.center.y + deltaY);
        NSInteger index = [self indexOfPoint:childView.center withChildView:childView];
        if (index < 0) {
            _contain = NO;
            _tempView = nil;
            
        } else {
            if (index != -1) {
                _tempView = _contentViewArray[index];
                //  修改选中为移动位置后的那个
                [self setValue:[NSNumber numberWithInteger:index] forKey:@"childViewIndex"];
            }
        }
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
            childView.transform = CGAffineTransformIdentity;
            childView.alpha = 1.0;
            if (!_contain) {
                if (_tempView) {
                    [self exchangeFromIndex:childView.tag - kChildViewInitTag toIndex:_tempView.tag - kChildViewInitTag];
                    [self changeSelectedBoarder:gesture];
                } else {
                    [childView thn_setNotReloadFrame:childView.oldRect];
                }
            }
            _tempView = nil;
        }];
    }
}

- (NSInteger)indexOfPoint:(CGPoint)point withChildView:(THNEditChildView *)childView {
    for (NSInteger idx = 0; idx < _contentViewArray.count; idx++) {
        THNEditChildView *childEditView = _contentViewArray[idx];
        if (childEditView != childView) {
            if (CGRectContainsPoint(childEditView.oldRect, point)) {
                return idx;
            }
        }
    }
    return -1;
}

- (void)changeSelectedBoarder:(UILongPressGestureRecognizer *)gesture {
    [self.firstView clearInnerBoarder];
    [self.secondView clearInnerBoarder];
    [self.thirdView clearInnerBoarder];
    [self.fourthView clearInnerBoarder];
    [self.fifthView clearInnerBoarder];
    [self.sixthView clearInnerBoarder];
    [self.sevenView clearInnerBoarder];
    [self.eightView clearInnerBoarder];
    [self.nineView clearInnerBoarder];
    
    THNEditChildView *childEditView = (THNEditChildView *)gesture.view;
    [childEditView drawInnerBoarder];
    
    //  移除其他的提示拖动边框
    [self removeBoarderMiddleView:self.firstView];
    [self removeBoarderMiddleView:self.secondView];
    [self removeBoarderMiddleView:self.thirdView];
    [self removeBoarderMiddleView:self.fourthView];
    [self removeBoarderMiddleView:self.fifthView];
    [self removeBoarderMiddleView:self.sixthView];
    [self removeBoarderMiddleView:self.sevenView];
    [self removeBoarderMiddleView:self.eightView];
    [self removeBoarderMiddleView:self.nineView];
    
    //  加入粗提示拖动边框
    [self drawBoarderMiddleView:childEditView];
}

- (void)exchangeFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    THNAssetItem *fromAsset = [_photoAsset objectAtIndex:fromIndex];
    THNAssetItem *toAsset = [_photoAsset objectAtIndex:toIndex];
    
    [_photoAsset replaceObjectAtIndex:fromIndex withObject:toAsset];
    [_photoAsset replaceObjectAtIndex:toIndex withObject:fromAsset];
    
    THNEditChildView *fromView = [_contentViewArray objectAtIndex:fromIndex];
    THNEditChildView *toView = [_contentViewArray objectAtIndex:toIndex];
    
    [_contentViewArray replaceObjectAtIndex:fromIndex withObject:toView];
    [_contentViewArray replaceObjectAtIndex:toIndex withObject:fromView];
    
    THNEditChildView *childView = [[THNEditChildView alloc] init];
    childView.oldRect = fromView.oldRect;
    childView.tag = fromView.tag;
    childView.topArray = fromView.topArray;
    childView.leftArray = fromView.leftArray;
    childView.bottomArray = fromView.bottomArray;
    childView.rightArray = fromView.rightArray;
    
    PHImageRequestOptions *requestOption = [[PHImageRequestOptions alloc] init];
    requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    fromView.frame = toView.oldRect;
    __block UIImage *image;
    [[PHImageManager defaultManager] requestImageForAsset:fromAsset.asset
                                               targetSize:CGSizeMake(350, 350)
                                              contentMode:PHImageContentModeAspectFill
                                                  options:requestOption
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                [fromView thn_setImageViewData:result];
                                                image = result;
                                            }];
    
    [fromView thn_setImageViewData:image rect:toView.oldRect];
    fromView.tag = toView.tag;
    fromView.oldRect = toView.oldRect;
    fromView.topArray = toView.topArray;
    fromView.leftArray = toView.leftArray;
    fromView.bottomArray = toView.bottomArray;
    fromView.rightArray = toView.rightArray;
    
    
    toView.frame = childView.oldRect;
    __block UIImage *secondImage;
    [[PHImageManager defaultManager] requestImageForAsset:toAsset.asset
                                               targetSize:CGSizeMake(350, 350)
                                              contentMode:PHImageContentModeAspectFill
                                                  options:requestOption
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                [toView thn_setImageViewData:result];
                                                secondImage = result;
                                            }];
    
    //  在主线程设置rect，防止被修改
    [toView thn_setImageViewData:secondImage rect:childView.oldRect];
    toView.tag = childView.tag;
    toView.oldRect = childView.oldRect;
    toView.topArray = childView.topArray;
    toView.leftArray = childView.leftArray;
    toView.bottomArray = childView.bottomArray;
    toView.rightArray = childView.rightArray;
    childView = nil;
}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.reachSmallest = NO;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offset_X = point.x - prePoint.x;
    CGFloat offset_Y = point.y - prePoint.y;
    
    THNEditChildView *childView = [self viewAccordingToTag:touch.view.superview.tag];
    
    if (touch.view == childView.rightBoarderView) {
        [self thn_touchesMovedChildViewBoarderRight:childView offsetX:offset_X];
        
    } else if (touch.view == childView.leftBoarderView) {
        [self thn_touchesMovedChildViewBoarderLeft:childView offsetX:offset_X];
        
    } else if (touch.view == childView.bottomBoarderView) {
        [self thn_touchesMovedChildViewBoarderDown:childView offsetY:offset_Y];
        
    } else if (touch.view == childView.topBoarderView) {
        [self thn_touchesMovedChildViewBoarderTop:childView offsetY:offset_Y];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ///
}

#pragma mark - 根据触摸的边框调整拼图尺寸
#pragma mark 右边框
- (void)thn_touchesMovedChildViewBoarderRight:(THNEditChildView *)childView offsetX:(CGFloat)offset_X {
    if ([childView.rightArray[0] isEqualToString:@"0"]) {
        return;
    }
    
    CGRect currentOldRect = childView.frame;
    
    //  视图太小时禁止拖动
    if ((CGRectGetWidth(currentOldRect) <= kMinWidth) && (offset_X < 0)) {
        currentOldRect.size.width = kMinWidth;
        childView.frame = currentOldRect;
        childView.oldRect = currentOldRect;
        return;
        
    } else {
        for (NSString *neighbor in childView.rightArray) {
            if ([neighbor isEqualToString:@"0"]) {
                break;
            }
            
            NSArray *component = [neighbor componentsSeparatedByString:@"."];
            THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
            CGRect neighborRect = neighborView.frame;
            
            switch ([component[1] integerValue]) {
                case THNChildEditViewBoarderTop:
                    break;
                    
                case THNChildEditViewBoarderLeft:
                    if (CGRectGetWidth(neighborRect) <= kMinWidth && (offset_X > 0)) {
                        neighborRect.size.width = kMinWidth;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderDown:
                    break;
                    
                case THNChildEditViewBoarderRight:
                    if (CGRectGetWidth(neighborRect) <= kMinWidth && (offset_X < 0)) {
                        neighborRect.size.width = kMinWidth;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
            }
            if (self.reachSmallest) {
                break;
            }
        }
        
        if (self.reachSmallest) {
            return;
        }
    }
    
    currentOldRect.size.width += offset_X;
    if (CGRectGetWidth(currentOldRect) < kMinWidth && (offset_X < 0)) {
        currentOldRect.size.width = kMinWidth;
    }
    childView.frame = currentOldRect;
    childView.oldRect = currentOldRect;
    
    //  更新相邻的视图
    [self thn_updateChildViewNeighborRight:childView oldRect:currentOldRect offsetX:offset_X];
}

- (void)thn_updateChildViewNeighborRight:(THNEditChildView *)childView oldRect:(CGRect)currentOldRect offsetX:(CGFloat)offset_X {
    for (NSString *neighbor in childView.rightArray) {
        if ([neighbor isEqualToString:@"0"])
            break;
        
        NSArray *component = [neighbor componentsSeparatedByString:@"."];
        THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
        CGRect neighborRect = neighborView.frame;
        if (CGRectGetHeight(neighborRect) < kMinWidth) {
            neighborRect.size.height = kMinWidth;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
        
        switch ([component[1] integerValue]) {
            case THNChildEditViewBoarderTop:
                break;
                
            case THNChildEditViewBoarderLeft:
                neighborRect = CGRectMake(CGRectGetMaxX(currentOldRect), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame) - offset_X, CGRectGetHeight(neighborView.frame));
                if (CGRectGetWidth(neighborRect) < kMinWidth && (offset_X > 0)) {
                    neighborRect.size.width = kMinWidth;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(childView.frame), CGRectGetMinX(neighborView.frame) - CGRectGetMinX(childView.frame), CGRectGetHeight(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderDown:
                break;
                
            case THNChildEditViewBoarderRight:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame) + offset_X, CGRectGetHeight(neighborView.frame));
                if (CGRectGetWidth(neighborRect) < kMinWidth && (offset_X < 0)) {
                    neighborRect.size.width = kMinWidth;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(childView.frame), CGRectGetMaxX(neighborView.frame) - CGRectGetMinX(childView.frame), CGRectGetHeight(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
        }
        
        if (CGRectGetWidth(neighborRect) < kMinWidth) {
            neighborRect.size.width = kMinWidth;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
            return;
            
        } else {
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
    }
}

#pragma mark 左边框
- (void)thn_touchesMovedChildViewBoarderLeft:(THNEditChildView *)childView offsetX:(CGFloat)offset_X {
    if ([childView.leftArray[0] isEqualToString:@"0"]) {
        return;
    }
    
    CGRect currentOldRect = childView.frame;
    
    //  视图太小时禁止拖动
    if ((CGRectGetWidth(currentOldRect) <= kMinWidth) && (offset_X > 0)) {
        currentOldRect.size.width = kMinWidth;
        childView.frame = currentOldRect;
        childView.oldRect = currentOldRect;
        return;
        
    } else {
        for (NSString *neighbor in childView.leftArray) {
            if ([neighbor isEqualToString:@"0"]) {
                break;
            }
            NSArray *component = [neighbor componentsSeparatedByString:@"."];
            THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
            CGRect neighborRect = neighborView.frame;
            switch ([component[1] integerValue]) {
                case THNChildEditViewBoarderTop:
                    break;
                    
                case THNChildEditViewBoarderLeft:
                    if (CGRectGetWidth(neighborRect) <= kMinWidth && (offset_X > 0)) {
                        neighborRect.size.width = kMinWidth;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderDown:
                    break;
                    
                case THNChildEditViewBoarderRight:
                    if (CGRectGetWidth(neighborRect) <= kMinWidth && (offset_X < 0)) {
                        neighborRect.size.width = kMinWidth;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
            }
            
            if (self.reachSmallest) {
                break;
            }
        }
        
        if (self.reachSmallest) {
            return;
        }
    }
    
    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame) + offset_X, CGRectGetMinY(childView.frame), CGRectGetWidth(childView.frame) - offset_X, CGRectGetHeight(childView.frame));
    
    if (CGRectGetWidth(currentOldRect) < kMinWidth && (offset_X > 0)) {
        currentOldRect.size.width = kMinWidth;
    }
    childView.frame = currentOldRect;
    childView.oldRect = currentOldRect;
    
    //  更新相邻的视图
    [self thn_updateChildViewNeighborLeft:childView oldRect:currentOldRect offsetX:offset_X];
}

- (void)thn_updateChildViewNeighborLeft:(THNEditChildView *)childView oldRect:(CGRect)currentOldRect offsetX:(CGFloat)offset_X {
    for (NSString *neighbor in childView.leftArray) {
        if ([neighbor isEqualToString:@"0"])break;
        
        NSArray *component = [neighbor componentsSeparatedByString:@"."];
        THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
        CGRect neighborRect = neighborView.frame;
        if (CGRectGetWidth(neighborRect) < kMinWidth) {
            neighborRect.size.width = kMinWidth;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
        
        if (CGRectGetWidth(neighborRect) < kMinWidth)return;
        switch ([component[1] integerValue]) {
            case THNChildEditViewBoarderTop:
                break;
                
            case THNChildEditViewBoarderLeft:
                neighborRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame) - offset_X, CGRectGetHeight(neighborView.frame));
                
                if (CGRectGetWidth(neighborRect) < kMinWidth && (offset_X > 0)) {
                    neighborRect.size.width = kMinWidth;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(childView.frame), CGRectGetMaxX(childView.frame) - CGRectGetMinX(neighborView.frame), CGRectGetHeight(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderDown:
                break;
                
            case THNChildEditViewBoarderRight:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame) + offset_X, CGRectGetHeight(neighborView.frame));
                
                if (CGRectGetWidth(neighborRect) < kMinWidth && (offset_X < 0)) {
                    neighborRect.size.width = kMinWidth;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMaxX(neighborView.frame), CGRectGetMinY(childView.frame), CGRectGetMaxX(childView.frame) - CGRectGetMaxX(neighborView.frame), CGRectGetHeight(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
        }
        
        if (CGRectGetWidth(neighborRect) < kMinWidth) {
            neighborRect.size.width = kMinWidth;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
            return;
            
        } else {
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
    }
}

#pragma mark 上边框
- (void)thn_touchesMovedChildViewBoarderTop:(THNEditChildView *)childView offsetY:(CGFloat)offset_Y {
    if ([childView.topArray[0] isEqualToString:@"0"]) {
        return;
    }
    
    CGRect currentOldRect = childView.frame;
    //  视图太小时禁止拖动
    if ((CGRectGetHeight(currentOldRect) <= kMinHeight) && (offset_Y > 0)) {
        currentOldRect.size.height = kMinHeight;
        childView.frame = currentOldRect;
        childView.oldRect = currentOldRect;
        return;
        
    } else {
        for (NSString *neighbor in childView.topArray) {
            if ([neighbor isEqualToString:@"0"]) {
                break;
            }
            NSArray *component = [neighbor componentsSeparatedByString:@"."];
            THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
            CGRect neighborRect = neighborView.frame;
            
            switch ([component[1] integerValue]) {
                case THNChildEditViewBoarderTop:
                    if (CGRectGetHeight(neighborRect) <= kMinHeight && (offset_Y > 0)) {
                        neighborRect.size.height = kMinHeight;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderLeft:
                    break;
                    
                case THNChildEditViewBoarderDown:
                    if (CGRectGetHeight(neighborRect) <= kMinHeight && (offset_Y < 0)) {
                        neighborRect.size.height = kMinHeight;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderRight:
                    break;
            }
            
            if (self.reachSmallest) {
                break;
            }
        }
        
        if (self.reachSmallest) {
            return;
        }
    }
    
    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(childView.frame) + offset_Y, CGRectGetWidth(childView.frame), CGRectGetHeight(childView.frame) - offset_Y);
    
    if (CGRectGetHeight(currentOldRect) < kMinHeight) {
        currentOldRect.size.height = kMinHeight;
    }
    childView.frame = currentOldRect;
    childView.oldRect = currentOldRect;
    
    //  更新相邻的视图
    [self thn_updateChildViewNeighborTop:childView oldRect:currentOldRect offsetY:offset_Y];
}

- (void)thn_updateChildViewNeighborTop:(THNEditChildView *)childView oldRect:(CGRect)currentOldRect offsetY:(CGFloat)offset_Y  {
    for (NSString *neighbor in childView.topArray) {
        if ([neighbor isEqualToString:@"0"]) {
            break;
        }
        
        NSArray *component = [neighbor componentsSeparatedByString:@"."];
        THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
        CGRect neighborRect = neighborView.frame;
        
        if (CGRectGetHeight(neighborRect) < kMinHeight) {
            neighborRect.size.height = kMinHeight;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
        
        if (CGRectGetWidth(neighborRect) < kMinHeight) {
            return;
        }
        
        switch ([component[1] integerValue]) {
            case THNChildEditViewBoarderTop:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame) + offset_Y, CGRectGetWidth(neighborView.frame), CGRectGetHeight(neighborView.frame) - offset_Y);
                
                if (CGRectGetHeight(neighborRect) < kMinHeight && (offset_Y > 0)) {
                    neighborRect.size.height = kMinHeight;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(childView.frame), CGRectGetMaxY(childView.frame) - CGRectGetMinY(neighborView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderLeft:
                break;
                
            case THNChildEditViewBoarderDown:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame), CGRectGetHeight(neighborView.frame) + offset_Y);
                
                if (CGRectGetHeight(neighborRect) < kMinHeight && (offset_Y < 0)) {
                    neighborRect.size.height = kMinHeight;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMaxY(neighborView.frame), CGRectGetWidth(childView.frame), CGRectGetMaxY(childView.frame) - CGRectGetMaxY(neighborView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderRight:
                break;
        }
        
        if (CGRectGetHeight(neighborRect) < kMinHeight) {
            neighborRect.size.height = kMinHeight;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
            return;
            
        } else {
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
    }
}

#pragma mark 下边框
- (void)thn_touchesMovedChildViewBoarderDown:(THNEditChildView *)childView offsetY:(CGFloat)offset_Y {
    if ([childView.bottomArray[0] isEqualToString:@"0"])return;
    CGRect currentOldRect = childView.frame;
    //  视图太小时禁止拖动
    if ((CGRectGetHeight(currentOldRect) <= kMinHeight) && (offset_Y < 0)) {
        currentOldRect.size.height = kMinHeight;
        childView.frame = currentOldRect;
        childView.oldRect = currentOldRect;
        return;
        
    } else {
        for (NSString *neighbor in childView.bottomArray) {
            if ([neighbor isEqualToString:@"0"]) {
                break;
            }
            
            NSArray *component = [neighbor componentsSeparatedByString:@"."];
            THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
            CGRect neighborRect = neighborView.frame;
            switch ([component[1] integerValue]) {
                case THNChildEditViewBoarderTop:
                    if (CGRectGetHeight(neighborRect) <= kMinHeight && (offset_Y > 0)) {
                        neighborRect.size.height = kMinHeight;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderLeft:
                    break;
                    
                case THNChildEditViewBoarderDown:
                    if (CGRectGetHeight(neighborRect) <= kMinHeight && (offset_Y < 0)) {
                        neighborRect.size.height = kMinHeight;
                        neighborView.frame = neighborRect;
                        neighborView.oldRect = neighborRect;
                        self.reachSmallest = YES;
                        break;
                    }
                    break;
                    
                case THNChildEditViewBoarderRight:
                    break;
            }
            
            if (self.reachSmallest) {
                break;
            }
        }
        
        if (self.reachSmallest) {
            return;
        }
    }
    
    currentOldRect.size.height += offset_Y;
    if (CGRectGetHeight(currentOldRect) < kMinHeight) {
        currentOldRect.size.height = kMinHeight;
    }
    childView.frame = currentOldRect;
    childView.oldRect = currentOldRect;
    
    //  更新相邻的视图
    [self thn_updateChildViewNeighborDown:childView oldRect:currentOldRect offsetY:offset_Y];
}

- (void)thn_updateChildViewNeighborDown:(THNEditChildView *)childView oldRect:(CGRect)currentOldRect offsetY:(CGFloat)offset_Y {
    for (NSString *neighbor in childView.bottomArray) {
        if ([neighbor isEqualToString:@"0"]) {
            break;
        }
        
        NSArray *component = [neighbor componentsSeparatedByString:@"."];
        THNEditChildView *neighborView = [self viewAccordingToTag:[component[0] integerValue]];
        CGRect neighborRect = neighborView.frame;
        
        if (CGRectGetHeight(neighborRect) < kMinHeight) {
            neighborRect.size.height = kMinHeight;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
        
        if (CGRectGetWidth(neighborRect) < kMinHeight) {
            return;
        }
        
        switch ([component[1] integerValue]) {
            case THNChildEditViewBoarderTop:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame) + offset_Y, CGRectGetWidth(neighborView.frame), CGRectGetHeight(neighborView.frame) - offset_Y);
                
                if (CGRectGetHeight(neighborRect) < kMinHeight && (offset_Y > 0)) {
                    neighborRect.size.height = kMinHeight;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(childView.frame), CGRectGetWidth(childView.frame), CGRectGetMinY(neighborView.frame) - CGRectGetMinY(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderLeft:
                break;
                
            case THNChildEditViewBoarderDown:
                neighborRect = CGRectMake(CGRectGetMinX(neighborView.frame), CGRectGetMinY(neighborView.frame), CGRectGetWidth(neighborView.frame), CGRectGetHeight(neighborView.frame) + offset_Y);
                
                if (CGRectGetHeight(neighborRect) < kMinHeight && (offset_Y < 0)) {
                    neighborRect.size.height = kMinHeight;
                    neighborView.frame = neighborRect;
                    neighborView.oldRect = neighborRect;
                    
                    currentOldRect = CGRectMake(CGRectGetMinX(childView.frame), CGRectGetMinY(childView.frame), CGRectGetWidth(childView.frame), CGRectGetMaxY(neighborView.frame) - CGRectGetMinY(childView.frame));
                    childView.frame = currentOldRect;
                    childView.oldRect = currentOldRect;
                }
                break;
                
            case THNChildEditViewBoarderRight:
                break;
        }
        
        if (CGRectGetHeight(neighborRect) < kMinHeight) {
            neighborRect.size.height = kMinHeight;
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
            return;
        } else {
            neighborView.frame = neighborRect;
            neighborView.oldRect = neighborRect;
        }
    }
}

#pragma mark - 根据标识显示视图
- (THNEditChildView *)viewAccordingToTag:(NSInteger)tag {
    self.firstView = self.contentViewArray[0];
    self.secondView = self.contentViewArray[1];
    self.thirdView = self.contentViewArray[2];
    self.fourthView = self.contentViewArray[3];
    self.fifthView = self.contentViewArray[4];
    self.sixthView = self.contentViewArray[5];
    self.sevenView = self.contentViewArray[6];
    self.eightView = self.contentViewArray[7];
    self.nineView = self.contentViewArray[8];
    
    switch (tag) {
        case 51:
            return self.firstView;
            break;
        case 52:
            return self.secondView;
            break;
        case 53:
            return self.thirdView;
            break;
        case 54:
            return self.fourthView;
            break;
        case 55:
            return self.fifthView;
            break;
        case 56:
            return self.sixthView;
            break;
        case 57:
            return self.sevenView;
            break;
        case 58:
            return self.eightView;
            break;
        case 59:
            return self.nineView;
            break;
        default:
            return nil;
            break;
    }
}

#pragma mark 计算frame 超出范围的等比缩小成相应大小
- (CGRect)thn_rectWithArray:(NSArray *)array andSuperSize:(CGSize)superSize {
    CGRect rect = CGRectZero;
    CGFloat minX = INT_MAX;
    CGFloat maxX = 0;
    CGFloat minY = INT_MAX;
    CGFloat maxY = 0;
    for (int i = 0; i < [array count]; i++) {
        NSString *pointString = [array objectAtIndex:i];
        CGPoint point = CGPointFromString(pointString);
        if (point.x <= minX) {
            minX = point.x;
        }
        if (point.x >= maxX) {
            maxX = point.x;
        }
        if (point.y <= minY) {
            minY = point.y;
        }
        if (point.y >= maxY) {
            maxY = point.y;
        }
        rect = CGRectMake(minX, minY, maxX - minX, maxY - minY);
    }
    rect = [THNEditContentView thn_rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
    return rect;
}

#pragma mark -
+ (CGRect)thn_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x / scale;
    retRect.origin.y = rect.origin.y / scale;
    retRect.size.width = rect.size.width / scale;
    retRect.size.height = rect.size.height / scale;
    return  retRect;
}

+ (CGPoint)thn_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x / scale;
    retPointt.y = point.y / scale;
    return  retPointt;
}


+ (CGSize)thn_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width / scale;
    retSize.height = size.height / scale;
    return  retSize;
}

#pragma mark - 初始化子视图
- (void)thn_addChildView {
    [self addSubview:self.firstView];
    [self addSubview:self.secondView];
    [self addSubview:self.thirdView];
    [self addSubview:self.fourthView];
    [self addSubview:self.fifthView];
    [self addSubview:self.sixthView];
    [self addSubview:self.sevenView];
    [self addSubview:self.eightView];
    [self addSubview:self.nineView];
}

- (THNEditChildView *)firstView {
    if (!_firstView) {
        _firstView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _firstView.tag = kChildViewInitTag;
    }
    return _firstView;
}

- (THNEditChildView *)secondView {
    if (!_secondView) {
        _secondView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _secondView.tag = kChildViewInitTag + 1;
    }
    return _secondView;
}

- (THNEditChildView *)thirdView {
    if (!_thirdView) {
        _thirdView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _thirdView.tag = kChildViewInitTag + 2;
    }
    return _thirdView;
}

- (THNEditChildView *)fourthView {
    if (!_fourthView) {
        _fourthView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _fourthView.tag = kChildViewInitTag + 3;
    }
    return _fourthView;
}

- (THNEditChildView *)fifthView {
    if (!_fifthView) {
        _fifthView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _fifthView.tag = kChildViewInitTag + 4;
    }
    return _fifthView;
}

- (THNEditChildView *)sixthView {
    if (!_sixthView) {
        _sixthView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _sixthView.tag = kChildViewInitTag + 5;
    }
    return _sixthView;
}

- (THNEditChildView *)sevenView {
    if (!_sevenView) {
        _sevenView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _sevenView.tag = kChildViewInitTag + 6;
    }
    return _sevenView;
}

- (THNEditChildView *)eightView {
    if (!_eightView) {
        _eightView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _eightView.tag = kChildViewInitTag + 7;
    }
    return _eightView;
}

- (THNEditChildView *)nineView {
    if (!_nineView) {
        _nineView = [[THNEditChildView alloc] initWithFrame:CGRectZero];
        _nineView.tag = kChildViewInitTag + 8;
    }
    return _nineView;
}

#pragma mark - Array
- (void)thn_arrayAddViewObject {
    if (self.contentViewArray.count) {
        return;
    }
    [self.contentViewArray addObject:self.firstView];
    [self.contentViewArray addObject:self.secondView];
    [self.contentViewArray addObject:self.thirdView];
    [self.contentViewArray addObject:self.fourthView];
    [self.contentViewArray addObject:self.fifthView];
    [self.contentViewArray addObject:self.sixthView];
    [self.contentViewArray addObject:self.sevenView];
    [self.contentViewArray addObject:self.eightView];
    [self.contentViewArray addObject:self.nineView];
}

- (NSMutableArray *)contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [NSMutableArray array];
    }
    return _contentViewArray;
}

@end
