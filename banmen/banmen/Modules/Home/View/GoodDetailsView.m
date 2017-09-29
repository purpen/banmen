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

-(void)setModelAry:(NSMutableArray *)modelAry{
    _modelAry = modelAry;
    [self.tableView reloadData];
}

-(void)setArticleModelAry:(NSMutableArray *)articleModelAry{
    _articleModelAry = articleModelAry;
    [self.tableView reloadData];
}

-(void)setVideoModelAry:(NSMutableArray *)videoModelAry{
    _videoModelAry = videoModelAry;
    [self.tableView reloadData];
}

-(void)setPictureModelAry:(NSMutableArray *)pictureModelAry{
    _pictureModelAry = pictureModelAry;
    [self.tableView reloadData];
}

-(void)setModel:(GoodsDetailModel *)model{
    _model = model;
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.frame style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GoodsDetailTableViewCell class] forCellReuseIdentifier:@"GoodsDetailTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MaterialTableViewCell class] forCellReuseIdentifier:@"MaterialTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 438/2+5;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 438/2+5;
    } else {
        switch (self.category) {
            case 0:
                //文字素材
            {
                if (self.sender_selected) {
                    return 190/2+(112+15)*(self.modelAry.count)+50;
                } else {
                    if (self.modelAry.count % 2 == 0) {
                        return 190/2+(361/2+15)*(self.modelAry.count/2)+50;
                    }
                    return 190/2+(361/2+15)*(self.modelAry.count/2+1)+50;
                }
            }
                break;
            case 1:
                //文章
            {
                if (self.sender_selected) {
                    return 190/2+((142/2+7)/667.0*SCREEN_HEIGHT)*(self.articleModelAry.count)+60;
                } else {
                    if (self.articleModelAry.count % 2 == 0) {
                        return 190/2+(361/2+15)*(self.articleModelAry.count/2)+50;
                    }
                    return 190/2+(361/2+15)*(self.articleModelAry.count/2+1)+50;
                }
            }
                break;
            case 2:
                //图片
            {
                if (self.sender_selected) {
                    return 190/2+(51+15)*(self.pictureModelAry.count)+50;
                } else {
                    if (self.pictureModelAry.count % 4 == 0) {
                        return 190/2+((SCREEN_WIDTH-3)/4+15)*(self.pictureModelAry.count/4)+50;
                    }
                    return 190/2+((SCREEN_WIDTH-3)/4+15)*(self.pictureModelAry.count/4+1)+50;
                }
            }
                break;
            case 3:
                //视频
            {
                if (self.sender_selected) {
                    return (142/2+30)*(self.videoModelAry.count)+50+120;
                } else {
                    if (self.videoModelAry.count % 2 == 0) {
                        return 190/2+((SCREEN_WIDTH-45)/2+15)*(self.videoModelAry.count/2)+50;
                    }
                    return 190/2+((SCREEN_WIDTH-45)/2+15)*(self.videoModelAry.count/2+1)+50;
                }
            }
                break;
                
            default:
                break;
        }
    }
    return 0;
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
        [cell.switchingArrangementBtn addTarget:self action:@selector(switchingArrangement:) forControlEvents:UIControlEventTouchUpInside];
        cell.modelAry = self.modelAry;
        cell.articleModelAry = self.articleModelAry;
        cell.pictureModelAry = self.pictureModelAry;
        cell.videoModelAry = self.videoModelAry;
        cell.controller = self.controller;
        return cell;
    }
}

-(void)switchingArrangement:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.sender_selected = sender.selected;
    MaterialTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [self.tableView reloadData];
    [cell.collectionView reloadData];
}

-(void)segmentedChanged:(UISegmentedControl*)sender
{
    self.category = sender.selectedSegmentIndex;
    MaterialTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:sender.selectedSegmentIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:YES];
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
        NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.model.product_id, @"id", status, @"status" , nil];
        NSNotification *notification =[NSNotification notificationWithName:@"addGoods" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        self.model.status = [status integerValue];
        if ([self.delegate respondsToSelector:@selector(uploadModel:)]) {
            [self.delegate uploadModel:[status integerValue]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
