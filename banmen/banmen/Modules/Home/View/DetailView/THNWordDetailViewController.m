//
//  THNWordDetailViewController.m
//  banmen
//
//  Created by dong on 2017/7/27.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNWordDetailViewController.h"
#import "UIView+FSExtension.h"
#import "Masonry.h"

@interface THNWordDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *wordView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cnacelBtn;

@end

@implementation THNWordDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)setWord:(NSString *)word{
    self.textView.text = word;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
