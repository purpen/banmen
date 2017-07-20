//
//  LogUpView.h
//  banmen
//
//  Created by dong on 2017/7/14.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogUpview;

@interface LogInView : UIView 

@property(nonatomic, strong) UIImageView *logoImageView;
@property(nonatomic, strong) UITextField *accountTF;
@property(nonatomic, strong) UIView *accountView;
@property(nonatomic, strong) UIImageView *accountImageView;
@property(nonatomic, strong) UILabel *accountLabel;
@property(nonatomic, strong) UIView *psdView;
@property(nonatomic, strong) UIImageView *psdImageView;
@property(nonatomic, strong) UILabel *psdLabel;
@property(nonatomic, strong) UITextField *psdTF;
@property(nonatomic, strong) UIButton *logInBtn;
@property(nonatomic, strong) UIButton *taihuoniaoAccountBtn;
@property(nonatomic, strong) UIButton *forgetPsdBtn;
@property(nonatomic, strong) UIView *leftLineView;
@property(nonatomic, strong) UILabel *thirdLabel;
@property(nonatomic, strong) UIView *rightLineView;
@property(nonatomic, strong) UIButton *wechatBtn;
@property(nonatomic, strong) UIButton *quanBtn;
@property(nonatomic, strong) UIButton *weiboBtn;
@property(nonatomic, strong) UIButton *qqBtn;
@property(nonatomic, strong) UILabel *tipLabel;
@property(nonatomic, strong) UIButton *changBtn;
@property(nonatomic, strong) LogUpview *logUpView;
@property(nonatomic, strong) UIView *logInView;
@property(nonatomic, strong) UIButton *cancelBtn;
@property(nonatomic, strong) UIView *fengeLineView;

-(void)changState:(UIButton*)sender;

@end
