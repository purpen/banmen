//
//  RangePickerCell.m
//  banmen
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "RangePickerCell.h"
#import "FSCalendarExtensions.h"
#import "UIColor+Extension.h"
#import "UIView+FSExtension.h"

@implementation RangePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CALayer *selectionLayer = [[CALayer alloc] init];
        selectionLayer.backgroundColor = [UIColor colorWithHexString:@"#F9E082"].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        self.selectionLayer.masksToBounds = YES;
        self.selectionLayer.cornerRadius = 53.5/2;
        
        CALayer *middleLayer = [[CALayer alloc] init];
        middleLayer.backgroundColor = [UIColor colorWithHexString:@"#F9E082"alpha:0.3].CGColor;
        middleLayer.actions = @{@"hidden":[NSNull null]}; // Remove hiding animation
        [self.contentView.layer insertSublayer:middleLayer below:self.titleLabel.layer];
        self.middleLayer = middleLayer;
        
        // Hide the default selection layer
        self.shapeLayer.hidden = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    self.selectionLayer.frame = CGRectMake(0, (60-53.5)/2, 53.5, 53.5);
    self.middleLayer.frame = CGRectMake(0, (60-53.5)/2, 53.5, 53.5);
}

@end
