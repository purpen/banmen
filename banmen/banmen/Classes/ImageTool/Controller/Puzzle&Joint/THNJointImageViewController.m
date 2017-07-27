//
//  THNJointViewController.m
//  banmen
//
//  Created by FLYang on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNJointImageViewController.h"
#import "UIColor+Extension.h"
#import "MainMacro.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "THNDoneImageViewController.h"
#import "THNJointContentView.h"

@interface THNJointImageViewController () <
    THNImageToolNavigationBarItemsDelegate
>

@property (nonatomic, strong) THNJointContentView *jointContentView;

@end

@implementation THNJointImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
    [self thn_initJointImageContentInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_setControllerViewUI];
}

#pragma mark - 设置视图
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.jointContentView];
}

- (THNJointContentView *)jointContentView {
    if (!_jointContentView) {
        _jointContentView = [[THNJointContentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _jointContentView;
}

- (void)thn_initJointImageContentInfo {
    [self.jointContentView setPhotoAsset:self.selectedAssetArray];
    [self.jointContentView thn_setImageViewData];
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    self.navTitle.text = @"拼接";
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    [self.navRightItem setTitleColor:[UIColor colorWithHexString:kColorMain] forState:(UIControlStateNormal)];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    [self thn_saveDoneJointImage];
}

#pragma mark 保存图片
- (void)thn_saveDoneJointImage {
    UIImage *resuleImage = [self cutImageWithView:self.jointContentView];
    UIImageWriteToSavedPhotosAlbum(resuleImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

- (UIImage *)cutImageWithView:(THNJointContentView *)contentView {
    UIGraphicsBeginImageContextWithOptions(contentView.contentSize, NO, 2.0);
    CGPoint savedContentOffset = contentView.contentOffset;
    CGRect savedFrame = contentView.frame;
    contentView.contentOffset = CGPointZero;
    contentView.frame = CGRectMake(0, 0, contentView.contentSize.width, contentView.contentSize.height);
    [contentView.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    contentView.contentOffset = savedContentOffset;
    contentView.frame = savedFrame;
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
    doneController.doneImage = [self cutImageWithView:self.jointContentView];
    [self.navigationController pushViewController:doneController animated:YES];
}

@end
