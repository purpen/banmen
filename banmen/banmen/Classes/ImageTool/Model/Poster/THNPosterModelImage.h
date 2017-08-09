//
//  THNPosterModelImage.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelImagePosition.h"

@interface THNPosterModelImage : NSObject

@property (nonatomic, assign) NSInteger editType;
@property (nonatomic, assign) NSInteger logoType;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) NSInteger zindex;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) THNPosterModelImagePosition *position;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
