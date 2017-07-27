//
//  THNPosterModelSize.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelSize.h"

NSString *const kPosterModelSizeWidth = @"width";
NSString *const kPosterModelSizeHeight = @"height";

@implementation THNPosterModelSize

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelSizeWidth] isKindOfClass:[NSNull class]]) {
        self.width = [dictionary[kPosterModelSizeWidth] floatValue];
    }
    
    if (![dictionary[kPosterModelSizeHeight] isKindOfClass:[NSNull class]]) {
        self.height = [dictionary[kPosterModelSizeHeight] floatValue];
    }
    
    return self;
}

@end
