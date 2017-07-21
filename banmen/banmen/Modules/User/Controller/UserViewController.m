//
//  UserViewController.m
//  banmen
//
//  Created by dong on 2017/6/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UserViewController.h"
#import "UserView.h"
#import "UserModel.h"
#import "EditUserInfoViewController.h"
#import "BaseTarBarViewController.h"

@interface UserViewController () <UserModelDelegate>

@property(nonatomic, strong) UserView *userView;

@end

@implementation UserViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UserModel *userModel = [[UserModel findAll] lastObject];
    userModel.delegate = self;
    [userModel netGetUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.userView];
    [self.userView.updatePersonalInformationBtn addTarget:self action:@selector(updateUserInfo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.userView.updatePersonalInformationBtn addTarget:self action:@selector(updateUserInfo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.userView.aboutBtn addTarget:self action:@selector(about) forControlEvents:(UIControlEventTouchUpInside)];
    [self.userView.adjustBtn addTarget:self action:@selector(adjust) forControlEvents:(UIControlEventTouchUpInside)];
    [self.userView.welcomeBtn addTarget:self action:@selector(welcom) forControlEvents:(UIControlEventTouchUpInside)];
    [self.userView.logOutBtn addTarget:self action:@selector(logOut) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)logOut{
    [UserModel clearTable];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"token"];
    [defaults synchronize];
    [[BaseTarBarViewController sharedManager] setSelectedIndex:0];
}

-(void)welcom{
    
}

-(void)adjust{
    
}

-(void)about{
    
}

-(void)updateUserInfo{
    EditUserInfoViewController *vc = [[EditUserInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)update{
    UserModel *userModel = [[UserModel findAll] lastObject];
    self.userView.userModel = userModel;
}

-(UserView *)userView{
    if (!_userView) {
        _userView = [[UserView alloc] initWithFrame:self.view.frame];
    }
    return _userView;
}

@end
