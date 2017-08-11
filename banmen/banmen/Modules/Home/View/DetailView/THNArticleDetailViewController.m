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
#import "THNShareViewController.h"

@interface THNArticleDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *htmlStr;

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
    NSURL *url = [NSURL URLWithString:self.content];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void)share{
    THNShareViewController *vc = [[THNShareViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    vc.model = self.model;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

@end
