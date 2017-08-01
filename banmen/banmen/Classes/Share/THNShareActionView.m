//
//  THNShareActionView.m
//  banmen
//
//  Created by FLYang on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNShareActionView.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"
#import <SVProgressHUD/SVProgressHUD.h>

static const NSInteger shareButtonTag = 810;

@interface THNShareActionView () {
    UMSocialMessageObject *_shareMessageObject;
    UIViewController *_shareController;
    UIImage *_shareImage;
}

@property (nonatomic, strong) UILabel *viewTitleLabel;

@end

@implementation THNShareActionView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
        [self thn_setViewUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:kColorBackground alpha:0];
        [self thn_setViewUI];
    }
    return self;
}

- (void)thn_showShareViewController:(UIViewController *)controller messageObject:(UMSocialMessageObject *)object shareImage:(UIImage *)image {
    _shareController = controller;
    _shareMessageObject = object;
    _shareImage = image;
    
    NSArray *titleArr = @[@"微信", @"朋友圈", @"微博", @"更多"];
    NSArray *iconImageArr = @[@"icon_share_wechat", @"icon_share_timeline", @"icon_share_weibo", @"icon_share_more"];
    
    [self thn_creatButton:titleArr iconImage:iconImageArr];
}

- (void)thn_setViewUI {
    [self addSubview:self.viewTitleLabel];
    [_viewTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self).with.offset(0);
        make.height.mas_equalTo(@15);
    }];
}

- (void)thn_creatButton:(NSArray *)title iconImage:(NSArray *)iconImage {
    for (NSInteger idx = 0; idx < title.count; ++ idx) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:iconImage[idx]] forState:(UIControlStateNormal)];
        button.tag = shareButtonTag + idx;
        [button addTarget:self action:@selector(shareButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - 30) / title.count, (SCREEN_WIDTH - 30) / title.count));
            make.left.equalTo(self.mas_left).with.offset(15 + ((SCREEN_WIDTH - 30) / title.count) * idx);
            make.top.equalTo(self.mas_top).with.offset(25);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = title[idx];
        label.textColor = [UIColor colorWithHexString:kColorWhite];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@12);
            make.left.right.equalTo(button).with.offset(0);
            make.top.equalTo(button.mas_bottom).with.offset(-10);
        }];
    }
}

- (void)shareButton:(UIButton *)button {
    switch (button.tag - shareButtonTag) {
        case 0:
            [self shareToPlatform:UMSocialPlatformType_WechatSession];
            break;
        case 1:
            [self shareToPlatform:UMSocialPlatformType_WechatTimeLine];
            break;
        case 2:
            [self shareToPlatform:UMSocialPlatformType_Sina];
            break;
        case 3:
            [self systemShareWithImage:_shareImage];
            break;
    }
}

- (void)shareToPlatform:(UMSocialPlatformType)type {
    [[UMSocialManager defaultManager] shareToPlatform:(type)
                                        messageObject:_shareMessageObject
                                currentViewController:_shareController
                                           completion:^(id result, NSError *error) {
                                               if (error) {
                                                   [SVProgressHUD showErrorWithStatus:@"分享失败"];
                                               } else{
                                                   [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                                               }
                                           }];
}

- (void)systemShareWithImage:(UIImage *)image {
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:image, nil] applicationActivities:nil];
    [_shareController presentViewController:activityController animated:true completion:nil];
}

- (UILabel *)viewTitleLabel {
    if (!_viewTitleLabel) {
        _viewTitleLabel = [[UILabel alloc] init];
        _viewTitleLabel.font = [UIFont systemFontOfSize:14];
        _viewTitleLabel.textColor = [UIColor colorWithHexString:@"#D8D8D8"];
        _viewTitleLabel.textAlignment = NSTextAlignmentCenter;
        _viewTitleLabel.text = @"分享";
    }
    return _viewTitleLabel;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"#979797"].CGColor);
    CGContextMoveToPoint(context, 20, 30);
    CGContextAddLineToPoint(context, self.frame.size.width - 20, 30);
    CGContextStrokePath(context);
}

@end
