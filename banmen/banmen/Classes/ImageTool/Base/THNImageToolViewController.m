//
//  THNImageToolViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNImageToolViewController.h"
#import "MainMacro.h"
#import "UIColor+Extension.h"

@interface THNImageToolViewController ()

@end

@implementation THNImageToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_initViewControllerUI];
}

- (void)thn_initViewControllerUI {
    self.view.backgroundColor = [UIColor colorWithHexString:kColorBackground];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
