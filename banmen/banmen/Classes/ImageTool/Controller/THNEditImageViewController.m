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
#import <Photos/Photos.h>
#import "THNEditChildView.h"
#import "THNEditContentView.h"
#import "THNDoneImageViewController.h"
#import "THNEditToolCollectionViewCell.h"
#import "THNPhotoListView.h"

static NSString *const editToolCollectionViewCellId = @"THNEditToolCollectionViewCellId";

@interface THNEditImageViewController () <THNImageToolNavigationBarItemsDelegate, UICollectionViewDelegate, UICollectionViewDataSource, THNEditChildViewDelegate, THNPhotoListViewDelegate>
{
    BOOL _replace;
}

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, strong) UICollectionView *editToolCollection;
@property (nonatomic, strong) THNEditContentView *editContentView;
@property (nonatomic, assign) CGFloat leftTopX;
@property (nonatomic, assign) CGFloat leftTopY;
@property (nonatomic, assign) CGFloat rightDownX;
@property (nonatomic, assign) CGFloat rightDownY;
@property (nonatomic, strong) NSMutableArray *photoAssets;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger childViewIndex;
@property (nonatomic, assign) BOOL addBorder;
@property (nonatomic, strong) THNEditChildView *tempChildView;
@property (nonatomic, strong) UIButton *doneReplaceButton;

//  相册列表
@property (nonatomic, strong) NSMutableArray<THNAssetItem *> *assets;
@property (nonatomic, retain) NSMutableArray<THNPhotoAlbumList *> *photoAblumTitle;
@property (nonatomic, strong) THNPhotoAlbumList *selectedPhotoAblum;
@property (nonatomic, strong) THNPhotoListView *photoListView;

@end

@implementation THNEditImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
    [self thn_initPuzzleImageContentInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _replace = NO;
    [self thn_getPhotoAlbumData];
    [self thn_intiTitleAndIconImageNameArray];
    [self thn_initEditContentViewKVC];
}

#pragma mark - 设置视图控件
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.editContentView];
    [self.view addSubview:self.editToolCollection];
}

#pragma mark - 拼图图片视图
- (THNEditContentView *)editContentView {
    if (!_editContentView) {
        _editContentView = [[THNEditContentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH) tag:self.styleTag];
        _editContentView.childViewDelegate = self;
    }
    return _editContentView;
}

- (void)thn_initPuzzleImageContentInfo {
    [self.editContentView setPhotoAsset:self.selectedAssetArray];
    [self.editContentView setStyleTag:self.styleTag];
    [self.editContentView.firstView drawInnerBoarder];
    [self.editContentView drawBoarderMiddleView:self.editContentView.firstView];
    [self.editContentView setValue:[NSNumber numberWithInteger:0] forKey:@"childViewIndex"];
}

#pragma mark 选中了子视图
- (void)thn_tapWithEditView:(THNEditChildView *)childView {
    self.tempChildView = childView;
    self.addBorder = NO;
    
    if (_replace == YES) {
        [self.photoListView.photoColleciton reloadData];
    }
    
    [self thn_hiddenEditContentViewBoarder:YES];
}

#pragma mark - 初始化编辑功能按钮标题／图标
- (void)thn_intiTitleAndIconImageNameArray {
    self.titleArr = @[@"替换", @"镜像", @"翻转", @"边框"];
    self.iconArr = @[@"icon_tool_replace", @"icon_tool_mirror", @"icon_tool_flip", @"icon_tool_border"];
    
    [self thn_setControllerViewUI];
}

#pragma mark 图片编辑功能
- (UICollectionView *)editToolCollection {
    if (!_editToolCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 130);
        flowLayout.minimumLineSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _editToolCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH + 64, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH - 64)
                                                 collectionViewLayout:flowLayout];
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
        [cell thn_setEditImageToolTitle:self.titleArr[indexPath.row] withIcon:self.iconArr[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self thn_replaceImage];
            break;
        case 1:
            [self thn_mirrorImage];
            break;
        case 2:
            [self thn_flipImage];
            break;
        case 3:
            [self thn_boarderImage];
            break;
    }
}

#pragma mark 替换照片
- (void)thn_replaceImage {
    _replace = YES;
    [self thn_replaceImageAndChangeViewUI:YES];
}

//  改变成替换图片的UI
- (void)thn_replaceImageAndChangeViewUI:(BOOL)replace {
    NSString *titleText = replace ? @"替换" : @"编辑";
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navBackButton.alpha = replace ? 0 : 1;
        self.navRightItem.alpha = replace ? 0 : 1;
        self.editToolCollection.alpha = replace ? 0 : 1;
        self.navTitle.text = titleText;
        self.doneReplaceButton.alpha = replace ? 1 : 0;
        self.photoListView.alpha = replace ? 1 : 0;
    }];
    
    [self thn_scaleEditContentView:replace];
}

//  缩放拼图预览视图
- (void)thn_scaleEditContentView:(BOOL)scale {
    CGFloat scaleX = scale ? 0.8 : 1;
    CGFloat scaleY = scale ? 0.8 : 1;
    CGFloat pointY = scale ? (SCREEN_WIDTH / 2) + 30 : (SCREEN_WIDTH / 2) + 64;
    CGPoint scalePoint = CGPointMake(self.view.center.x, pointY);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.editContentView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
        self.editContentView.center = scalePoint;
    }];
}

//  替换图片完成按钮
- (UIButton *)doneReplaceButton {
    if (!_doneReplaceButton) {
        _doneReplaceButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 59, 20, 44, 44)];
        [_doneReplaceButton setTitleColor:[UIColor colorWithHexString:kColorMain alpha:1] forState:(UIControlStateNormal)];
        _doneReplaceButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_doneReplaceButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        [_doneReplaceButton setTitle:@"完成" forState:(UIControlStateNormal)];
        _doneReplaceButton.alpha = 0;
        [_doneReplaceButton addTarget:self action:@selector(doneReplaceButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _doneReplaceButton;
}

- (void)doneReplaceButton:(UIButton *)button {
    _replace = NO;
    [self thn_replaceImageAndChangeViewUI:NO];
}

#pragma mark 边框
- (void)thn_boarderImage {
    [self thn_hiddenEditContentViewBoarder:self.addBorder];
    
    self.addBorder = !self.addBorder;
    
    if (self.addBorder) {
        self.leftTopX = self.editContentView.frame.origin.x;
        self.leftTopY = self.editContentView.frame.origin.y - 64;
        self.rightDownX = CGRectGetMaxX(self.editContentView.frame);
        self.rightDownY = CGRectGetMaxY(self.editContentView.frame) - 64;
        for (THNEditChildView *childView in self.editContentView.subviews) {
            [childView clearInnerBoarder];
            [self.editContentView removeBoarderMiddleView:childView];
            [self thn_drawPuzzleViewBoarder:childView];
        }
        [self.editContentView setValue:[NSNumber numberWithInteger:self.childViewIndex] forKey:@"childViewIndex"];
        
    } else {
        for (THNEditChildView *childView in self.editContentView.subviews) {
            [self thn_clearInnerBoarder:childView];
        }
        
        [self.tempChildView drawInnerBoarder];
        [self.editContentView drawBoarderMiddleView:self.tempChildView];
        
        [self.editContentView setValue:[NSNumber numberWithInteger:self.childViewIndex] forKey:@"childViewIndex"];
    }
}

- (void)thn_drawPuzzleViewBoarder:(THNEditChildView *)childEditView {
    if (childEditView.frame.size.width == 0 || childEditView.frame.size.height == 0) {
        return;
    }
    
    if (childEditView.frame.origin.x != self.leftTopX) {
        childEditView.leftBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorWhite];
    }
    
    if (childEditView.frame.origin.y != self.leftTopY) {
        childEditView.topBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorWhite];
    }
    
    if (CGRectGetMaxX(childEditView.frame) != self.rightDownX) {
        childEditView.rightBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorWhite];
    }
    
    if (CGRectGetMaxY(childEditView.frame) != self.rightDownY) {
        childEditView.bottomBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorWhite];
    }
}

- (void)thn_hiddenEditContentViewBoarder:(BOOL)hidden {
    self.editContentView.layer.borderWidth = hidden ? 0 : 4;
    self.editContentView.layer.borderColor = [UIColor colorWithHexString:kColorWhite].CGColor;
}

#pragma mark 镜像
- (void)thn_mirrorImage {
    self.childViewIndex = [[self.editContentView valueForKey:@"childViewIndex"] integerValue];
    THNEditChildView *childView = self.editContentView.contentViewArray[self.childViewIndex];
    
    CGSize contentSize = childView.contentView.contentSize;
    CGPoint contentOffset = childView.contentView.contentOffset;
    CGRect imageViewFrame = childView.loadImageView.frame;
    
    UIImage *image = childView.loadImageView.image;
    
    [childView thn_setImageViewData:[self mirrorWithImage:image]];
    //重置配置
    childView.contentView.contentSize = contentSize;
    childView.contentView.contentOffset = contentOffset;
    childView.loadImageView.frame = imageViewFrame;
}

- (UIImage *)mirrorWithImage:(UIImage *)image {
    UIImage *resultImage;
    if (image.imageOrientation == UIImageOrientationUp) {
        resultImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
    } else {
        resultImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
    }
    return resultImage;
}

#pragma mark 翻转
- (void)thn_flipImage {
    self.childViewIndex = [[self.editContentView valueForKey:@"childViewIndex"] integerValue];
    THNEditChildView *childView = self.editContentView.contentViewArray[self.childViewIndex];
    
    CGSize contentSize = childView.contentView.contentSize;
    CGPoint contentOffset = childView.contentView.contentOffset;
    CGRect imageViewFrame = childView.loadImageView.frame;
    
    UIImage *image = childView.loadImageView.image;
    
    [childView thn_setImageViewData:[self flipWithImage:image]];
    //重置配置
    childView.contentView.contentSize = contentSize;
    childView.contentView.contentOffset = contentOffset;
    childView.loadImageView.frame = imageViewFrame;
}

- (UIImage *)flipWithImage:(UIImage *)image {
    UIImage *resultImage;
    if (image.imageOrientation == UIImageOrientationUp) {
        resultImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationDownMirrored];
    } else {
        resultImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
    }
    return resultImage;
}

#pragma mark - KVC
- (void)thn_initEditContentViewKVC {
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self.editContentView addObserver:self forKeyPath:@"childViewIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self.editContentView setValue:[NSNumber numberWithInteger:0] forKey:@"childViewIndex"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        
        PHAsset *asset = self.photoAssets[[[self valueForKeyPath:@"selectedIndex"] integerValue]];
        [self.selectedAssetArray replaceObjectAtIndex:self.childViewIndex withObject:asset];
        
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        [[PHImageManager defaultManager] requestImageForAsset:asset
                                                   targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)
                                                  contentMode:PHImageContentModeAspectFill
                                                      options:options
                                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                    [self.editContentView.contentViewArray[self.childViewIndex] thn_setImageViewData:result];
                                                }];
    }
    
    if ([keyPath isEqualToString:@"childViewIndex"]) {
        self.childViewIndex = [[self.editContentView valueForKey:@"childViewIndex"] integerValue];
    }
}

- (void)thn_clearInnerBoarder:(THNEditChildView *)childEditView {
    childEditView.leftBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.topBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.rightBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
    childEditView.bottomBoarderLayer.backgroundColor = [UIColor colorWithHexString:kColorMain alpha:0];
}

#pragma mark - 加载相册列表视图
- (THNPhotoListView *)photoListView {
    if (!_photoListView) {
        _photoListView = [[THNPhotoListView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH + 30, SCREEN_WIDTH, SCREEN_HEIGHT - (SCREEN_WIDTH + 30))];
        _photoListView.delegate = self;
        _photoListView.alpha = 0;
    }
    return _photoListView;
}

#pragma mark 选中照片替换拼图照片
- (void)thn_didSelectItemAtPhotoListOfReplace:(THNAssetItem *)item {
    [self.selectedAssetArray replaceObjectAtIndex:self.childViewIndex withObject:item];
    
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager] requestImageForAsset:item.asset
                                               targetSize:CGSizeMake(item.asset.pixelWidth, item.asset.pixelHeight)
                                              contentMode:PHImageContentModeAspectFill
                                                  options:option
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                [self.editContentView.contentViewArray[self.childViewIndex] thn_setImageViewData:result];
                                            }];
}

#pragma mark - 获取所有的相册资源
- (void)thn_getPhotoAlbumData {
    NSMutableArray<THNAssetItem *> *assets = [NSMutableArray array];
    
    self.photoAblumTitle = [NSMutableArray arrayWithArray:[[THNPhotoTool sharePhotoTool] thn_getPhotoAlbumList]];
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", NULL);
    dispatch_async(myQueue, ^{
        for (THNPhotoAlbumList *photoAlbum in self.photoAblumTitle) {
            if ([photoAlbum.title isEqualToString:@"相机胶卷"]) {
                NSArray<PHAsset *> *result = [[THNPhotoTool sharePhotoTool] thn_getAssetOfAssetCollection:photoAlbum.assetCOllection ascending:NO];
                [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    THNAssetItem *assetItem = [THNAssetItem assetItemWithPHAsset:obj];
                    [assets addObject:assetItem];
                }];
            }
        }
        self.assets = assets;
    });
    
    dispatch_barrier_async(myQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self thn_loadPhotoCollectionView];
        });
    });
}

#pragma mark 加载相册图片、相簿列表
- (void)thn_loadPhotoCollectionView {
    [self.view addSubview:self.photoListView];
    [self.photoListView thn_getPhotoAlbumListData:self.photoAblumTitle];
    [self.photoListView thn_getPhotoAssetInAlbumData:self.assets isReplace:YES];
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"编辑";
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    [self.navView addSubview:self.doneReplaceButton];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    [self thn_saveDonePuzzleImage];
}

#pragma mark 保存图片
- (void)thn_saveDonePuzzleImage {
    UIImage *resuleImage = [self cutImageWithView:self.editContentView];
    UIImageWriteToSavedPhotosAlbum(resuleImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

- (UIImage *)cutImageWithView:(THNEditContentView *)contentView {
    UIGraphicsBeginImageContextWithOptions(contentView.frame.size, NO, 2.0);
    //  判断是否有选中边框，保存时去除
    for (THNEditChildView *childView in contentView.subviews) {
        if (CGColorEqualToColor(childView.topBoarderLayer.backgroundColor.CGColor, [UIColor colorWithHexString:kColorMain].CGColor)) {
            [childView clearInnerBoarder];
        }
        [self.editContentView removeBoarderMiddleView:childView];
    }
    
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [SVProgressHUD showSuccessWithStatus:@"已保存到相册"];
        [self thn_pushShareImageController];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存失败，请再试试"];
    }
}

- (void)thn_pushShareImageController {
    THNDoneImageViewController *doneController = [[THNDoneImageViewController alloc] init];
    doneController.doneImage = [self cutImageWithView:self.editContentView];
    [self.navigationController pushViewController:doneController animated:YES];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectedIndex"];
    [self.editContentView removeObserver:self forKeyPath:@"childViewIndex"];
}

#pragma mark - Array
- (NSMutableArray *)photoAssets {
    if (!_photoAssets) {
        _photoAssets = [NSMutableArray array];
    }
    return _photoAssets;
}

@end
