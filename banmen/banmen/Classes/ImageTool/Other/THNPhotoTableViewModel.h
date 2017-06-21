//
//  THNPhotoTableViewModel.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "THNPhotoCellViewModel.h"

@interface THNPhotoTableViewModel : NSObject <
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic, strong) NSMutableArray<THNPhotoCellViewModel *> *cellModelArray;

@end
