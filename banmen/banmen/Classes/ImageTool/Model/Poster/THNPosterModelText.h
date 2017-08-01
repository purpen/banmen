//
//  THNPosterModelText.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelTextPosition.h"

@interface THNPosterModelText : NSObject

@property (nonatomic, assign) NSInteger align;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger zindex;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSString *background;
@property (nonatomic, strong) THNPosterModelTextPosition *position;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
