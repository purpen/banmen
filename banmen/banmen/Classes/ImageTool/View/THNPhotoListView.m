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
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *const PhotoAlbumTableCellId = @"THNPhotoAlbumTableViewCellId";
static NSString *const PhotoItemCollectionCellId = @"THNPhotoItemCollectionViewCellId";
static NSInteger const kMaxSelectPhotoItem = 6;

@interface THNPhotoListView () <THNOpenAlbumButtonClickDelegate> {
    NSInteger _selectPhotoItem;
}

@property (nonatomic, strong) NSMutableArray<THNPhotoAlbumList *> *photoAlbumArray;
@property (nonatomic, strong) NSMutableArray *photoAssetArray;

@end

@implementation THNPhotoListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorPhotoAlbum alpha:1];
        _selectPhotoItem = 0;
        [self thn_setViewUI];
    }
    return self;
}

- (void)thn_setViewUI {
    [self thn_addViewTopBorder];
    
    [self addSubview:self.openAlbum];
    [_openAlbum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
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
- (THNOpenAlbumButton *)openAlbum {
    if (!_openAlbum) {
        _openAlbum = [[THNOpenAlbumButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _openAlbum.delegate = self;
        [_openAlbum thn_setButtonTitleText:@"相机胶卷" iconImage:@"icon_down_main"];
    }
    return _openAlbum;
}

- (void)thn_albumButtonTouchUpInside:(UIButton *)button {
    if (button.selected) {
        [self thn_showPhotoAlbumTableView:NO];
    } else {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.openAlbum thn_setButtonTitleText:self.photoAlbumArray[indexPath.row].title iconImage:@"icon_down_main"];
    [self thn_showPhotoAlbumTableView:NO];
    [self.openAlbum thn_rotateButtonIcon:NO];
    [self thn_refreshThePhotoListData:self.photoAlbumArray[indexPath.row].assetCOllection];
}

#pragma mark - 重新获取指定相册内的所有照片
- (void)thn_refreshThePhotoListData:(PHAssetCollection *)assetCollection {
    //  获取选中相册内容
    NSArray *selectedPhotoArray = [[THNPhotoTool sharePhotoTool] thn_getAssetOfAssetCollection:assetCollection ascending:NO];
    
    //  保持选中的照片还是选中状态
    NSMutableArray *selectedArray = [NSMutableArray array];
    NSMutableArray *selectedIdentifierArray = [NSMutableArray array];
    for (THNAssetItem *item in self.photoAssetArray) {
        if (item.selected) {
            [selectedArray addObject:item];
            [selectedIdentifierArray addObject:item.asset.localIdentifier];
        }
    }
    
    [self.photoAssetArray removeAllObjects];
    
    _selectPhotoItem = selectedArray.count;
    
    __block NSInteger index = 0;
    [selectedPhotoArray enumerateObjectsUsingBlock:^(PHAsset *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![selectedIdentifierArray containsObject:obj.localIdentifier]) {
            THNAssetItem *item = [THNAssetItem AssetItemWithPHAsset:obj];
            [self.photoAssetArray addObject:item];
        } else {
            [self.photoAssetArray addObject:selectedArray[index ++]];
        }
    }];
    
    [self.photoColleciton reloadData];
}

#pragma mark 展开／关闭相册列表
- (void)thn_showPhotoAlbumTableView:(BOOL)show {
    self.openAlbum.selected = show;
    
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

#pragma mark - 加载相册列表的数据
- (void)thn_getPhotoAlbumListData:(NSMutableArray<THNPhotoAlbumList *> *)albumArray {
    self.photoAlbumArray = albumArray;
    [self.photoAlbumTable reloadData];
}

#pragma mark - 加载相簿内所有的照片数据
- (void)thn_getPhotoAssetInAlbumData:(NSMutableArray<THNAssetItem *> *)assetArray {
    self.photoAssetArray = assetArray;
    [self.photoColleciton reloadData];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    THNAssetItem *item = self.photoAssetArray[indexPath.row];
    item.selected = !item.selected;
    
    if (item.selected) {
        if (_selectPhotoItem == kMaxSelectPhotoItem) {
            item.selected = !item.selected;
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"最多选择 %zi 张照片", _selectPhotoItem]];
            [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            return;
        }
        [self thn_didSelectPhotoItem:self.photoAssetArray[indexPath.row]];
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
    } else {
        [self thn_didDeselectPhotoItem:self.photoAssetArray[indexPath.row]];
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

#pragma mark - 选择了照片
- (void)thn_didSelectPhotoItem:(THNAssetItem *)item {
    _selectPhotoItem += 1;
    
    if ([self.delegate respondsToSelector:@selector(thn_didSelectItemAtPhotoList:)]) {
        [self.delegate thn_didSelectItemAtPhotoList:item];
    }
}

#pragma mark - 取消选择照片
- (void)thn_didDeselectPhotoItem:(THNAssetItem *)item {
    _selectPhotoItem -= 1;

    if ([self.delegate respondsToSelector:@selector(thn_didDeselectItemAtPhotoList:)]) {
        [self.delegate thn_didDeselectItemAtPhotoList:item];
    }
}

@end
