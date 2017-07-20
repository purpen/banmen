//
//  UnitPriceModel.m
//  banmen
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UnitPriceModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation UnitPriceModel

-(void)NetGetUnitPriceModel:(NSString *)startTime andEndTime:(NSString *)endTime{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start_time"] = startTime;
    params[@"end_time"] = endTime;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/customerPriceDistribution"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [UnitPriceModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.uDelegate respondsToSelector:@selector(updateUnitPriceModel:)]) {
            [self.uDelegate updateUnitPriceModel:self.modelAry];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
