//
//  THNShowPuzzleView.m
//  banmen
//
//  Created by FLYang on 2017/6/28.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNShowPuzzleView.h"
#import <Photos/Photos.h>
#import "THNAssetItem.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNShowPuzzleView ()

@end

@implementation THNShowPuzzleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame tag:0];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame tag:(NSInteger)tag {
    self = [super initWithFrame:frame];
    if (self) {
        self.styleTag = tag;
        [self thn_initViewUI];
    }
    return self;
}

#pragma mark - 初始化视图
- (void)thn_initViewUI {
    self.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    
    [self.imageViewArray addObject:self.firstView];
    [self.imageViewArray addObject:self.secondView];
    [self.imageViewArray addObject:self.thirdView];
    [self.imageViewArray addObject:self.fourthView];
    [self.imageViewArray addObject:self.fifthView];
    [self.imageViewArray addObject:self.sixthView];
    
    [self thn_resetAllImageView];
    
    [self thn_addImageView];
}

#pragma mark - 初始化图片视图样式
- (void)thn_resetAllImageView {
    [self thn_setImageViewStyle:self.firstView];
    [self thn_setImageViewStyle:self.secondView];
    [self thn_setImageViewStyle:self.thirdView];
    [self thn_setImageViewStyle:self.fourthView];
    [self thn_setImageViewStyle:self.fifthView];
    [self thn_setImageViewStyle:self.sixthView];
}

- (void)thn_setImageViewStyle:(UIImageView *)imageView {
    imageView.frame = CGRectZero;
    imageView.image = nil;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    imageView.userInteractionEnabled = YES;
}

#pragma mark - 添加图片视图
- (void)thn_addImageView {
    [self addSubview:self.firstView];
    [self addSubview:self.secondView];
    [self addSubview:self.thirdView];
    [self addSubview:self.fourthView];
    [self addSubview:self.fifthView];
    [self addSubview:self.sixthView];
}

#pragma mark - 设置样式
- (void)thn_setPuzzleViewStyleData:(NSMutableArray *)array styleTag:(NSInteger)tag {
    _styleTag = tag;
    _styleFileName = nil;
    NSString *picCountFlag = @"";
    _photoAssetArray = [NSMutableArray arrayWithArray:array];
    
    switch (_photoAssetArray.count) {
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
        default:
            break;
    }
    
    if (![picCountFlag isEqualToString:@""]) {
        _styleFileName = [NSString stringWithFormat:@"%@_style_%li", picCountFlag, _styleTag];
        _styleDict = nil;
        _styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_styleFileName ofType:@"plist"]];
        if (_styleDict) {
            [self thn_resetAllImageView];
            [self thn_resetStyle];
        }
    }
}

#pragma mark - 设置布局样式
- (void)thn_resetStyle {
//    NSLog(@"========================== 样式的配置信息：%@", _styleDict);
    if(_styleDict) {
        PHImageRequestOptions * requestOption = [[PHImageRequestOptions alloc] init];
        requestOption.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        CGSize superSize = CGSizeFromString([[_styleDict objectForKey:@"SuperViewInfo"] objectForKey:@"size"]);
        superSize = [THNShowPuzzleView thn_sizeScaleWithSize:superSize scale:2.0f];
        NSArray *subViewArray = [_styleDict objectForKey:@"SubViewArray"];
        if (self.photoAssetArray.count < subViewArray.count) {
            NSInteger difference = subViewArray.count - self.photoAssetArray.count;
            for (NSInteger i = 0; i < difference; i++) {
                THNAssetItem *item = self.photoAssetArray.lastObject;
                [self.photoAssetArray addObject:item];
            }
        }
        
        for(NSInteger j = 0; j < subViewArray.count; j++) {
            CGRect rect = CGRectZero;
            UIBezierPath *path = nil;
            THNAssetItem *item = [self.photoAssetArray objectAtIndex:j];
            NSDictionary *subDict = [subViewArray objectAtIndex:j];
            rect = [self thn_rectWithArray:[subDict objectForKey:@"pointArray"] andSuperSize:superSize];
            
            if ([subDict objectForKey:@"pointArray"]) {
                NSArray *pointArray = [subDict objectForKey:@"pointArray"];
                path = [UIBezierPath bezierPath];
                if (pointArray.count > 2) { //  当点的数量大于2个的时候
                    //  生成点的坐标
                    for(int i = 0; i < [pointArray count]; i++) {
                        NSString *pointString = [pointArray objectAtIndex:i];
                        if (pointString) {
                            CGPoint point = CGPointFromString(pointString);
                            point = [THNShowPuzzleView thn_pointScaleWithPoint:point scale:2.0f];
                            point.x = (point.x) * self.frame.size.width/superSize.width - rect.origin.x;
                            point.y = (point.y) * self.frame.size.height/superSize.height - rect.origin.y;
                            if (i == 0) {
                                [path moveToPoint:point];
                            } else {
                                [path addLineToPoint:point];
                            }
                        }
                    }
                } else {
                    //  当点的左边不能形成一个面的时候  至少三个点的时候 就是一个正规的矩形
                    //  点的坐标就是rect的四个角
                    [path moveToPoint:CGPointMake(0, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
                    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
                    [path addLineToPoint:CGPointMake(0, rect.size.height)];
                }
                [path closePath];
            }
            if (j < _imageViewArray.count) {
                UIImageView *imageView = (UIImageView *)[_imageViewArray objectAtIndex:j];
                imageView.frame = rect;
                imageView.backgroundColor = [UIColor clearColor];
                [[PHImageManager defaultManager] requestImageForAsset:item.asset targetSize:CGSizeMake(150, 150) contentMode:PHImageContentModeAspectFill options:requestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    imageView.image = result;
                }];
            }
        }
    }
}

#pragma mark 样式尺寸大小等相关设置
+ (CGRect)thn_rectScaleWithRect:(CGRect)rect scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGRect retRect = CGRectZero;
    retRect.origin.x = rect.origin.x/scale;
    retRect.origin.y = rect.origin.y/scale;
    retRect.size.width = rect.size.width/scale;
    retRect.size.height = rect.size.height/scale;
    return retRect;
}

+ (CGSize)thn_sizeScaleWithSize:(CGSize)size scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGSize retSize = CGSizeZero;
    retSize.width = size.width/scale;
    retSize.height = size.height/scale;
    return retSize;
}

+ (CGPoint)thn_pointScaleWithPoint:(CGPoint)point scale:(CGFloat)scale {
    if (scale <= 0) {
        scale = 1.0f;
    }
    CGPoint retPointt = CGPointZero;
    retPointt.x = point.x/scale;
    retPointt.y = point.y/scale;
    return retPointt;
}

#pragma mark 根据frame超出范围等比缩小
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
    
    rect = [THNShowPuzzleView thn_rectScaleWithRect:rect scale:2.0f];
    rect.origin.x = rect.origin.x * self.frame.size.width/superSize.width;
    rect.origin.y = rect.origin.y * self.frame.size.height/superSize.height;
    rect.size.width = rect.size.width * self.frame.size.width/superSize.width;
    rect.size.height = rect.size.height * self.frame.size.height/superSize.height;
    return rect;
}

#pragma mark - init
- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

- (UIImageView *)firstView {
    if (!_firstView) {
        _firstView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _firstView;
}

- (UIImageView *)secondView {
    if (!_secondView) {
        _secondView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _secondView;
}

- (UIImageView *)thirdView {
    if (!_thirdView) {
        _thirdView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _thirdView;
}

- (UIImageView *)fourthView {
    if (!_fourthView) {
        _fourthView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _fourthView;
}

- (UIImageView *)fifthView {
    if (!_fifthView) {
        _fifthView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _fifthView;
}

- (UIImageView *)sixthView {
    if (!_sixthView) {
        _sixthView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _sixthView;
}

@end
