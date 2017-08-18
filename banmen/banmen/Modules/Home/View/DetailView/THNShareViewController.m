//
//  THNShareViewController.m
//  banmen
//
//  Created by dong on 2017/8/11.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNShareViewController.h"
#import "UMSocialCore/UMSocialCore.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"

@interface THNShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *btnContentView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation THNShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnContentView.layer.masksToBounds = YES;
    self.btnContentView.layer.cornerRadius = 5;
    
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 4;
}

- (IBAction)otherCancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)more:(id)sender {
    //分享的标题
    NSString *textToShare = _model.title;
    //分享的图片
//    UIImage *imageToShare = [UIImage imageNamed:@"312.jpg"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:self.model.share];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        } else  {
            [SVProgressHUD showErrorWithStatus:@"分享失败"];
        }
    };
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* strUrl = self.model.cover_srcfile;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    UIImage *image = [cache imageFromDiskCacheForKey:key];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.model.title descr:self.model.article_describe thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = self.model.share;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"分享失败"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)sina:(id)sender {
    [self shareWebPageToPlatformType:(UMSocialPlatformType_Sina)];
}

- (IBAction)pengYouQuan:(id)sender {
    [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatTimeLine)];
}

- (IBAction)weiXin:(id)sender {
    [self shareWebPageToPlatformType:(UMSocialPlatformType_WechatSession)];
}

@end
