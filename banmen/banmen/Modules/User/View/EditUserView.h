//
//  EditUserView.h
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface EditUserView : UIView

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UIButton *changHeadImageBtn;
@property(nonatomic, strong) UILabel *headTipLabel;
@property(nonatomic, strong) UIImageView *headImageView;
@property(nonatomic, strong) UIImageView *goImageView;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *nameTipLabel;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UserModel *userModel;

@property(nonatomic, strong) UIView *changPsdView;
@property(nonatomic, strong) UIButton *changPsdBtn;
@property(nonatomic, strong) UILabel *changPsdLabel;
@property(nonatomic, strong) UIImageView *changPsdGoImageView;

@end
