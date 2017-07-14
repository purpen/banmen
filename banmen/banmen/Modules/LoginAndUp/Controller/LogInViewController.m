//
//  LogUpViewController.m
//  banmen
//
//  Created by dong on 2017/7/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "LogInViewController.h"
#import "LogInView.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *logInView = [[LogInView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:logInView];
}

@end
