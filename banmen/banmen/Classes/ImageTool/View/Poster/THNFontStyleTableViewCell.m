//
//  THNFontStyleTableViewCell.m
//  banmen
//
//  Created by FLYang on 2017/8/23.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNFontStyleTableViewCell.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import "THNDownloadFontTool.h"

@interface THNFontStyleTableViewCell ()

@property (nonatomic, strong) UIImageView *styleImage;
@property (nonatomic, strong) UILabel *fontNameLabel;
@property (nonatomic, strong) NSString *fontName;
@property (nonatomic, strong) UIImageView *selectIcon;

/**
 下载按钮
 */
@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation THNFontStyleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithHexString:@"#222222" alpha:1];
        
        [self thn_setCellViewUI];
    }
    return self;
}

- (void)thn_setFontStyleCellFontName:(NSString *)fontName {
    self.fontName = fontName;
    self.fontNameLabel.text = fontName;
    
    if ([THNDownloadFontTool thn_isDownloadedFont:fontName]) {
        self.downloadButton.hidden = YES;
    } else {
        self.downloadButton.hidden = NO;
    }
}

- (void)thn_setFontStyleCellFontName:(NSString *)fontName downloadStatus:(THNFontStyleDownloadStatus)status progress:(CGFloat)pro {
    self.fontName = fontName;
    self.fontNameLabel.text = fontName;
    
    switch (status) {
        case THNFontStyleDownloadStatusNone:
            self.downloadButton.hidden = NO;
            self.selectIcon.hidden = YES;
            break;
            
        case THNFontStyleDownloadStatusDone:
            self.downloadButton.hidden = YES;
            break;
            
        case THNFontStyleDownloadStatusLoading:
            self.downloadButton.hidden = YES;
            self.selectIcon.hidden = YES;
            [self thn_showDownProgressValue:pro];
            break;
    }
}

- (void)thn_showDownProgressValue:(CGFloat)pro {
    NSLog(@"=------------------------------ 下载中 %.2f", pro);
}

- (void)thn_hiddenSelectStyleRow:(BOOL)select {
    self.selectIcon.hidden = select;
}

- (void)thn_setCellViewUI {
//    [self addSubview:self.styleImage];
    [self addSubview:self.fontNameLabel];
    [self addSubview:self.downloadButton];
    [self addSubview:self.selectIcon];
}

- (UIImageView *)styleImage {
    if (!_styleImage) {
        _styleImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 130, 44)];
        _styleImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _styleImage;
}

- (UILabel *)fontNameLabel {
    if (!_fontNameLabel) {
        _fontNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 130, 44)];
        _fontNameLabel.font = [UIFont systemFontOfSize:14];
        _fontNameLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:1];
    }
    return _fontNameLabel;
}

#pragma mark 下载字体
- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 59, 0, 60, 44)];
        [_downloadButton setImage:[UIImage imageNamed:@"icon_download"] forState:(UIControlStateNormal)];
        _downloadButton.userInteractionEnabled = NO;
    }
    return _downloadButton;
}

#pragma mark 选中的标志
- (UIImageView *)selectIcon {
    if (!_selectIcon) {
        _selectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 10, 25, 25)];
        _selectIcon.image = [UIImage imageNamed:@"icon_select_font"];
        _selectIcon.contentMode = UIViewContentModeScaleAspectFill;
        _selectIcon.hidden = YES;
    }
    return _selectIcon;
}

#pragma mark - 分割线
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#4B4B4B"].CGColor);
    CGContextMoveToPoint(context, 15, 43);
    CGContextAddLineToPoint(context, self.frame.size.width - 15, 43);
    CGContextStrokePath(context);
}

@end
