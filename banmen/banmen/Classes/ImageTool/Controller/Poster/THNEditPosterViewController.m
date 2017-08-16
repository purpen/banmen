//
//  THNEditPosterViewController.m
//  banmen
//
//  Created by FLYang on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNEditPosterViewController.h"
#import "MainMacro.h"
#import "THNHintInfoView.h"
#import "THNPosterInfoView.h"
#import "THNPosterModelData.h"
#import <Photos/Photos.h>
#import "THNPhotoListView.h"
#import "UIColor+Extension.h"
#import "THNPosterImageView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "THNDoneImageViewController.h"
#import "NSString+JSON.h"
#import "THNKeyboardToolView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface THNEditPosterViewController () <THNImageToolNavigationBarItemsDelegate, THNPosterInfoViewDelegate, THNPhotoListViewDelegate, THNKeyboardToolViewDelegate> {
    NSInteger _imageViewTag;
    NSString *_posterStyle;
    CGFloat _textViewMaxY;
}

@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) THNHintInfoView *hintInfoView;
@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) THNPosterInfoView *posterView;
@property (nonatomic, strong) THNPosterModelData *dataModel;
//  相册列表
@property (nonatomic, strong) NSMutableArray<THNAssetItem *> *assets;
@property (nonatomic, retain) NSMutableArray<THNPhotoAlbumList *> *photoAblumTitle;
@property (nonatomic, strong) THNPhotoAlbumList *selectedPhotoAblum;
@property (nonatomic, strong) THNPhotoListView *photoListView;
@property (nonatomic, strong) UIView *maskView;
//  预览按钮
@property (nonatomic, strong) UIButton *previewButton;
@property (nonatomic, strong) UIImageView *previewPosterView;
//  键盘工具
@property (nonatomic, strong) THNKeyboardToolView *keyboardView;

@end

@implementation THNEditPosterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navRightItem.alpha = 0;
    
    [self thn_setControllerViewUI];
    
    [self thn_getPhotoAlbumPermissions];
    
    [self thn_registerForKeyboardNotifications];
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

#pragma mark - 选择的海报样式
- (void)thn_setPreviewPosterImage:(UIImage *)image style:(NSString *)style {
    self.previewImageView.image = image;
    _posterStyle = style;
}

#pragma mark - 设置视图
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.previewButton];
    
    [self.view addSubview:self.previewImageView];
    [_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 90, (SCREEN_WIDTH - 90) *1.77));
        make.centerX.equalTo(self.view);
    }];
    
    //  默认提示视图
    [self.view addSubview:self.hintInfoView];
    [_hintInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_previewImageView.mas_bottom).with.offset(20);
    }];
    
    [self.contentView addSubview:self.posterView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.previewPosterView];
    [self.view addSubview:self.keyboardView];
}

#pragma mark - 海报制作视图
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 64, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 94)];
        _contentView.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
        _contentView.contentSize = CGSizeMake(SCREEN_WIDTH - 60, SCREEN_HEIGHT - 94);
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.alpha = 0;
    }
    return _contentView;
}

- (THNPosterInfoView *)posterView {
    if (!_posterView) {
        _posterView = [[THNPosterInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, SCREEN_HEIGHT - 94)];
        _posterView.tap_delegate = self;
        _posterView.alpha = 0;
    }
    return _posterView;
}

- (void)thn_getEditingTextViewFrameMaxY:(CGFloat)maxY fontSize:(CGFloat)fontSize {
    _textViewMaxY = maxY + 100;
    [self.keyboardView thn_setChnageFontMaxSize:fontSize];
}
    
//  点击选择照片
- (void)thn_tapWithImageViewAndSelectPhoto:(NSInteger)tag {
    _imageViewTag = tag;
    [self.posterView thn_allTextViewResignFirstResponder];
    [self thn_changeKeyboardToolViewHeight:0.0f];
    [self thn_changeContentViewHeight:30.0f];
    [self thn_changeContentViewOffset:0.0f];
    
    [self thn_showPhotoListView:YES];
}

//  弹出展示相册列表
- (void)thn_showPhotoListView:(BOOL)show {
    CGFloat markY = show ? SCREEN_HEIGHT - 350 : SCREEN_HEIGHT;
    CGRect photoListRect = CGRectMake(0, markY, SCREEN_WIDTH, 350);
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha = show ? 1 : 0;
        self.photoListView.frame = photoListRect;
    }];
}

#pragma mark 加载海报样式数据
- (void)thn_loadPosterStyleInfoData {
    NSString *pathResource = [NSString stringWithFormat:@"%@", _posterStyle];
    NSDictionary *styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:pathResource ofType:@"plist"]];
    if ([[styleDict valueForKey:@"data"] isKindOfClass:[NSNull class]] || styleDict == nil) {
        [SVProgressHUD showInfoWithStatus:@"请换个其他海报模版试试吧"];
        return;
    }
    
//    NSLog(@"海报配置信息：%@", [NSString jsonStringWithObject:styleDict]);
    
    self.dataModel = [[THNPosterModelData alloc] initWithDictionary:[styleDict valueForKey:@"data"]];
    [self.posterView thn_setPosterStyleInfoData:self.dataModel];
    [self thn_showEditPosterView:YES];
}

- (void)thn_showEditPosterView:(BOOL)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.previewImageView.hidden = YES;
        self.hintInfoView.hidden = YES;
        self.contentView.alpha = 1;
        self.posterView.alpha = 1;
        self.navRightItem.alpha = 1;
        self.previewButton.alpha = 1;
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

#pragma mark 加载相册图片、相簿
- (void)thn_loadPhotoCollectionView {
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.photoListView];
    [self.photoListView thn_getPhotoAlbumListData:self.photoAblumTitle];
    [self.photoListView thn_getPhotoAssetInAlbumData:self.assets isReplace:YES];
}

#pragma mark 加载相册列表视图
- (THNPhotoListView *)photoListView {
    if (!_photoListView) {
        _photoListView = [[THNPhotoListView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
        _photoListView.delegate = self;
    }
    return _photoListView;
}

//  选中照片加载到海报
- (void)thn_didSelectItemAtPhotoListOfReplace:(THNAssetItem *)item {
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    [[PHImageManager defaultManager] requestImageForAsset:item.asset
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:option
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                [self thn_showPhotoListView:NO];
                                                [self.posterView thn_setPosterPhotoSelectImage:result withTag:_imageViewTag];
                                            }];
}

//  相册列表背景遮罩
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor colorWithHexString:kColorBlack alpha:0.3];
        _maskView.alpha = 0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewHandleTapGesture:)];
        tapGesture.numberOfTapsRequired = 1;
        [_maskView addGestureRecognizer:tapGesture];
    }
    return _maskView;
}

- (void)maskViewHandleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self thn_showPhotoListView:NO];
}

#pragma mark - 海报预览
- (UIImageView *)previewImageView {
    if (!_previewImageView) {
        _previewImageView = [[UIImageView alloc] init];
        _previewImageView.contentMode = UIViewContentModeScaleAspectFill;
        _previewImageView.clipsToBounds = YES;
        _previewImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewHandleTapGesture:)];
        [_previewImageView addGestureRecognizer:tapGesture];
    }
    return _previewImageView;
}

- (void)previewHandleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [self.posterView thn_allTextViewResignFirstResponder];
    [self thn_loadPosterStyleInfoData];
}

#pragma mark - 默认界面提示视图
- (THNHintInfoView *)hintInfoView {
    if (!_hintInfoView) {
        _hintInfoView = [[THNHintInfoView alloc] init];
        [_hintInfoView thn_showHintInfoViewWithText:@"点击海报进行编辑" fontOfSize:14 color:@"#999999"];
    }
    return _hintInfoView;
}

#pragma mark - 预览按钮
- (UIButton *)previewButton {
    if (!_previewButton) {
        _previewButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 103, 20, 44, 44)];
        [_previewButton addTarget:self action:@selector(previewButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_previewButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _previewButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_previewButton setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        [_previewButton setTitle:@"预览" forState:(UIControlStateNormal)];
        _previewButton.alpha = 0;
    }
    return _previewButton;
}

- (void)previewButtonAction:(UIButton *)button {
    [self thn_changeKeyboardToolViewHeight:0.0f];
    [self.posterView thn_allTextViewResignFirstResponder];
    self.previewPosterView.image = [self cutImageWithView:self.posterView];
    [self thn_scalePosterEidtView:self.previewPosterView Scale:YES];
}

#pragma mark 预览海报
- (UIImageView *)previewPosterView {
    if (!_previewPosterView) {
        _previewPosterView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _previewPosterView.contentMode = UIViewContentModeScaleAspectFill;
        _previewPosterView.clipsToBounds = YES;
        _previewPosterView.userInteractionEnabled = YES;
        _previewPosterView.alpha = 0;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewPosterViewHandleTapGesture:)];
        [_previewPosterView addGestureRecognizer:tapGesture];
    }
    return _previewPosterView;
}

- (void)previewPosterViewHandleTapGesture:(UITapGestureRecognizer *)tapGesture {
    [UIView animateWithDuration:0.3 animations:^{
        self.previewPosterView.alpha = 0;
    }];
//    [self thn_scalePosterEidtView:self.previewPosterView Scale:NO];
}

//  缩放视图
- (void)thn_scalePosterEidtView:(UIImageView *)view Scale:(BOOL)scale {
    CGFloat scaleX = scale ? 1 : 1;
    CGFloat scaleY = scale ? 1 : 1;
    CGFloat pointY = scale ? SCREEN_HEIGHT / 2 : SCREEN_HEIGHT / 2;
    CGPoint scalePoint = CGPointMake(self.view.center.x, pointY);
    
    [UIView animateWithDuration:0.3 animations:^{
        view.transform = CGAffineTransformMakeScale(scaleX, scaleY);
        view.center = scalePoint;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            view.alpha = scale ? 1 : 0;
        }];
    }];
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
    [self thn_addNavCloseButton];
    [self thn_addBarItemRightBarButton:@"保存" image:nil];
    self.delegate = self;
}

- (void)thn_rightBarItemSelected {
    [self thn_saveDonePosterImage];
}

#pragma mark 保存图片
- (void)thn_saveDonePosterImage {
    if (self.dataModel.size.width == 0 || self.dataModel.size.height == 0) {
        [SVProgressHUD showInfoWithStatus:@"保存出错"];
        return;
    }
    
    UIImage *resuleImage = [self cutImageWithView:self.posterView];
    UIImageWriteToSavedPhotosAlbum(resuleImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
}

- (UIImage *)cutImageWithView:(THNPosterInfoView *)contentView {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.dataModel.size.width, self.dataModel.size.height), NO, 1.0);
    [contentView.controlView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [self thn_pushShareImageController];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存失败，请重试"];
    }
}

- (void)thn_pushShareImageController {
    THNDoneImageViewController *doneController = [[THNDoneImageViewController alloc] init];
    doneController.doneImage = [self cutImageWithView:self.posterView];
    [self.navigationController pushViewController:doneController animated:YES];
}

#pragma mark - 键盘工具操作
- (THNKeyboardToolView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[THNKeyboardToolView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 44)];
        _keyboardView.delegate = self;
        [_keyboardView thn_setHiddenExtendingFunction:NO];
    }
    return _keyboardView;
}

- (void)thn_writeInputBoxResignFirstResponder {
    [self thn_changeKeyboardToolViewHeight:0.0f];
    [self thn_changeContentViewHeight:30.0f];
    [self thn_changeContentViewOffset:0.0f];
    [self.posterView thn_allTextViewResignFirstResponder];
}

- (void)thn_writeInputBoxBeginEditTextTool {
    [self.posterView thn_allTextViewResignFirstResponder];
}

- (void)thn_writeInputBoxEndEditTextTool {
    [self.posterView thn_allTextViewBecomeFirstResponder];
}

- (void)thn_selectColorForChangeTextColor:(NSString *)color {
    [self.posterView thn_changeTextColor:color];
}

- (void)thn_selectAlignForChangeTextAlign:(NSTextAlignment)align {
    [self.posterView thn_changeTextAlignment:align];
}

- (void)thn_changeTextFontSize:(CGFloat)fontSize {
    [self.posterView thn_changeTextFontSize:fontSize];
}

#pragma mark - 添加键盘检测
- (void)thn_registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//  键盘将出现
- (void)keyboardWillShow:(NSNotification *)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGFloat keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [self thn_changeKeyboardToolViewHeight:keyboardHeight];
    
    [self thn_changeContentViewHeight:keyboardHeight];
}

//  键盘出现
- (void)keyboardDidShow:(NSNotification *)aNotification {
    if (_textViewMaxY > CGRectGetMaxY(self.contentView.frame)) {
        [self thn_changeContentViewOffset:_textViewMaxY - CGRectGetMaxY(self.contentView.frame)];
    }
}

//  键盘消失
- (void)keyboardHidden:(NSNotification *)aNotification {
    if (self.keyboardView.changeTextColor.selected == NO && self.keyboardView.fontSize.selected == NO) {
        [self thn_changeKeyboardToolViewHeight:0.0f];
        [self thn_changeContentViewHeight:30.0f];
        [self thn_changeContentViewOffset:0.0f];
    }
}

//  改变键盘工具的高度
- (void)thn_changeKeyboardToolViewHeight:(CGFloat)height {
    self.navRightItem.hidden = height == 0 ? NO : YES;
    self.keyboardView.changeTextColor.selected = NO;
    self.keyboardView.fontSize.selected = NO;
    
    [self.keyboardView thn_refreshColorCollectionData];
    
    CGRect keyboardViewRect = self.keyboardView.frame;
    keyboardViewRect = CGRectMake(0, SCREEN_HEIGHT - (height), SCREEN_WIDTH, (height));
    [UIView animateWithDuration:0.2 animations:^{
        self.keyboardView.frame = keyboardViewRect;
    }];
}

//  改变海报的高度
- (void)thn_changeContentViewHeight:(CGFloat)height {
    CGRect contentViewRect = self.contentView.frame;
    contentViewRect = CGRectMake(30, 64, SCREEN_WIDTH - 60, SCREEN_HEIGHT - height - 64);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.contentView.frame = contentViewRect;
    }];
}

//  编辑文字改变海报的偏移量，防止文本框被遮挡
- (void)thn_changeContentViewOffset:(CGFloat)height {
    CGPoint contentViewOffset = self.contentView.contentOffset;
    contentViewOffset = CGPointMake(0, height);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.contentOffset = contentViewOffset;
    }];
}

#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
