//
//  THNPhotoListView.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPhotoListView.h"
#import "THNPhotoAlbumTableViewCell.h"
#import "THNPhotoItemCollectionViewCell.h"

static NSString *const PhotoAlbumTableCellId = @"THNPhotoAlbumTableViewCellId";
static NSString *const PhotoItemCollectionCellId = @"THNPhotoItemCollectionViewCellId";

@interface THNPhotoListView ()

@property (nonatomic, strong) NSMutableArray *photoAlbumArray;
@property (nonatomic, strong) NSMutableArray *photoAssetArray;

@end

@implementation THNPhotoListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorPhotoAlbum alpha:1];
        [self thn_setViewUI];
    }
    return self;
}

- (void)thn_setViewUI {
    [self thn_addViewTopBorder];
    
    [self addSubview:self.openAlbum];
    [_openAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self).with.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self addSubview:self.photoColleciton];
    [_photoColleciton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(44);
    }];
    
    [self addSubview:self.photoAlbumTable];
}

#pragma mark - 绘制上边框
- (void)thn_addViewTopBorder {
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.5);
    topBorder.backgroundColor = [UIColor colorWithHexString:@"#555555"].CGColor;
    [self.layer addSublayer:topBorder];
}

#pragma mark - 展开相册列表的按钮
- (UIButton *)openAlbum {
    if (!_openAlbum) {
        _openAlbum = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_openAlbum setTitle:@"相机胶卷" forState:(UIControlStateNormal)];
        [_openAlbum setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
        _openAlbum.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _openAlbum.selected = NO;
        [_openAlbum addTarget:self action:@selector(openOrClosePhotoAlbumTable:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _openAlbum;
}

- (void)openOrClosePhotoAlbumTable:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
        [self thn_showPhotoAlbumTableView:NO];
    } else {
        button.selected = YES;
        [self thn_showPhotoAlbumTableView:YES];
    }
}

#pragma mark - 毛玻璃遮罩
- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleDark)];
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    return _visualEffectView;
}

#pragma mark - 相册列表
- (UITableView *)photoAlbumTable {
    if (!_photoAlbumTable) {
        _photoAlbumTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0) style:(UITableViewStylePlain)];
        _photoAlbumTable.backgroundColor = [UIColor colorWithHexString:kColorWhite alpha:0];
        _photoAlbumTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _photoAlbumTable.delegate = self;
        _photoAlbumTable.dataSource = self;
        _photoAlbumTable.tableFooterView = [UIView new];
        _photoAlbumTable.backgroundView = self.visualEffectView;
    }
    return _photoAlbumTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photoAlbumArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THNPhotoAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PhotoAlbumTableCellId];
    cell = [[THNPhotoAlbumTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:PhotoAlbumTableCellId];
    if (self.photoAlbumArray.count) {
        [cell thn_setPhotoAlbumInfoData:self.photoAlbumArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark 展开／关闭相册列表
- (void)thn_showPhotoAlbumTableView:(BOOL)show {
    CGRect photoAlbumTableRect = self.photoAlbumTable.frame;
    CGRect openRect = CGRectMake(0, 44, SCREEN_WIDTH, self.bounds.size.height - 44);
    CGRect closeRect = CGRectMake(0, 44, SCREEN_WIDTH, 0);
    if (show) {
        photoAlbumTableRect = openRect;
    } else {
        photoAlbumTableRect = closeRect;
    }
    [UIView animateWithDuration:.3 animations:^{
        self.photoAlbumTable.frame = photoAlbumTableRect;
    }];
}

#pragma mark 加载相册列表的数据
- (void)thn_getPhotoAlbumListData:(NSMutableArray *)albumArray {
    self.photoAlbumArray = albumArray;
    [self.photoAlbumTable reloadData];
}

#pragma mark - 所有的相片列表
- (UICollectionView *)photoColleciton {
    if (!_photoColleciton) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 2.0f;
        flowLayout.minimumLineSpacing = 2.0f;
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 10) / 4, (SCREEN_WIDTH - 10) / 4);
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        _photoColleciton = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _photoColleciton.backgroundColor = [UIColor colorWithHexString:kColorPhotoAlbum];
        _photoColleciton.delegate = self;
        _photoColleciton.dataSource = self;
        [_photoColleciton registerClass:[THNPhotoItemCollectionViewCell class] forCellWithReuseIdentifier:PhotoItemCollectionCellId];
    }
    return _photoColleciton;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoAssetArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THNPhotoItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PhotoItemCollectionCellId
                                                                                     forIndexPath:indexPath];
    if (self.photoAssetArray.count) {
        [cell thn_setPhotoAssetItemImageData:self.photoAssetArray[indexPath.row]];
    }
    return cell;
}

#pragma mark 加载所有的照片
- (void)thn_getPhotoAssetInAlbumData:(NSMutableArray *)assetArray {
    self.photoAssetArray = assetArray;
    [self.photoColleciton reloadData];
}

@end
