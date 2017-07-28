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
#import "OtherMacro.h"

@interface THNWordDetailViewController ()

@property (weak, nonatomic) IBOutlet UIView *wordView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cnacelBtn;
@end

@implementation THNWordDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.textView.editable = NO;
    self.wordView.layer.masksToBounds = YES;
    self.wordView.layer.cornerRadius = 5;
    self.textView.text = self.word;
    CGSize sizeToFit = [self.textView sizeThatFits:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT)];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.wordView.mas_bottom).offset(-5);
        make.left.equalTo(self.wordView.mas_left).offset(5);
        make.right.equalTo(self.wordView.mas_right).offset(-5);
        make.top.equalTo(self.wordView.mas_top).offset(5);
        make.height.mas_lessThanOrEqualTo(300);
        make.height.mas_equalTo(sizeToFit.height);
    }];
}

-(void)setWord:(NSString *)word{
    _word = word;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
