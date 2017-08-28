//
//  THNKeyboardToolView.m
//  banmen
//
//  Created by FLYang on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNKeyboardToolView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNColorCollectionViewCell.h"
#import "THNFontStyleTableViewCell.h"
#import "FontMacro.h"
#import "THNDownloadFontTool.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString *const colorCellId = @"THNColorCollectionViewCellId";
static NSString *const styleCellId = @"THNFontStyleTableViewCellId";
static NSInteger const alignButtonTag = 1245;
static NSInteger const toolMenuButtonTag = 1345;

@interface THNKeyboardToolView () <
    UIScrollViewDelegate,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UITableViewDelegate,
    UITableViewDataSource
>
{
    NSInteger _selectIndex;
    CGFloat _downloadProgress;
    THNFontStyleDownloadStatus _downloadStatus;
}

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UICollectionView *colorCollection;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) UIView *fontSizeView;
@property (nonatomic, strong) UISlider *sizeSlider;
@property (nonatomic, strong) UILabel *showSizeLabel;
@property (nonatomic, strong) UITableView *styleTable;
@property (nonatomic, strong) NSArray *fontNameArray;

@end

@implementation THNKeyboardToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#222222"];
        self.clipsToBounds = YES;
        
        self.colorArray = @[@[@"#00C09A", @"#00D166", @"#009AE1", @"#A652BB", @"#2E4A60"],
                            @[@"#F9C300", @"#F67700", @"#FB3731", @"#BCC3C7", @"#91A6A6"],
                            @[@"#FFFFFF", @"#999999", @"#666666", @"#333333", @"#000000"]];
        
        [self setViewUI];
    }
    return self;
}

- (void)thn_refreshColorCollectionData {
    [self.colorCollection reloadData];
}

- (void)thn_setChnageFontMaxSize:(CGFloat)fontSize maxFontSize:(CGFloat)maxSize {
    self.sizeSlider.maximumValue = maxSize;
    self.sizeSlider.value = fontSize;
    self.showSizeLabel.text = [NSString stringWithFormat:@"%.0f", fontSize];
}

#pragma mark - 设置视图UI
- (void)setViewUI {
    NSArray *icon = @[@"icon_change_color", @"icon_change_style", @"icon_change_font"];
    NSArray *clickIcon = @[@"icon_change_colorClick", @"icon_change_styleClick", @"icon_change_fontClick"];
    [self creatKeyboardToolMenuButton:icon clickIcon:clickIcon];
    
    [self addSubview:self.contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self thn_generateContent];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 44, self.bounds.size.width - 30, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#979797" alpha:1];
    [self addSubview:line];
}

#pragma mark 滚动视图
- (void)thn_generateContent {
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);

    [self.contentView addSubview:self.colorCollection];
    [_colorCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 200));
        make.left.mas_equalTo((SCREEN_WIDTH - 300) / 2);
        make.top.mas_equalTo(40);
    }];
    
    [self.contentView addSubview:self.fontSizeView];
    [_fontSizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
        make.left.mas_equalTo(SCREEN_WIDTH * 2);
        make.top.mas_equalTo(40);
    }];
    
    [self addSubview:self.styleTable];
    [_styleTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(44);
        make.bottom.left.right.mas_equalTo(0);
    }];
}


#pragma mark - 创建功能按钮
- (void)creatKeyboardToolMenuButton:(NSArray *)iconArray clickIcon:(NSArray *)clckIcon {
    [self addSubview:self.closeKeybord];
    [_closeKeybord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    for (NSInteger idx = 0 ; idx < iconArray.count; ++ idx) {
        UIButton *menuButton = [[UIButton alloc] init];
        [menuButton setImage:[UIImage imageNamed:iconArray[idx]] forState:(UIControlStateNormal)];
        [menuButton setImage:[UIImage imageNamed:clckIcon[idx]] forState:(UIControlStateSelected)];
        [menuButton addTarget:self action:@selector(keyBoardToolMenuButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        menuButton.selected = NO;
        menuButton.tag = toolMenuButtonTag + idx;
        
        [self addSubview:menuButton];
        [menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.right.equalTo(self.mas_right).with.offset(-(5 + 44 * idx));
            make.top.equalTo(self).with.offset(0);
        }];
    }
}

- (void)keyBoardToolMenuButtonClick:(UIButton *)button {
    if (button.tag - toolMenuButtonTag == 1) {
        self.styleTable.hidden = NO;
        self.contentView.hidden = YES;
        
    } else {
        self.styleTable.hidden = YES;
        self.contentView.hidden = NO;
        [self thn_changeContentViewOffset:button.tag - toolMenuButtonTag];
    }

    if (button.selected == NO) {
        self.selectButton.selected = NO;
        button.selected = YES;
        self.selectButton = button;
        if ([self.delegate respondsToSelector:@selector(thn_writeInputBoxBeginEditTextTool)]) {
            [self.delegate thn_writeInputBoxBeginEditTextTool];
        }
        
    } else {
        button.selected = NO;
        if ([self.delegate respondsToSelector:@selector(thn_writeInputBoxEndEditTextTool)]) {
            [self.delegate thn_writeInputBoxEndEditTextTool];
        }
    }
}

#pragma mark 关闭键盘
- (UIButton *)closeKeybord {
    if (!_closeKeybord) {
        _closeKeybord = [[UIButton alloc] init];
        [_closeKeybord setImage:[UIImage imageNamed:@"icon_keyboard_gray"] forState:(UIControlStateNormal)];
        [_closeKeybord addTarget:self action:@selector(closeKeybordClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeKeybord;
}

//  关闭键盘
- (void)closeKeybordClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(thn_writeInputBoxResignFirstResponder)]) {
        [self.delegate thn_writeInputBoxResignFirstResponder];
    }
    
    if (self.selectButton.selected == YES) {
        self.selectButton.selected = NO;
    }
}

#pragma mark - 功能面板
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.scrollEnabled = NO;
    }
    return _contentView;
}

//  改变工具栏偏移量，显示不同工具视图
- (void)thn_changeContentViewOffset:(NSInteger)index {
    CGPoint contentViewPoint = self.contentView.contentOffset;
    contentViewPoint.x = SCREEN_WIDTH * index;
    self.contentView.contentOffset = contentViewPoint;
}

#pragma mark 颜色面板
- (UICollectionView *)colorCollection {
    if (!_colorCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(40, 40);
        flowLayout.minimumLineSpacing = 15.0f;
        flowLayout.minimumInteritemSpacing = 15.0f;
        
        _colorCollection = [[UICollectionView alloc] initWithFrame:CGRectZero
                                              collectionViewLayout:flowLayout];
        _colorCollection.showsVerticalScrollIndicator = NO;
        _colorCollection.showsHorizontalScrollIndicator = NO;
        _colorCollection.delegate = self;
        _colorCollection.dataSource = self;
        _colorCollection.bounces = NO;
        _colorCollection.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        [_colorCollection registerClass:[THNColorCollectionViewCell class] forCellWithReuseIdentifier:colorCellId];
    }
    return _colorCollection;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.colorArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [(NSArray *)self.colorArray[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(0, 30, 15, 0);
    }
    return UIEdgeInsetsMake(0, 0, 15, 28);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THNColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colorCellId
                                                                                 forIndexPath:indexPath];
    [cell thn_setColorInfo:self.colorArray[indexPath.section][indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *color = self.colorArray[indexPath.section][indexPath.row];
    if ([self.delegate respondsToSelector:@selector(thn_selectColorForChangeTextColor:)]) {
        [self.delegate thn_selectColorForChangeTextColor:color];
    }
}

#pragma mark 字体样式面板
- (UITableView *)styleTable {
    if (!_styleTable) {
        _styleTable = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _styleTable.delegate = self;
        _styleTable.dataSource = self;
        _styleTable.tableFooterView = [UIView new];
        _styleTable.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
        _styleTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _styleTable.hidden = YES;
    }
    return _styleTable;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fontNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THNFontStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:styleCellId];
    if (!cell) {
        cell = [[THNFontStyleTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:styleCellId];
    }

    NSString *fontName = self.fontNameArray[indexPath.row];
    BOOL exist = [THNDownloadFontTool thn_isDownloadedFont:fontName];
    
    if (_downloadStatus == THNFontStyleDownloadStatusLoading) {
        if (_selectIndex == indexPath.row) {
            [cell thn_setFontStyleCellFontName:fontName downloadStatus:_downloadStatus progress:_downloadProgress];
        }
        
    } else {
        if (exist) {
            _downloadStatus = THNFontStyleDownloadStatusDone;
        } else {
            _downloadStatus = THNFontStyleDownloadStatusNone;
        }
        
        [cell thn_setFontStyleCellFontName:fontName downloadStatus:_downloadStatus progress:0.];
    }

    if (_selectIndex == indexPath.row) {
        [cell thn_hiddenSelectStyleRow:NO];
    } else {
        [cell thn_hiddenSelectStyleRow:YES];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndex = indexPath.row;
    
    NSString *fontName = self.fontNameArray[indexPath.row];
    
    switch (_downloadStatus) {
        case THNFontStyleDownloadStatusDone:
            NSLog(@"================================ 存在字体 %@",fontName);
            _downloadStatus = THNFontStyleDownloadStatusDone;
            if ([self.delegate respondsToSelector:@selector(thn_changeTextFontStyleName:)]) {
                [self.delegate thn_changeTextFontStyleName:fontName];
            }
            
            [self.styleTable reloadData];
            break;
            
        case THNFontStyleDownloadStatusNone:
            NSLog(@"================================ 不存在字体 %@", fontName);
            [self thn_downloadSelectFont:fontName];
            break;
            
        case THNFontStyleDownloadStatusLoading:
            NSLog(@"================================ 停止下载字体 %@", fontName);
            break;
    }
    
}

//  下载字体
- (void)thn_downloadSelectFont:(NSString *)fontName {
    [THNDownloadFontTool thn_downLoadFontWithFontName:fontName progress:^(CGFloat pro) {
        NSLog(@"================ 下载进度：%.2f", pro);
        _downloadProgress = pro;
        _downloadStatus = THNFontStyleDownloadStatusLoading;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectIndex inSection:0];
        [self.styleTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    } complete:^{
        NSLog(@"**************** 下载完成  %@", fontName);
        _downloadStatus = THNFontStyleDownloadStatusDone;
        
        if ([self.delegate respondsToSelector:@selector(thn_changeTextFontStyleName:)]) {
            [self.delegate thn_changeTextFontStyleName:fontName];
        }

        [self.styleTable reloadData];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_selectIndex inSection:0];
//        [self.styleTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
     
    } errorMsg:^(NSString *message) {
        _downloadStatus = THNFontStyleDownloadStatusNone;
        [SVProgressHUD showErrorWithStatus:@"下载字体失败"];
    }];
}

#pragma mark 字体字号面板
- (UIView *)fontSizeView {
    if (!_fontSizeView) {
        _fontSizeView = [[UIView alloc] initWithFrame:CGRectZero];
        _fontSizeView.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        
        [self creatFontSizeSlider];
        [self creatFontAlignButton:@[@"icon_align_0", @"icon_align_1", @"icon_align_2"]];
    }
    return _fontSizeView;
}

//  字号大小
- (void)creatFontSizeSlider {
    UILabel *sizeLabel = [[UILabel alloc] init];
    sizeLabel.font = [UIFont systemFontOfSize:12];
    sizeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    sizeLabel.text = @"字号";
    [_fontSizeView addSubview:sizeLabel];
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(_fontSizeView.mas_left).with.offset(15);
        make.top.equalTo(_fontSizeView.mas_top).with.offset(0);
    }];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.minimumTrackTintColor = [UIColor colorWithHexString:kColorRed alpha:1];
    slider.minimumValue = 10;
    [slider setThumbImage:[UIImage imageNamed:@"icon_slider"] forState:(UIControlStateNormal)];
    [slider addTarget:self action:@selector(changeFontSize:) forControlEvents:(UIControlEventValueChanged)];
    
    [_fontSizeView addSubview:slider];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 80, 20));
        make.left.equalTo(_fontSizeView.mas_left).with.offset(15);
        make.top.equalTo(_fontSizeView.mas_top).with.offset(25);
    }];
    
    self.sizeSlider = slider;
    
    [_fontSizeView addSubview:self.showSizeLabel];
    [_showSizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 20));
        make.left.equalTo(slider.mas_right).with.offset(10);
        make.top.equalTo(_fontSizeView.mas_top).with.offset(26);
    }];
}

- (void)changeFontSize:(UISlider *)slider {
    self.showSizeLabel.text = [NSString stringWithFormat:@"%.0f", slider.value];
    if ([self.delegate respondsToSelector:@selector(thn_changeTextFontSize:)]) {
        [self.delegate thn_changeTextFontSize:slider.value];
    }
}

//  字号显示
- (UILabel *)showSizeLabel {
    if (!_showSizeLabel) {
        _showSizeLabel = [[UILabel alloc] init];
        _showSizeLabel.font = [UIFont systemFontOfSize:12];
        _showSizeLabel.textColor = [UIColor whiteColor];
        _showSizeLabel.textAlignment = NSTextAlignmentCenter;
        _showSizeLabel.layer.borderColor = [UIColor colorWithHexString:kColorRed alpha:1].CGColor;
        _showSizeLabel.layer.borderWidth = 1.0f;
        _showSizeLabel.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0.7];
        _showSizeLabel.layer.cornerRadius = 10;
        _showSizeLabel.layer.masksToBounds = YES;
    }
    return _showSizeLabel;
}

//  对齐方式
- (void)creatFontAlignButton:(NSArray *)alignArray {
    UILabel *fontLabel = [[UILabel alloc] init];
    fontLabel.font = [UIFont systemFontOfSize:12];
    fontLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    fontLabel.text = @"对齐";
    [_fontSizeView addSubview:fontLabel];
    [fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(_fontSizeView.mas_left).with.offset(15);
        make.top.equalTo(_fontSizeView.mas_top).with.offset(80);
    }];
    
    for (NSInteger idx = 0; idx < alignArray.count; ++ idx) {
        UIButton *alignButton = [[UIButton alloc] init];
        [alignButton setImage:[UIImage imageNamed:alignArray[idx]] forState:(UIControlStateNormal)];
        [alignButton addTarget:self action:@selector(alignButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        alignButton.tag = alignButtonTag + idx;
        alignButton.selected = NO;
        
        [_fontSizeView addSubview:alignButton];
        [alignButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.equalTo(_fontSizeView.mas_left).with.offset(15 + 100 * idx);
            make.top.equalTo(_fontSizeView.mas_top).with.offset(110);
        }];
    }
}

- (void)alignButtonAction:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(thn_selectAlignForChangeTextAlign:)]) {
        [self.delegate thn_selectAlignForChangeTextAlign:(NSTextAlignment)button.tag - alignButtonTag];
    }
}

#pragma mark 字体名称
- (NSArray *)fontNameArray {
    if (!_fontNameArray) {
        _fontNameArray = @[
                           @"PingFangSC-Regular",      //苹方-简 常规体
                           @"PingFangSC-Ultralight",   //苹方-简 极细体
                           @"PingFangSC-Light",        //苹方-简 细体
                           @"PingFangSC-Thin",         //苹方-简 纤细体
                           @"PingFangSC-Medium",       //苹方-简 中黑体
                           @"PingFangSC-Semibold",     //苹方-简 中粗体
                           @"STBaoli-SC-Regular",      //报隶-简 常规体
                           @"HiraginoSansGB-W3",       //冬青黑体简体中文 W3
                           @"HiraginoSansGB-W6",       //冬青黑体简体中文 W6
                           @"STHeitiSC-Light",         //黑体-简 细体
                           @"STHeitiSC-Medium",        //黑体-简 中等
                           @"STFangsong",              //华文仿宋 常规体
                           @"STXihei",                 //华文黑体 细体
                           @"STHeiti",                 //华文黑体 常规体
                           @"STSong",                  //华文宋体 常规体
                           @"STKaiti-SC-Regular",      //楷体-简 常规体
                           @"STKaiti-SC-Bold",         //楷体-简 粗体
                           @"STKaiti-SC-Black",        //楷体-简 黑体
                           @"FZLTXHK--GBK1-0",         //兰亭黑-简 纤黑
                           @"FZLTTHK--GBK1-0",         //兰亭黑-简 特黑
                           @"FZLTZHK--GBK1-0",         //兰亭黑-简 中黑
                           @"STLibian-SC-Regular",     //隶变-简 常规体
                           @"HanziPenSC-W3",           //翩翩体-简 常规体
                           @"HanziPenSC-W5",           //翩翩体-简 粗体
                           @"HannotateSC-W5",          //手札体-简 常规体
                           @"HannotateSC-W7",          //手札体-简 粗体
                           @"STSongti-SC-Regular",     //宋体-简 常规体
                           @"STSongti-SC-Light",       //宋体-简 细体
                           @"STSongti-SC-Bold",        //宋体-简 粗体
                           @"STSongti-SC-Black",       //宋体-简 黑体
                           @"DFWaWaSC-W5",             //娃娃体-简 常规体
                           @"Weibei-SC-Bold",          //魏碑-简 粗体
                           @"STXingkai-SC-Light",      //行楷-简 细体
                           @"STXingkai-SC-Bold",       //行楷-简 粗体
                           @"YuppySC-Regular",         //雅痞-简 常规体
                           @"STYuanti-SC-Regular",     //圆体-简 常规体
                           @"STYuanti-SC-Light",       //圆体-简 细体
                           @"STYuanti-SC-Bold"         //圆体-简 粗体
                           ];
    }
    return _fontNameArray;
}

@end
