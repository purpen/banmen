//
//  THNLayoutViewController.h
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNImageToolViewController.h"

@interface THNLayoutViewController : THNImageToolViewController

/**
 图片链接加载拼图
 
 @param imageUrlArray 图片链接
 */
- (void)thn_loadProductImageUrlForLayout:(NSArray *)imageUrlArray goodsTitle:(NSString *)title;

@end
