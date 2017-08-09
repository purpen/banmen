//
//  THNArticleDetailViewController.m
//  banmen
//
//  Created by dong on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNArticleDetailViewController.h"
#import <MMMarkdown/MMMarkdown.h>
#import "THNShareActionView.h"
#import "UIView+FSExtension.h"

@interface THNArticleDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *htmlStr;
@property (strong, nonatomic) THNShareActionView *shareView;

@end

@implementation THNArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"文章素材";
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:(UIControlStateNormal)];
    shareBtn.size = shareBtn.currentImage.size;
    [shareBtn addTarget:self action:@selector(share) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *shareB = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareB;
    
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL URLWithString:@"http://baidu.com"]];
    
//    self.shareView = [[THNShareActionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
//    [self.view addSubview:self.shareView];
//    [self.shareView thn_showShareViewController:self messageObject:[self shareMessageObject] shareImage:self.doneImage];
}

-(void)share{
//    [UIView animateWithDuration:0.25 animations:^{
//        self.shareView.y = SCREEN_HEIGHT-self.shareView.height;
//    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
    

-(void)setContent:(NSString *)content{
    _content = content;
    NSError  *error;
    NSString *markdown = content;
    self.htmlStr = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
}

@end
