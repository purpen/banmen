//
//  THNPosterModelTextPosition.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelTextPosition.h"

NSString *const kPosterModelTextPositionTop = @"top";
NSString *const kPosterModelTextPositionBottom = @"bottom";
NSString *const kPosterModelTextPositionLeft = @"left";
NSString *const kPosterModelTextPositionRight = @"right";

@implementation THNPosterModelTextPosition

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelTextPositionTop] isKindOfClass:[NSNull class]]) {
        self.top = [dictionary[kPosterModelTextPositionTop] floatValue];
    }
    
    if (![dictionary[kPosterModelTextPositionBottom] isKindOfClass:[NSNull class]]) {
        self.bottom = [dictionary[kPosterModelTextPositionBottom] floatValue];
    }
    
    if (![dictionary[kPosterModelTextPositionLeft] isKindOfClass:[NSNull class]]) {
        self.left = [dictionary[kPosterModelTextPositionLeft] floatValue];
    }
    
    if (![dictionary[kPosterModelTextPositionRight] isKindOfClass:[NSNull class]]) {
        self.right = [dictionary[kPosterModelTextPositionRight] floatValue];
    }
    
    return self;
}

@end
