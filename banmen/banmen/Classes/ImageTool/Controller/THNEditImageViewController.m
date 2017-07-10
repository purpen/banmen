//
//  THNEditImageViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditImageViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIColor+Extension.h"
#import "MainMacro.h"

#import "THNDoneImageViewController.h"
#import "THNEditToolCollectionViewCell.h"

static NSString *const editToolCollectionViewCellId = @"THNEditToolCollectionViewCellId";

@interface THNEditImageViewController () <THNImageToolNavigationBarItemsDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *_titleArr;
    NSArray *_iconArr;
}

@property (nonatomic, strong) UICollectionView *editToolCollection;

@end

@implementation THNEditImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_intiTitleAndIconImageNameArray];
}

#pragma mark - 设置视图控件
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.editToolCollection];
}

#pragma mark - 初始化编辑功能按钮标题／图标
- (void)thn_intiTitleAndIconImageNameArray {
    _titleArr = @[@"比例", @"替换", @"边框", @"镜像", @"翻转"];
    _iconArr = @[@"icon_tool_scale", @"icon_tool_replace", @"icon_tool_border", @"icon_tool_mirror", @"icon_tool_flip"];
    
    [self thn_setControllerViewUI];
}

#pragma mark - 图片编辑功能按钮
- (UICollectionView *)editToolCollection {
    if (!_editToolCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 130);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _editToolCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150, SCREEN_WIDTH, 130) collectionViewLayout:flowLayout];
        _editToolCollection.backgroundColor = [UIColor colorWithHexString:kColorBackground];
        _editToolCollection.delegate = self;
        _editToolCollection.dataSource = self;
        _editToolCollection.showsHorizontalScrollIndicator = NO;
        [_editToolCollection registerClass:[THNEditToolCollectionViewCell class] forCellWithReuseIdentifier:editToolCollectionViewCellId];
        
    }
    return _editToolCollection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THNEditToolCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:editToolCollectionViewCellId
                                                                                    forIndexPath:indexPath];
    
    if (_titleArr.count && _iconArr.count) {
        [cell thn_setEditImageToolTitle:_titleArr[indexPath.row] withIcon:_iconArr[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"编辑";
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    THNDoneImageViewController *doneController = [[THNDoneImageViewController alloc] init];
    [self.navigationController pushViewController:doneController animated:YES];
}

@end
