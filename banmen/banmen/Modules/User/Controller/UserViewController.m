//
//  UserViewController.m
//  banmen
//
//  Created by dong on 2017/6/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UserViewController.h"
#import "UserView.h"

@interface UserViewController ()

@property(nonatomic, strong) UserView *userView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.userView];
}

-(UserView *)userView{
    if (!_userView) {
        _userView = [[UserView alloc] initWithFrame:self.view.frame];
    }
    return _userView;
}

@end
