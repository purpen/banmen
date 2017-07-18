//
//  Cooperation.m
//  banmen
//
//  Created by dong on 2017/7/17.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "Cooperation.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation Cooperation

-(NSMutableArray *)modelAry{
    if (!_modelAry) {
        _modelAry = [NSMutableArray array];
    }
    return _modelAry;
}

-(void)getCooperationItemList{
    self.current_page = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    NSLog(@"asdas %@",params[@"token"]);
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/cooperateProductLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_rows = [responseObject[@"meta"][@"pagination"][@"total"] integerValue];
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [Cooperation mj_objectArrayWithKeyValuesArray:rows];
        if ([self.cDelegate respondsToSelector:@selector(getCooperation: andC: andT:)]) {
            [self.cDelegate getCooperation:self.modelAry andC:self.current_page andT:self.total_rows];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getMoreCooperationItemList:(NSInteger)currentPage{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(++ self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/cooperateProductLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_rows = [responseObject[@"meta"][@"pagination"][@"total"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [Cooperation mj_objectArrayWithKeyValuesArray:rows];
        if ([self.cDelegate respondsToSelector:@selector(getMoreCooperation: andC: andT:)]) {
            [self.cDelegate getMoreCooperation:ary andC:self.current_page andT:self.total_rows];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
