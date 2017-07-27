//
//  THNPosterModelData.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModelData.h"

NSString *const kPosterModelText = @"text";
NSString *const kPosterModelSize = @"size";
NSString *const kPosterModelImage = @"image";
NSString *const kPosterModelidField = @"idField";

@implementation THNPosterModelData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelidField] isKindOfClass:[NSNull class]]) {
        self.idField = dictionary[kPosterModelidField];
    }
    
    if (![dictionary[kPosterModelSize] isKindOfClass:[NSNull class]]) {
        self.size = [[THNPosterModelSize alloc] initWithDictionary:dictionary[kPosterModelSize]];
    }
    
    if (dictionary[kPosterModelText] != nil && [dictionary[kPosterModelText] isKindOfClass:[NSArray class]]){
        NSArray *textDictionaries = dictionary[kPosterModelText];
        NSMutableArray *textItems = [NSMutableArray array];
        for(NSDictionary *textDictionary in textDictionaries){
            THNPosterModelText *textItem = [[THNPosterModelText alloc] initWithDictionary:textDictionary];
            [textItems addObject:textItem];
        }
        self.text = textItems;
    }
    
    if (dictionary[kPosterModelImage] != nil && [dictionary[kPosterModelImage] isKindOfClass:[NSArray class]]){
        NSArray *imageDictionaries = dictionary[kPosterModelImage];
        NSMutableArray *imageItems = [NSMutableArray array];
        for(NSDictionary *imageDictionary in imageDictionaries){
            THNPosterModelImage *imageItem = [[THNPosterModelImage alloc] initWithDictionary:imageDictionary];
            [imageItems addObject:imageItem];
        }
        self.image = imageItems;
    }
    
    return self;
}

@end
