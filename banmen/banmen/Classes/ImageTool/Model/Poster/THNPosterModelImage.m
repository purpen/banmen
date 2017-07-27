//
//  THNPosterModelImage.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelImage.h"

NSString *const kPosterModelImageName = @"name";
NSString *const kPosterModelImageZindex = @"zindex";
NSString *const kPosterModelImageType = @"type";
NSString *const kPosterModelImageWidth = @"width";
NSString *const kPosterModelImageHeight = @"height";
NSString *const kPosterModelImagePosition = @"position";
NSString *const kPosterModelImageImageUrl = @"imageUrl";

@implementation THNPosterModelImage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelImageZindex] isKindOfClass:[NSNull class]]) {
        self.zindex = [dictionary[kPosterModelImageZindex] integerValue];
    }
    
    if (![dictionary[kPosterModelImageName] isKindOfClass:[NSNull class]]) {
        self.name = dictionary[kPosterModelImageName];
    }
    
    if (![dictionary[kPosterModelImageImageUrl] isKindOfClass:[NSNull class]]) {
        self.imageUrl = dictionary[kPosterModelImageImageUrl];
    }
    
    if (![dictionary[kPosterModelImageType] isKindOfClass:[NSNull class]]) {
        self.type = [dictionary[kPosterModelImageType] integerValue];
    }
    
    if (![dictionary[kPosterModelImageWidth] isKindOfClass:[NSNull class]]) {
        self.width = [dictionary[kPosterModelImageWidth] floatValue];
    }
    
    if (![dictionary[kPosterModelImageHeight] isKindOfClass:[NSNull class]]) {
        self.height = [dictionary[kPosterModelImageHeight] floatValue];
    }
    
    if (![dictionary[kPosterModelImagePosition] isKindOfClass:[NSNull class]]) {
        self.position = [[THNPosterModelImagePosition alloc] initWithDictionary:dictionary[kPosterModelImagePosition]];
    }
    
    return self;
}

@end
