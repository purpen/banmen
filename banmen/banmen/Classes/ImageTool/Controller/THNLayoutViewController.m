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

#import "THNAssetItem.h"
#import "THNPhotoTool.h"
#import "THNPhotoListView.h"

@interface THNLayoutViewController () <
    PHPhotoLibraryChangeObserver,
    UIImagePickerControllerDelegate,
    THNImageToolNavigationBarItemsDelegate
>

@property (nonatomic, strong) NSMutableArray<THNAssetItem *> *assets;
@property (nonatomic, retain) NSMutableArray<THNPhotoAlbumList *> *photoAblumTitle;
@property (nonatomic, strong) THNPhotoAlbumList *selectedPhotoAblum;
@property (nonatomic, strong) THNPhotoListView *photoListView;

@end

@implementation THNLayoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_getPhotoAlbumPermissions];
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
    NSMutableArray<THNAssetItem *> *assets = [NSMutableArray array];
    
    self.photoAblumTitle = [NSMutableArray arrayWithArray:[[THNPhotoTool sharePhotoTool] thn_getPhotoAlbumList]];
    
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", NULL);
    dispatch_async(myQueue, ^{
        for (THNPhotoAlbumList *photoAlbum in self.photoAblumTitle) {
            if ([photoAlbum.title isEqualToString:@"相机胶卷"]) {
                NSArray<PHAsset *> *result = [[THNPhotoTool sharePhotoTool] thn_getAssetOfAssetCollection:photoAlbum.assetCOllection ascending:NO];
                [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    THNAssetItem *assetItem = [THNAssetItem AssetItemWithPHAsset:obj];
                    [assets addObject:assetItem];
                }];
            }
        }
        
        self.assets = assets;
    });
    
    dispatch_barrier_async(myQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self thn_setControllerViewUI];
        });
    });
}

#pragma mark - 加载视图控件
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.photoListView];
    [self.photoListView thn_getPhotoAlbumListData:self.photoAblumTitle];
    [self.photoListView thn_getPhotoAssetInAlbumData:self.assets];
}

#pragma mark - 加载相册列表视图
- (THNPhotoListView *)photoListView {
    if (!_photoListView) {
        _photoListView = [[THNPhotoListView alloc] initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, SCREEN_HEIGHT - 240)];
    }
    return _photoListView;
}

#pragma mark - 相册发生变化后回调
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_sync(dispatch_get_main_queue(), ^{
        
    });
}

#pragma mark - 注册通知监听相册变化
- (void)initNot {
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"选择布局";
    [self thn_addNavCloseButton];
}

@end
