//
//  GoodDetailsView.m
//  banmen
//
//  Created by dong on 2017/7/20.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodDetailsView.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "GoodsDetailTableViewCell.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MaterialTableViewCell.h"
#import "THNGoodsWorld.h"
#import "UIView+FSExtension.h"

@interface GoodDetailsView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GoodDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.tableView reloadData];
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.contentInset = UIEdgeInsetsMake(-54/SCREEN_HEIGHT*667.0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GoodsDetailTableViewCell class] forCellReuseIdentifier:@"GoodsDetailTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MaterialTableViewCell class] forCellReuseIdentifier:@"MaterialTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 438/2+5;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 438/2+5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        GoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailTableViewCell"];
        cell.model = self.model;
        [cell.relationshipBtn addTarget:self action:@selector(relationship:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.editPicturesMaterialBtn addTarget:self action:@selector(editPicturesMaterial) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    } else {
        MaterialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MaterialTableViewCell"];
        [cell.segmentedC addTarget:self action:@selector(segmentedChanged:) forControlEvents:UIControlEventValueChanged];
        [cell.switchingArrangementBtn addTarget:self action:@selector(switchingArrangement:) forControlEvents:UIControlEventValueChanged];
//        cell.modelAry = self.modelAry;
        return cell;
    }
}

-(void)switchingArrangement:(UIButton*)sender{
    sender.selected = !sender.selected;
}

-(void)segmentedChanged:(UISegmentedControl*)sender
{
    MaterialTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:sender.selectedSegmentIndex inSection:0] animated:YES scrollPosition:(UICollectionViewScrollPositionCenteredVertically)];
    if ([self.delegate respondsToSelector:@selector(chooseWhichClassification:)]) {
        [self.delegate chooseWhichClassification:sender.selectedSegmentIndex];
    }
}

-(void)editPicturesMaterial{
    if ([self.delegate respondsToSelector:@selector(editPictures)]) {
        [self.delegate editPictures];
    }
}

-(void)relationship:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSString *status;
    if (sender.selected == YES) {
        status = @"1";
    } else {
        status = @"0";
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = status;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    params[@"product_id"] = self.model.product_id;
    [manager POST:[kDomainBaseUrl stringByAppendingString:@"product/trueCooperate"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.model.status = [status integerValue];
        if ([self.delegate respondsToSelector:@selector(uploadModel:)]) {
            [self.delegate uploadModel:[status integerValue]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
