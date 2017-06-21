//
//  THNPhotoTableViewModel.m
//  banmen
//
//  Created by FLYang on 2017/6/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPhotoTableViewModel.h"

@implementation THNPhotoTableViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellModelArray = [NSMutableArray array];
    }
    return self;
}

- (THNPhotoCellViewModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        THNPhotoCellViewModel *cellModel = self.cellModelArray[indexPath.row];
        return cellModel;
    } @catch (NSException *exception) {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    THNPhotoCellViewModel *cellModel = [self cellModelAtIndexPath:indexPath];
    return cellModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    THNPhotoCellViewModel *cellModel = [self cellModelAtIndexPath:indexPath];
    THNCellSelectionBlock selectionBlock = cellModel.selectionBlock;
    if (selectionBlock) {
        selectionBlock(indexPath, tableView);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THNPhotoCellViewModel *cellModel = [self cellModelAtIndexPath:indexPath];
    UITableViewCell *cell = nil;
    THNCellRenderBlock renderBlock = cellModel.randerBlock;
    if (renderBlock) {
        cell = renderBlock(indexPath, tableView);
    }
    return cell;
}


@end
