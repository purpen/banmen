//
//  THNPosterModel.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelData.h"

@interface THNPosterModel : NSObject

@property (nonatomic, strong) THNPosterModelData *data;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
