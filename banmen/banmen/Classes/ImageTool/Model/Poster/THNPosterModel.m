//
//  THNPosterModel.m
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterModel.h"

NSString *const kPosterModelData = @"data";

@implementation THNPosterModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (![dictionary[kPosterModelData] isKindOfClass:[NSNull class]]) {
        self.data = [[THNPosterModelData alloc] initWithDictionary:dictionary[kPosterModelData]];
    }
    
    return self;
}

@end
