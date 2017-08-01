//
//  THNShareActionView.h
//  banmen
//
//  Created by FLYang on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocialCore/UMSocialCore.h>

@interface THNShareActionView : UIView

/**
 调用分享功能
 
 @param controller 当前所在控制器
 @param object 分享的数据内容
 @param image 分享的图片
 */
- (void)thn_showShareViewController:(UIViewController *)controller
                      messageObject:(UMSocialMessageObject *)object
                         shareImage:(UIImage *)image;

@end
