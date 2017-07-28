//
//  THNPosterModelData.h
//  banmen
//
//  Created by FLYang on 2017/7/26.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNPosterModelText.h"
#import "THNPosterModelImage.h"
#import "THNPosterModelSize.h"

@interface THNPosterModelData : NSObject

@property (nonatomic, strong) NSString *idField;
@property (nonatomic, strong) THNPosterModelSize *size;
@property (nonatomic, strong) NSArray *text;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSString *backgroundColor;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
