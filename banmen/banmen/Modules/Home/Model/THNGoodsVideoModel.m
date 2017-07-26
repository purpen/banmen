//
//  THNGoodsVideoModel.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsVideoModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation THNGoodsVideoModel

-(void)netGetVideo:(NSString *)productId{
    self.current_page = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    params[@"product_id"] = productId;
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/videoLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [THNGoodsVideoModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(video:andC:andT:)]) {
            [self.delegate video:ary andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)netGetMoreGoodsVideo:(NSString *)productId andCurrent_page:(NSInteger)current_page{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    params[@"product_id"] = productId;
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/videoLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [THNGoodsVideoModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(videoMore:andC:andT:)]) {
            [self.delegate videoMore:ary andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
