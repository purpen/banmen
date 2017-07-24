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

@interface GoodDetailsView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation GoodDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
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
    GoodsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailTableViewCell"];
    cell.model = self.model;
    [cell.relationshipBtn addTarget:self action:@selector(relationship:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.editPicturesMaterialBtn addTarget:self action:@selector(editPicturesMaterial) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
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
