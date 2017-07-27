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
@property (strong, nonatomic) UIWebView *mwebView;

@end

@implementation THNArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mwebView];
}

-(void)setContent:(NSString *)content{
    NSError  *error;
    NSString *markdown = content;
    NSString *htmlString = [MMMarkdown HTMLStringWithMarkdown:markdown error:&error];
    [self.mwebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://baidu.com"]];
}

-(UIWebView *)mwebView{
    if (!_mwebView) {
        _mwebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    }
    return _mwebView;
}

@end
