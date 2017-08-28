//
//  THNDownloadFontTool.h
//  banmen
//
//  Created by FLYang on 2017/8/23.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface THNDownloadFontTool : NSObject


/**
 是否已下载字体
 */
+ (BOOL)thn_isDownloadedFont:(NSString *)fontName;

/**
 下载字体
 
 @param fontName 字体名称
 @param progress 下载进度
 @param complete 完成操作
 @param errorMsg 错误操作
 */
+ (void)thn_downLoadFontWithFontName:(NSString *)fontName
                            progress:(void(^)(CGFloat pro))progress
                            complete:(void(^)(void))complete
                            errorMsg:(void(^)(NSString *message))errorMsg;

@end
