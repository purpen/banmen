//
//  MaterialTableViewCell.h
//  banmen
//
//  Created by dong on 2017/7/24.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THNGoodsWorld.h"

@interface MaterialTableViewCell : UITableViewCell

@property (nonatomic, strong) UISegmentedControl *segmentedC;
@property (nonatomic, strong) UIButton *switchingArrangementBtn;
@property (nonatomic, strong) THNGoodsWorld *model;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
