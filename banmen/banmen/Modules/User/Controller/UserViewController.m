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

@interface UserViewController () <UserModelDelegate>

@property(nonatomic, strong) UserView *userView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UserModel *userModel = [[UserModel findAll] lastObject];
    userModel.delegate = self;
    [userModel netGetUserInfo];
    [self.view addSubview:self.userView];
    [self.userView.updatePersonalInformationBtn addTarget:self action:@selector(updateUserInfo) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)updateUserInfo{
    
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
