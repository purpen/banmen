//
//  ForgetPsdView.h
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPsdView : UIView

@property (nonatomic, strong) UILabel *tipLabel;

@property(nonatomic, strong) UITextField *phoneTF;
@property(nonatomic, strong) UITextField *validationTF;
@property(nonatomic, strong) UIButton *validationBtn;
@property(nonatomic, strong) UITextField *psdUpTF;
@property(nonatomic, strong) UIButton *commitBtn;

@property(nonatomic, strong) UIView *navView;
@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *navTitleLabel;

@end
