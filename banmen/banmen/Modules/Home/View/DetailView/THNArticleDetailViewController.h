//
//  THNArticleDetailViewController.h
//  banmen
//
//  Created by dong on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "BaseViewController.h"
#import "THNGoodsArticleModel.h"

@interface THNArticleDetailViewController : BaseViewController

@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) THNGoodsArticleModel *model;

@end
