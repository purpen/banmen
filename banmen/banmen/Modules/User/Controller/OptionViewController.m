//
//  OptionViewController.m
//  Fiu
//
//  Created by THN-Dong on 16/4/25.
//  Copyright © 2016年 taihuoniao. All rights reserved.
//

#import "OptionViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "UIColor+Extension.h"

@interface OptionViewController ()<UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UITextView *optionTFV;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
    
    self.navigationItem.title = @"意见反馈";
    self.phoneTF.delegate = self;
    self.optionTFV.delegate = self;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 3;
}

- (IBAction)clickSubmitBtn:(UIButton *)sender {
    if (self.optionTFV.text.length > 200) {
        [SVProgressHUD showInfoWithStatus:@"不能多于200个字"];
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *params = @{
                             @"content":self.optionTFV.text,
                             @"contact":self.phoneTF.text,
                             @"token" : [defaults objectForKey:@"token"]
                             };
    [manager POST:[kDomainBaseUrl stringByAppendingString:@"feedback/store"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
        [self.navigationController popViewControllerAnimated:YES];
        return ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.remindLabel.hidden = YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    if (textView.text.length == 0) {
        self.remindLabel.hidden = NO;
    }else{
        self.remindLabel.hidden = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}

@end
