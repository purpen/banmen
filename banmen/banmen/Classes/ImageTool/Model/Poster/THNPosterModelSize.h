//
//  THNPosterModelSize.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNPosterModelSize : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
