//
//  THNDateSelectViewController.h
//  banmen
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THNDateSelectViewControllerDelegate <NSObject>

-(void)getDate:(NSDate*)startDate andEnd:(NSDate*)endDate;

@end

@interface THNDateSelectViewController : UIViewController

@property (nonatomic, weak) id<THNDateSelectViewControllerDelegate> delegate;

@end
