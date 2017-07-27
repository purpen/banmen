//
//  THNPosterModelImagePosition.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNPosterModelImagePosition : NSObject

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
