//
//  GoodsDetailModel.m
//  banmen
//
//  Created by dong on 2017/7/21.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "GoodsDetailModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation GoodsDetailModel

-(void)netGetGoodsDetailModel:(NSString *)product_id{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"product_id"] = product_id;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/info"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"data"];
        GoodsDetailModel *model = [GoodsDetailModel mj_objectWithKeyValues:dict];
        if ([self.delegate respondsToSelector:@selector(getGoodsDetailModel:)]) {
            [self.delegate getGoodsDetailModel:model];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
