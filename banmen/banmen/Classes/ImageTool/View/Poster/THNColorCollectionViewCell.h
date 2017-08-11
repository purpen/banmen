//
//  THNColorCollectionViewCell.h
//  banmen
//
//  Created by FLYang on 2017/8/11.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THNColorCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIView *backView;

- (void)thn_setColorInfo:(NSString *)color;

@end
