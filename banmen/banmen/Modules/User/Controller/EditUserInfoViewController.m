//
//  EditUserInfoViewController.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "EditUserInfoViewController.h"
#import "EditUserView.h"
#import "UserModel.h"
#import "UIImage+Helper.h"
#import "AFNetworking.h"
#import "ChangPsdViewController.h"

@interface EditUserInfoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) EditUserView *editUserView;

@end

@implementation EditUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[UserModel findAll] lastObject];
    [self.view addSubview:self.editUserView];
    _editUserView.userModel = userModel;
    self.navigationItem.title = @"编辑账户";
    [self.editUserView.changHeadImageBtn addTarget:self action:@selector(changHeadImage) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editUserView.changPsdBtn addTarget:self action:@selector(changPsd) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)changPsd{
    ChangPsdViewController *vc = [ChangPsdViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changHeadImage{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //判断是否支持相机。模拟器没有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //调取相机
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
        }];
        [alertC addAction:cameraAction];
    }
    UIAlertAction *phontoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //调取相册
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:phontoAction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"tools/getToken"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *uploadToken = responseObject[@"data"][@"token"];
        NSString *uploadUrl = responseObject[@"data"][@"url"];
        
        AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
        NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
        params2[@"token"] = uploadToken;
        UserModel *userModel = [[UserModel findAll] lastObject];
        params2[@"x:user_id"] = userModel.userId;
        [manager2 POST:uploadUrl parameters:params2 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            UIImage * editedImg = [info objectForKey:UIImagePickerControllerEditedImage];
            NSData * iconData = UIImageJPEGRepresentation([UIImage fixOrientation:editedImg] , 1);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:iconData name:@"file" fileName:fileName mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *assetId = responseObject[@"asset_id"];
            NSString *assetUrl = responseObject[@"small"];
            AFHTTPSessionManager *manager3 = [AFHTTPSessionManager manager];
            NSMutableDictionary *params3 = [NSMutableDictionary dictionary];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            params3[@"token"] = [defaults objectForKey:@"token"];
            params3[@"id"] = assetId;
            [manager3 PUT:[kDomainBaseUrl stringByAppendingString:@"auth/addUserImage"] parameters:params3 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                UserModel *userModel = [[UserModel findAll] lastObject];
                userModel.srcfile = assetUrl;
                [userModel saveOrUpdate];
                self.editUserView.userModel = userModel;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(EditUserView *)editUserView{
    if (!_editUserView) {
        _editUserView = [[EditUserView alloc] initWithFrame:self.view.frame];
    }
    return _editUserView;
}

@end
