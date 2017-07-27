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

@interface THNEditPosterViewController ()

@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) THNHintInfoView *hintInfoView;
@property (nonatomic, strong) THNPosterInfoView *posterView;

@end

@implementation THNEditPosterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self thn_setNavViewUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_setControllerViewUI];
}

#pragma mark - 设置视图
- (void)thn_setControllerViewUI {
    [self.view addSubview:self.previewImageView];
    [_previewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 90, (SCREEN_WIDTH - 90) *1.77));
        make.centerX.equalTo(self.view);
    }];
    self.previewImageView.image = self.previewImage;
    
    //  默认提示视图
    [self.view addSubview:self.hintInfoView];
    [_hintInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 20));
        make.centerX.equalTo(self.view);
        make.top.equalTo(_previewImageView.mas_bottom).with.offset(20);
    }];
    
    [self.view addSubview:self.posterView];
}

#pragma mark - 海报制作视图
- (THNPosterInfoView *)posterView {
    if (!_posterView) {
        _posterView = [[THNPosterInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _posterView.alpha = 0;
    }
    return _posterView;
}

#pragma mark 加载海报样式数据
- (void)thn_loadPosterStyleInfoData {
    NSDictionary *styleDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"poster_0" ofType:@"plist"]];
    if ([[styleDict valueForKey:@"data"] isKindOfClass:[NSNull class]]) {
        return;
    }
    
    THNPosterModelData *dataModel = [[THNPosterModelData alloc] initWithDictionary:[styleDict valueForKey:@"data"]];
    [self.posterView thn_setPosterStyleInfoData:dataModel];
    [self thn_scalePosterEidtViewWidth:dataModel.size.width height:dataModel.size.height scale:YES];
}

//  缩放海报视图
- (void)thn_scalePosterEidtViewWidth:(CGFloat)width height:(CGFloat)height scale:(BOOL)scale {
    self.posterView.frame = CGRectMake(0, 0, width, height);
    
    CGFloat scaleNum = SCREEN_WIDTH / width;
    
    CGFloat scaleX = scale ? (scaleNum * 0.8) : scaleNum;
    CGFloat scaleY = scale ? (scaleNum * 0.8) : scaleNum;
    CGFloat pointY = scale ? SCREEN_HEIGHT / 2 : SCREEN_HEIGHT / 2;
    CGPoint scalePoint = CGPointMake(self.view.center.x, pointY);
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.posterView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
//        self.posterView.center = scalePoint;
//    }];
    
    [UIView animateWithDuration:0 animations:^{
        self.posterView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
        self.posterView.center = scalePoint;
    } completion:^(BOOL finished) {
        [self thn_showEditPosterView:YES];
    }];
}

#pragma mark - 海报预览
- (UIImageView *)previewImageView {
    if (!_previewImageView) {
        _previewImageView = [[UIImageView alloc] init];
        _previewImageView.contentMode = UIViewContentModeScaleAspectFill;
        _previewImageView.clipsToBounds = YES;
        _previewImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEditPoster:)];
        [_previewImageView addGestureRecognizer:tapGesture];
    }
    return _previewImageView;
}

- (void)beginEditPoster:(UITapGestureRecognizer *)tapGesture {
    [self thn_loadPosterStyleInfoData];
}

- (void)thn_showEditPosterView:(BOOL)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.previewImageView.hidden = YES;
        self.hintInfoView.hidden = YES;
        self.posterView.alpha = 1;
    }];
}

#pragma mark - 默认界面提示视图
- (THNHintInfoView *)hintInfoView {
    if (!_hintInfoView) {
        _hintInfoView = [[THNHintInfoView alloc] init];
        [_hintInfoView thn_showHintInfoViewWithText:@"点击海报进行编辑" fontOfSize:14 color:@"#999999"];
    }
    return _hintInfoView;
}

#pragma mark - 设置Nav
- (void)thn_setNavViewUI {
//    self.navTitle.text = @"选择布局";
    [self thn_addNavCloseButton];
//    [self thn_addBarItemRightBarButton:@"完成" image:nil];
}

@end
