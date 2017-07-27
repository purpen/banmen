//
//  THNPosterModelImagePosition.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelImagePosition.h"

NSString *const kPosterModelImagePositionTop = @"top";
NSString *const kPosterModelImagePositionBottom = @"bottom";
NSString *const kPosterModelImagePositionLeft = @"left";
NSString *const kPosterModelImagePositionRight = @"right";

@implementation THNPosterModelImagePosition

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelImagePositionTop] isKindOfClass:[NSNull class]]) {
        self.top = [dictionary[kPosterModelImagePositionTop] floatValue];
    }
    
    if (![dictionary[kPosterModelImagePositionBottom] isKindOfClass:[NSNull class]]) {
        self.bottom = [dictionary[kPosterModelImagePositionBottom] floatValue];
    }
    
    if (![dictionary[kPosterModelImagePositionLeft] isKindOfClass:[NSNull class]]) {
        self.left = [dictionary[kPosterModelImagePositionLeft] floatValue];
    }
    
    if (![dictionary[kPosterModelImagePositionRight] isKindOfClass:[NSNull class]]) {
        self.right = [dictionary[kPosterModelImagePositionRight] floatValue];
    }
    
    return self;
}

@end
