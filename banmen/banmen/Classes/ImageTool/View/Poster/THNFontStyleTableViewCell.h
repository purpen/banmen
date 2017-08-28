//
//  THNFontStyleTableViewCell.h
//  banmen
//
//  Created by FLYang on 2017/8/23.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THNFontStyleDownloadStatus) {
    THNFontStyleDownloadStatusNone = 1,
    THNFontStyleDownloadStatusLoading,
    THNFontStyleDownloadStatusDone
};

@interface THNFontStyleTableViewCell : UITableViewCell

/**
 设置字体样式视图
 
 @param fontName 字体名称
 */
- (void)thn_setFontStyleCellFontName:(NSString *)fontName;

- (void)thn_setFontStyleCellFontName:(NSString *)fontName downloadStatus:(THNFontStyleDownloadStatus)status progress:(CGFloat)pro;

/**
 隐藏已选中的状态图标
 */
- (void)thn_hiddenSelectStyleRow:(BOOL)select;

@end
