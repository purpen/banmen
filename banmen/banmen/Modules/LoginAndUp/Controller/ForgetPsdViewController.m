//
//  ForgetPsdViewController.m
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "ForgetPsdViewController.h"
#import "ForgetPsdView.h"
#import "AFNetworking.h"
#import "NSString+Helper.h"
#import "OtherMacro.h"
#import "SVProgressHUD.h"
#import "Masonry.h"

@interface ForgetPsdViewController ()

@property (nonatomic, strong) ForgetPsdView *forgetPsdView;

@end

@implementation ForgetPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.forgetPsdView];
    [self.forgetPsdView.backBtn addTarget:self action:@selector(backBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.forgetPsdView.validationBtn addTarget:self action:@selector(validation:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.forgetPsdView.commitBtn addTarget:self action:@selector(commit) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)validation:(UIButton*)sender{
    if ([self.forgetPsdView.phoneTF.text checkTel]) {
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
        params2[@"phone"] = self.forgetPsdView.phoneTF.text;
        [manager2 POST:[kDomainBaseUrl stringByAppendingString:@"auth/getRetrieveCode"] parameters:params2 progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"获取验证码成功"];
            sender.enabled = NO;
            double delayInSeconds = 30;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                sender.enabled = YES;
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"获取验证码失败"];
        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"手机号填写错误"];
    }
}

-(void)commit{
    if ([self.forgetPsdView.phoneTF.text checkTel] && self.forgetPsdView.validationTF.text.length != 0 && self.forgetPsdView.psdUpTF.text.length >= 6) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = self.forgetPsdView.phoneTF.text;
        params[@"password"] = self.forgetPsdView.psdUpTF.text;
        params[@"code"] = self.forgetPsdView.validationTF.text;
        [manager POST:[kDomainBaseUrl stringByAppendingString:@"auth/retrievePassword"] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            [self backBtn];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    } else {
        if (self.forgetPsdView.psdUpTF.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:@"密码需六位及以上"];
        }
        [SVProgressHUD showInfoWithStatus:@"信息填写有误"];
    }
}

-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

-(ForgetPsdView *)forgetPsdView{
    if (!_forgetPsdView) {
        _forgetPsdView = [[ForgetPsdView alloc] initWithFrame:self.view.frame];
    }
    return _forgetPsdView;
}

@end
