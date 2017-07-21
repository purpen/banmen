//
//  ChangPsdViewController.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "ChangPsdViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIColor+Extension.h"

@interface ChangPsdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPsdTF;
@property (weak, nonatomic) IBOutlet UITextField *nowPsdTF;
@property (weak, nonatomic) IBOutlet UIButton *commit;


@end

@implementation ChangPsdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    [self.commit addTarget:self action:@selector(commitBtn) forControlEvents:UIControlEventTouchUpInside];
    self.commit.backgroundColor = [UIColor colorWithHexString:@"#be8914"];
    [self.commit setTitle:@"提交" forState:(UIControlStateNormal)];
    [self.commit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commit.font = [UIFont systemFontOfSize:16];
    self.commit.layer.masksToBounds = YES;
    self.commit.layer.cornerRadius = 2;
}

-(void)commitBtn{
    if (self.oldPsdTF.text.length >= 6 && self.nowPsdTF.text.length >= 6) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"old_password"] = self.oldPsdTF.text;
        params[@"password"] = self.nowPsdTF.text;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        params[@"token"] = [defaults objectForKey:@"token"];
        [manager POST:[kDomainBaseUrl stringByAppendingString:@"auth/changePassword"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showSuccessWithStatus:error.localizedDescription];
        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"密码位数有问题"];
    }
}


@end
