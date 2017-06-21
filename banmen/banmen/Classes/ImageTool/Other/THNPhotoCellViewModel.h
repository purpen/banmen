//
//  THNPhotoCellViewModel.h
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef UITableViewCell *(^THNCellRenderBlock)(NSIndexPath *indexPath, UITableView *tableView);
typedef void(^THNCellSelectionBlock)(NSIndexPath *indexPath, UITableView *tableView);

@interface THNPhotoCellViewModel : NSObject

@property (nonatomic, copy) THNCellRenderBlock randerBlock;
@property (nonatomic, copy) THNCellSelectionBlock selectionBlock;
@property (nonatomic, assign) CGFloat height;

@end
