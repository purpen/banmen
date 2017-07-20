//
//  SalesChannelsModel.m
//  banmen
//
//  Created by dong on 2017/7/18.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "SalesChannelsModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation SalesChannelsModel

-(void)getSalesChannelsModelItem:(NSString*)startTime andEndTime:(NSString*)endTime{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start_time"] = startTime;
    params[@"end_time"] = endTime;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/sourceSales"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [SalesChannelsModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.sDelegate respondsToSelector:@selector(updateSalesChannelsModel:)]) {
            [self.sDelegate updateSalesChannelsModel:self.modelAry];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
