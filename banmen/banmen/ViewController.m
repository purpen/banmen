//
//  ViewController.m
//  banmen
//
//  Created by FLYang on 2017/6/15.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "ViewController.h"
#import "THNImageToolNavigationController.h"
#import "THNLayoutViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *goPhoto;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goPhoto:(UIButton *)sender {
    NSLog(@"tiaozhuandaozhaopian");
    [self thn_initImageToolViewController];
}

- (void)thn_initImageToolViewController {
    THNLayoutViewController *imageLayoutController = [[THNLayoutViewController alloc] init];
    THNImageToolNavigationController *imageToolNavController = [[THNImageToolNavigationController alloc] initWithRootViewController:imageLayoutController];
    [self presentViewController:imageToolNavController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
