//
//  THNLayoutViewController.h
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNImageToolViewController.h"


/**
 拼接图片的类型

 - THNLayoutViewControllerTypeDefault: 默认相册拼接
 - THNLayoutViewControllerTypeNetwork: 网络图片拼接
 */
typedef NS_ENUM(NSInteger, THNLayoutViewControllerType) {
    THNLayoutViewControllerTypeDefault = 1,
    THNLayoutViewControllerTypeNetwork
};

@interface THNLayoutViewController : THNImageToolViewController

/**
 图片链接加载拼图
 
 @param imageUrlArray 图片链接
 */
- (void)thn_loadProductImageUrlForLayout:(NSArray *)imageUrlArray goodsTitle:(NSString *)title type:(THNLayoutViewControllerType)type;

@end
