//
//  THNArticleDetailViewController.m
//  banmen
//
//  Created by dong on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNArticleDetailViewController.h"
#import <MMMarkdown/MMMarkdown.h>

@interface THNArticleDetailViewController ()

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
    [self.webView loadHTMLString:self.htmlStr baseURL:[NSURL URLWithString:@"http://baidu.com"]];
}

-(void)share{
    
}

-(void)setContent:(NSString *)content{
    _content = content;
    NSError  *error;
    NSString *markdown = content;
    self.htmlStr = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
}

@end
