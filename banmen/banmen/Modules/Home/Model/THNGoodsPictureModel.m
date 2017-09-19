//
//  THNGoodsPictureModel.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsPictureModel.h"
#import "AFNetworking.h"
#import "OtherMacro.h"
#import "MJExtension.h"

NSString *const kProductPictureModelData = @"data";
NSString *const kProductPictureModelDataImage = @"image";
NSString *const kProductPictureModelDataImageP = @"p800";

@implementation THNGoodsPictureModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"image" : @"image.srcfile"
             };
}

-(void)netGetpicture:(NSString *)productId{
    self.current_page = 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(self.current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    params[@"product_id"] = productId;
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/imageLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [THNGoodsPictureModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(picture:andC:andT:)]) {
            [self.delegate picture:ary andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)netGetMoreGoodsPicture:(NSString *)productId andCurrent_page:(NSInteger)current_page{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"per_page"] = @(10);
    params[@"page"] = @(current_page);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    params[@"product_id"] = productId;
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/imageLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.current_page = [responseObject[@"meta"][@"pagination"][@"current_page"] integerValue];
        self.total_pages = [responseObject[@"meta"][@"pagination"][@"total_pages"] integerValue];
        NSArray *rows = responseObject[@"data"];
        NSArray *ary = [THNGoodsPictureModel mj_objectArrayWithKeyValuesArray:rows];
        if ([self.delegate respondsToSelector:@selector(pictureMore:andC:andT:)]) {
            [self.delegate pictureMore:ary andC:self.current_page andT:self.total_pages];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)thn_requestProductImageWithProductId:(NSString *)productId count:(NSInteger)count completion:(void (^)(NSArray *))completion {
    NSMutableArray<NSString *> *imageUrlArray = [NSMutableArray array];
    
    NSDictionary *params = @{@"product_id":productId,
                               @"per_page":@(count),
                                   @"page":@1,
                                  @"token":[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"product/imageLists"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject[kProductPictureModelData] isKindOfClass:[NSNull class]]) {
            NSArray *dataArray = responseObject[kProductPictureModelData];
            for (NSDictionary *dataDict in dataArray) {
                NSString *imageUrl = dataDict[kProductPictureModelDataImage][kProductPictureModelDataImageP];
                [imageUrlArray addObject:imageUrl];
            }
            
            completion(imageUrlArray);
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--- 加载错误：%@ ---", [error localizedFailureReason]);
    }];
}

@end
