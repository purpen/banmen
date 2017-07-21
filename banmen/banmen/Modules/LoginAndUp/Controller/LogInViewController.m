//
//  LogUpViewController.m
//  banmen
//
//  Created by dong on 2017/7/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "LogInViewController.h"
#import "LogInView.h"
#import "AFNetworking.h"
#import "LogUpview.h"
#import "NSString+Helper.h"
#import "OtherMacro.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "UserModel.h"
#import "ForgetPsdViewController.h"

@interface LogInViewController ()

@property(nonatomic, strong) LogInView *logInView;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _logInView = [[LogInView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_logInView];
    
    [_logInView.logUpView.validationBtn addTarget:self action:@selector(validation:) forControlEvents:UIControlEventTouchUpInside];
    [_logInView.logUpView.logUpBtn addTarget:self action:@selector(logup) forControlEvents:(UIControlEventTouchUpInside)];
    [_logInView.logInBtn addTarget:self action:@selector(login) forControlEvents:(UIControlEventTouchUpInside)];
    [_logInView.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
    [_logInView.forgetPsdBtn addTarget:self action:@selector(forgetPsd) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)forgetPsd{
    ForgetPsdViewController *vc = [[ForgetPsdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)validation:(UIButton*)sender{
    if ([_logInView.logUpView.phoneTF.text checkTel]) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"phone"] = _logInView.logUpView.validationTF.text;
        [manager GET:[kDomainBaseUrl stringByAppendingString:@"auth/phone"] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
            manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
            params2[@"account"] = _logInView.logUpView.validationTF.text;
            [manager2 POST:[kDomainBaseUrl stringByAppendingString:@"auth/getRegisterCode"] parameters:params2 progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [SVProgressHUD showInfoWithStatus:@"获取验证码成功"];
                sender.enabled = NO;
                double delayInSeconds = 30;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    sender.enabled = YES;
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showInfoWithStatus:@"获取验证码失败"];
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"手机号已经注册过"];
        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"手机号填写错误"];
    }
}

-(void)logup{
    if ([_logInView.logUpView.phoneTF.text checkTel] && _logInView.logUpView.validationTF.text.length != 0 && _logInView.logUpView.psdUpTF.text.length >= 6) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"account"] = _logInView.logUpView.phoneTF.text;
        params[@"password"] = _logInView.logUpView.psdUpTF.text;
        params[@"code"] = _logInView.logUpView.validationTF.text;
        [manager POST:[kDomainBaseUrl stringByAppendingString:@"auth/register"] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *token = responseObject[@"data"][@"token"];
            [defaults setObject:token forKey:@"token"];
            [defaults synchronize];
            [self.logInView changState:_logInView.changBtn];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    } else {
        if (_logInView.logUpView.psdUpTF.text.length < 6) {
            [SVProgressHUD showInfoWithStatus:@"密码需六位及以上"];
        }
        [SVProgressHUD showInfoWithStatus:@"信息填写有误"];
    }
}

-(void)login{
    if (_logInView.accountTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"账号未填写"];
    } else if (_logInView.psdTF.text.length < 6) {
        [SVProgressHUD showInfoWithStatus:@"密码位数不够"];
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"account"] = _logInView.accountTF.text;
        params[@"password"] = _logInView.psdTF.text;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        params[@"token"] = [defaults objectForKey:@"token"];
        [manager POST:[kDomainBaseUrl stringByAppendingString:@"auth/login"] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *token = responseObject[@"data"][@"token"];
            [defaults setObject:token forKey:@"token"];
            [defaults synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
            UserModel *model = [[UserModel alloc] init];
            model.isLogin = YES;
            [model saveOrUpdate];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}

@end
