//
//  THNPosterModelText.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelText.h"

NSString *const kPosterModelTextAlign = @"align";
NSString *const kPosterModelTextContent = @"content";
NSString *const kPosterModelTextZindex = @"zindex";
NSString *const kPosterModelTextColor = @"color";
NSString *const kPosterModelTextFontSize = @"fontSize";
NSString *const kPosterModelTextFontBold = @"fontBold";
NSString *const kPosterModelTextWidth = @"width";
NSString *const kPosterModelTextHeight = @"height";
NSString *const kPosterModelTextPosition = @"position";

@implementation THNPosterModelText

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelTextAlign] isKindOfClass:[NSNull class]]) {
        self.align = [dictionary[kPosterModelTextAlign] integerValue];
    }
    
    if (![dictionary[kPosterModelTextContent] isKindOfClass:[NSNull class]]) {
        self.content = dictionary[kPosterModelTextContent];
    }
    
    if (![dictionary[kPosterModelTextZindex] isKindOfClass:[NSNull class]]) {
        self.zindex = [dictionary[kPosterModelTextZindex] integerValue];
    }
    
    if (![dictionary[kPosterModelTextColor] isKindOfClass:[NSNull class]]) {
        self.color = dictionary[kPosterModelTextColor];
    }
    
    if (![dictionary[kPosterModelTextFontSize] isKindOfClass:[NSNull class]]) {
        self.fontSize = [dictionary[kPosterModelTextFontSize] floatValue];
    }
    
    if (![dictionary[kPosterModelTextFontBold] isKindOfClass:[NSNull class]]) {
        self.fontBold = [dictionary[kPosterModelTextFontBold] integerValue];
    }
    
    if (![dictionary[kPosterModelTextWidth] isKindOfClass:[NSNull class]]) {
        self.width = [dictionary[kPosterModelTextWidth] floatValue];
    }
    
    if (![dictionary[kPosterModelTextHeight] isKindOfClass:[NSNull class]]) {
        self.height = [dictionary[kPosterModelTextHeight] floatValue];
    }
    
    if (![dictionary[kPosterModelTextPosition] isKindOfClass:[NSNull class]]) {
        self.position = [[THNPosterModelTextPosition alloc] initWithDictionary:dictionary[kPosterModelTextPosition]];
    }
    
    return self;
}

@end
