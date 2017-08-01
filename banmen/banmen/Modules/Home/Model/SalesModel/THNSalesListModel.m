//
//  THNSalesListModel.m
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNSalesListModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation THNSalesListModel

-(void)salesListModel:(NSString *)startTime andEndTime:(NSString *)endTime{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start_time"] = startTime;
    params[@"end_time"] = endTime;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/salesRanking"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [THNSalesListModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(salesListModel:)]) {
            [self.delegate salesListModel:self.modelAry];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
