//
//  THNHourOrderModel.m
//  banmen
//
//  Created by dong on 2017/8/1.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNHourOrderModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation THNHourOrderModel

-(void)hourOrderModel:(NSString *)startTime andEndTime:(NSString *)endTime{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start_time"] = startTime;
    params[@"end_time"] = endTime;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/hourOrder"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [THNHourOrderModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(hourOrderModel:)]) {
            [self.delegate hourOrderModel:self.modelAry];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
