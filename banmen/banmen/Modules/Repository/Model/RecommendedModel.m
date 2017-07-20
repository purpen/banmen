//
//  RecommendedModel.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "RecommendedModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation RecommendedModel

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

-(void)getRecommendedModelList{
    self.current_page = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/recommendList"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [RecommendedModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.rDelegate respondsToSelector:@selector(get:andC:andT:)]) {
            [self.rDelegate get:self.modelAry andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getMoreRecommendedModelList:(NSInteger)currentPage{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(++ self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/recommendList"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [RecommendedModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.rDelegate respondsToSelector:@selector(getMore:andC:andT:)]) {
            [self.rDelegate getMore:self.modelAry andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
