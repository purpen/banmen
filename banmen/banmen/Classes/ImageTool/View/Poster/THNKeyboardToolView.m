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

static NSString *const colorCellId = @"THNColorCollectionViewCellId";

@interface THNKeyboardToolView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UICollectionView *colorCollection;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) UIView *fontSizeView;

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

- (void)thn_setHiddenExtendingFunction:(BOOL)hidden {
    self.changeTextColor.hidden = hidden;
    self.fontStyle.hidden = hidden;
    self.fontSize.hidden = hidden;
}

- (void)thn_refreshColorCollectionData {
    [self.colorCollection reloadData];
}

- (void)setViewUI {
    [self addSubview:self.changeTextColor];
    [_changeTextColor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self addSubview:self.fontSize];
    [_fontSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.right.equalTo(_changeTextColor.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self addSubview:self.closeKeybord];
    [_closeKeybord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.contentView addSubview:self.fontSizeView];
    [self.contentView addSubview:self.colorCollection];
    
    [self addSubview:self.contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(90);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 200));
        make.centerX.equalTo(self);
    }];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 44, self.bounds.size.width - 30, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"#979797" alpha:1];
    [self addSubview:line];
}

#pragma mark - 功能面板
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 0, 0)];
        _contentView.delegate = self;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
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
        
        _colorCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH + ((SCREEN_WIDTH - 300) / 2), 0, 300, 160)
                                              collectionViewLayout:flowLayout];
        _colorCollection.showsVerticalScrollIndicator = NO;
        _colorCollection.showsHorizontalScrollIndicator = NO;
        _colorCollection.delegate = self;
        _colorCollection.dataSource = self;
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

#pragma mark - 字体字号面板
- (UIView *)fontSizeView {
    if (!_fontSizeView) {
        _fontSizeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _fontSizeView.backgroundColor = [UIColor colorWithHexString:kColorRed alpha:0];
        
        [self creatFontSizeButton:@[@"icon_align_0", @"icon_align_1", @"icon_align_2"]];
    }
    return _fontSizeView;
}

- (void)creatFontSizeButton:(NSArray *)fontArray {
    UILabel *fontLabel = [[UILabel alloc] init];
    fontLabel.font = [UIFont systemFontOfSize:12];
    fontLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    fontLabel.text = @"对齐";
    [_fontSizeView addSubview:fontLabel];
    [fontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.left.equalTo(_fontSizeView.mas_left).with.offset(15);
        make.top.equalTo(_fontSizeView.mas_top).with.offset(110);
    }];
    
    for (NSInteger idx = 0; idx < fontArray.count; ++ idx) {
        UIButton *sizeButton = [[UIButton alloc] init];
        [sizeButton setImage:[UIImage imageNamed:fontArray[idx]] forState:(UIControlStateNormal)];
        
        [_fontSizeView addSubview:sizeButton];
        [sizeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.equalTo(_fontSizeView.mas_left).with.offset(15 + ((SCREEN_WIDTH - 80) / 2) * idx);
            make.top.equalTo(_fontSizeView.mas_top).with.offset(140);
        }];
    }
}

#pragma mark - 改变颜色
- (UIButton *)changeTextColor {
    if (!_changeTextColor) {
        _changeTextColor = [[UIButton alloc] init];
        [_changeTextColor setImage:[UIImage imageNamed:@"icon_change_color"] forState:(UIControlStateNormal)];
        [_changeTextColor setImage:[UIImage imageNamed:@"icon_change_colorClick"] forState:(UIControlStateSelected)];
        [_changeTextColor addTarget:self action:@selector(changeTextColorClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _changeTextColor.selected = NO;
    }
    return _changeTextColor;
}

//  显示颜色色板视图
- (void)changeTextColorClick:(UIButton *)button {
    [self thn_changeContentViewOffset:1];
    
    if (button.selected == NO) {
        button.selected = YES;
        self.fontSize.selected = NO;
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

#pragma mark - 改变字号
- (UIButton *)fontSize {
    if (!_fontSize) {
        _fontSize = [[UIButton alloc] init];
        [_fontSize setImage:[UIImage imageNamed:@"icon_change_font"] forState:(UIControlStateNormal)];
        [_fontSize setImage:[UIImage imageNamed:@"icon_change_fontClick"] forState:(UIControlStateSelected)];
        [_fontSize addTarget:self action:@selector(changeFontSizeClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _fontSize.selected = NO;
    }
    return _fontSize;
}

//  改变字号
- (void)changeFontSizeClick:(UIButton *)button {
    [self thn_changeContentViewOffset:0];
    
    if (button.selected == NO) {
        button.selected = YES;
        self.changeTextColor.selected = NO;
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

#pragma mark - 关闭键盘
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
    
    if (self.changeTextColor.selected == YES) {
        self.changeTextColor.selected = NO;
    }
}



@end
