//
//  RepositoryView.h
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoryView : UIView

@property(nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *modelAry;
@property (nonatomic, strong) UINavigationController *nav;

@end
