//
//  THNLayoutViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNLayoutViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNJointImageViewController.h"
#import "THNAssetItem.h"
#import "THNPhotoTool.h"
#import "THNHintInfoView.h"
#import "THNPhotoListView.h"
#import "THNPreviewPuzzleView.h"
#import <SDWebImage/UIImage+MultiFormat.h>

@interface THNLayoutViewController () <
    UIImagePickerControllerDelegate,
    THNImageToolNavigationBarItemsDelegate,
    THNPhotoListViewDelegate
>

{
    THNLayoutViewControllerType _controllerType;
}

@property (nonatomic, strong) NSMutableArray<THNAssetItem *> *assets;
@property (nonatomic, retain) NSMutableArray<THNPhotoAlbumList *> *photoAblumTitle;
@property (nonatomic, strong) NSMutableArray *selectPhotoItemArray;
@property (nonatomic, strong) THNPhotoAlbumList *selectedPhotoAblum;
@property (nonatomic, strong) THNPhotoListView *photoListView;
@property (nonatomic, strong) THNPreviewPuzzleView *previewPuzzleView;
@property (nonatomic, strong) THNHintInfoView *hintInfoView;

@end

@implementation THNLayoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectPhotoItemArray = [NSMutableArray array];
    [self addObserver:self forKeyPath:@"selectPhotoItemArray" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self thn_hiddenNavTitle:YES];
    [self thn_getPhotoAlbumPermissions];
}

- (void)thn_loadProductImageUrlForLayout:(NSArray *)imageUrlArray goodsTitle:(NSString *)title type:(THNLayoutViewControllerType)type {
    _controllerType = type;
    
    NSMutableArray<THNAssetItem *> *urlAssets = [NSMutableArray array];
    NSMutableArray<UIImage *> *ablumImage = [NSMutableArray array];

    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    dispatch_async(queue, ^{
        [SVProgressHUD showWithStatus:@"正在加载图片..."];
        for (NSString *imageUrl in imageUrlArray) {
            THNAssetItem *urlItem = [THNAssetItem assetItemWithImageUrl:imageUrl];
            urlItem.imageUrl = imageUrl;
            [urlAssets addObject:urlItem];
            [ablumImage addObject:urlItem.image];
        }
        
        THNPhotoAlbumList *ablumList = [[THNPhotoAlbumList alloc] init];
        ablumList.title = title;
        ablumList.count = imageUrlArray.count;
        ablumList.coverImage = [UIImage sd_imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrlArray.firstObject]]];
        ablumList.imageArray = ablumImage;
        ablumList.imageurlArray = imageUrlArray;
        
        if (self.photoAblumTitle.count) {
            [self.photoAblumTitle insertObject:ablumList atIndex:0];
        } 
        
        self.assets = urlAssets;
    });
    
    dispatch_barrier_async(queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.photoListView thn_setOpenAlbumButtonTitle:title];
            [self thn_setControllerViewUI];
        });
    });
}

#pragma mark - 检查相册权限
- (void)thn_getPhotoAlbumPermissions {
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusRestricted) {
        [SVProgressHUD showErrorWithStatus:@"因用户限制，暂无法访问相册"];
    } else if (photoStatus == PHAuthorizationStatusDenied) {
        [SVProgressHUD showInfoWithStatus:@"请在「系统设置-隐私-照片」打开此应用的访问开关"];
    } else if (photoStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self thn_getPhotoAlbumData];
            }
        }];
    } else if (photoStatus == PHAuthorizationStatusAuthorized) {
        [self thn_getPhotoAlbumData];
    }
}

#pragma mark - 获取所有的相册资源
- (void)thn_getPhotoAlbumData {
    [[self mutableArrayValueForKey:@"selectPhotoItemArray"] removeAllObjects];
    
    NSMutableArray<THNAssetItem *> *assets = [NSMutableArray array];
    
    self.photoAblumTitle = [NSMutableArray arrayWithArray:[[THNPhotoTool sharePhotoTool] thn_getPhotoAlbumList]];
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", NULL);
    dispatch_async(myQueue, ^{
        for (THNPhotoAlbumList *photoAlbum in self.photoAblumTitle) {
            if ([photoAlbum.title isEqualToString:@"相机胶卷"]) {
                NSArray<PHAsset *> *result = [[THNPhotoTool sharePhotoTool] thn_getAssetOfAssetCollection:photoAlbum.assetCollection ascending:NO];
                [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    THNAssetItem *assetItem = [THNAssetItem assetItemWithPHAsset:obj];
                    [assets addObject:assetItem];
                }];
            }
        }
        
        if (self.assets.count == 0) {
            self.assets = assets;
        }
    });
    
    if (_controllerType == THNLayoutViewControllerTypeNetwork) {
        return;
    }
    dispatch_barrier_async(myQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self thn_setControllerViewUI];
        });
    });
}

#pragma mark - 加载视图控件
- (void)thn_setControllerViewUI {
    //  默认提示视图
    [self.view addSubview:self.hintInfoView];
    [_hintInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 150));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(74);
    }];
    
    //  拼图预览
    [self.view addSubview:self.previewPuzzleView];
    [_previewPuzzleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 150));
        make.right.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view.mas_top).with.offset(74);
    }];
    
    //  图片列表
    [self.view addSubview:self.photoListView];
    [self.photoListView thn_getPhotoAlbumListData:self.photoAblumTitle];
    [self.photoListView thn_getPhotoAssetInAlbumData:self.assets isReplace:NO];
}

#pragma mark - 加载相册列表视图
- (THNPhotoListView *)photoListView {
    if (!_photoListView) {
        _photoListView = [[THNPhotoListView alloc] initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, SCREEN_HEIGHT - 260)];
        _photoListView.delegate = self;
    }
    return _photoListView;
}

#pragma mark - KVO监测选中照片之后的变化
/**
 选择了图片
 */
- (void)thn_didSelectItemAtPhotoList:(THNAssetItem *)item {
    if ([self mutableArrayValueForKey:@"selectPhotoItemArray"].count == 6) {
        [SVProgressHUD showInfoWithStatus:@"最多选择 6 张照片"];
        return;
    }
    [[self mutableArrayValueForKey:@"selectPhotoItemArray"] addObject:item];
}

/**
 取消选择的图片
 */
- (void)thn_didDeselectItemAtPhotoList:(THNAssetItem *)item {
    NSInteger index = [[self mutableArrayValueForKey:@"selectPhotoItemArray"] indexOfObject:item];
    [[self mutableArrayValueForKey:@"selectPhotoItemArray"] removeObjectAtIndex:index];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectPhotoItemArray"]) {
        if ([self mutableArrayValueForKey:@"selectPhotoItemArray"].count != 0) {
            [self thn_hiddenPreviewPuzzleView:NO];
        } else {
            [self thn_hiddenPreviewPuzzleView:YES];
        }
        
        NSMutableArray *itemArray = [self mutableArrayValueForKey:@"selectPhotoItemArray"];
        [self.previewPuzzleView thn_setPreviewPuzzlePhotoData:itemArray];
    }
}

#pragma mark - 拼图预览视图
- (THNPreviewPuzzleView *)previewPuzzleView {
    if (!_previewPuzzleView) {
        _previewPuzzleView = [[THNPreviewPuzzleView alloc] init];
        _previewPuzzleView.supViewController = self.navigationController;
        _previewPuzzleView.hidden = YES;
    }
    return _previewPuzzleView;
}

- (void)thn_hiddenPreviewPuzzleView:(BOOL)show {
    [self thn_hiddenNavTitle:show];
    
    [UIView animateWithDuration:.2 animations:^{
        self.previewPuzzleView.hidden = show;
        self.previewPuzzleView.alpha = show ? 0 : 1;
    }];
}

#pragma mark - 默认界面提示视图
- (THNHintInfoView *)hintInfoView {
    if (!_hintInfoView) {
        _hintInfoView = [[THNHintInfoView alloc] init];
        [_hintInfoView thn_showHintInfoWithImage:@"icon_logo_white"];
    }
    return _hintInfoView;
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"选择布局";
    [self thn_addNavCloseButton];
    [self thn_addBarItemRightBarButton:@"拼接" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    THNJointImageViewController *jointController = [[THNJointImageViewController alloc] init];
    jointController.selectedAssetArray = self.selectPhotoItemArray;
    [self.navigationController pushViewController:jointController animated:YES];
}

- (void)thn_hiddenNavTitle:(BOOL)hidden {
    [UIView animateWithDuration:.3 animations:^{
//        self.changeFrameButton.alpha = hidden ? 0 : 1;
        self.navRightItem.alpha = hidden ? 0 : 1;
    }];
}

#pragma mark ---
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"selectPhotoItemArray" context:NULL];
}

@end
