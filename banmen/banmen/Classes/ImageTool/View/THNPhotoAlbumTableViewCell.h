//
//  THNPhotoAlbumTableViewCell.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNPhotoTool.h"

@interface THNPhotoAlbumTableViewCell : UITableViewCell

/**
 相册封面图
 */
@property (nonatomic, strong) UIImageView *coverImageView;

/**
 相册名称
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 相册内照片数量
 */
@property (nonatomic, strong) UILabel *countLabel;

/**
 绑定相册信息数据

 @param albumInfo 相册信息
 */
- (void)thn_setPhotoAlbumInfoData:(THNPhotoAlbumList *)albumInfo;

@end
