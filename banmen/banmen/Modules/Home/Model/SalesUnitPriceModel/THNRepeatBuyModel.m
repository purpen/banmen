//
//  THNRepeatBuyModel.m
//  banmen
//
//  Created by dong on 2017/8/2.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNRepeatBuyModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

@implementation THNRepeatBuyModel

-(void)repeatBuyModel:(NSString *)startTime andEndTime:(NSString *)endTime{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"start_time"] = startTime;
    params[@"end_time"] = endTime;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/repeatPurchase"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *rows = responseObject[@"data"];
        self.modelAry = [THNRepeatBuyModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(repeatBuyModel:)]) {
            [self.delegate repeatBuyModel:self.modelAry];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end

