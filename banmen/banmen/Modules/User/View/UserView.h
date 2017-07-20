//
//  UserView.h
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface UserView : UIView

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIButton *updatePersonalInformationBtn;
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *goImageView;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *goodLabel;
@property(nonatomic, strong) UILabel *goodCountLabel;
@property(nonatomic, strong) UILabel *salesLabel;
@property(nonatomic, strong) UILabel *salesCountLabel;
@property(nonatomic, strong) UILabel *orderLabel;
@property(nonatomic, strong) UILabel *orderCountLabel;
@property(nonatomic, strong) UserModel *userModel;

@property(nonatomic, strong) UIView *middleView;
@property(nonatomic, strong) UIButton *aboutBtn;
@property(nonatomic, strong) UIButton *adjustBtn;
@property(nonatomic, strong) UIButton *welcomeBtn;
@property(nonatomic, strong) UIView *onelineView;
@property(nonatomic, strong) UIView *twolineView;
@property(nonatomic, strong) UIView *threelineView;
@property(nonatomic, strong) UIView *fourlineView;
@property(nonatomic, strong) UILabel *aboutLabel;
@property(nonatomic, strong) UILabel *adjustLabel;
@property(nonatomic, strong) UILabel *welcomeLabel;
@property(nonatomic, strong) UIImageView *onegoImageView;
@property(nonatomic, strong) UIImageView *twogoImageView;
@property(nonatomic, strong) UIImageView *threegoImageView;

@property(nonatomic, strong) UIButton *logOutBtn;

@end
