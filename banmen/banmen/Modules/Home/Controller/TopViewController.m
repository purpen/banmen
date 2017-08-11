//
//  TopViewController.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "TopViewController.h"
#import "RTagCloudView.h"
#import "AFNetworking.h"
#import "UIColor+Extension.h"

@interface TopViewController () <RTagCloudViewDelegate,RTagCloudViewDatasource>

@property (nonatomic, strong) NSArray *dataAry;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RTagCloudView *tagCloud = [[RTagCloudView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    tagCloud.backgroundColor = [UIColor clearColor];
    tagCloud.center = CGPointMake(self.view.bounds.size.width /2, self.view.bounds.size.height / 2-100/SCREEN_HEIGHT*667.0);
    tagCloud.dataSource = self;
    tagCloud.delegate = self;
    [self.view addSubview:tagCloud];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    params[@"token"] = [defaults objectForKey:@"token"];
    [manager GET:[kDomainBaseUrl stringByAppendingString:@"survey/topFlag"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataAry = responseObject[@"data"];
        [tagCloud reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfTags:(RTagCloudView *)tagCloud
{
    return self.dataAry.count;
}

#pragma mark - RTagCloudViewDatasource

- (NSString*)RTagCloudView:(RTagCloudView *)tagCloud
            tagNameOfIndex:(NSInteger)index
{
    return (NSString *)self.dataAry[index];
}

- (UIFont*)RTagCloudView:(RTagCloudView *)tagCloud
          tagFontOfIndex:(NSInteger)index
{
    UIFont *fonts[] = {
        [UIFont systemFontOfSize:12.f],
        [UIFont systemFontOfSize:14.f],
        [UIFont systemFontOfSize:16.f],
        [UIFont systemFontOfSize:18.f],
        [UIFont systemFontOfSize:20.f],
        [UIFont systemFontOfSize:22.f],
        [UIFont systemFontOfSize:24.f]
    };
    return fonts[index%7];
}

- (UIColor*)RTagCloudView:(RTagCloudView *)tagCloud tagColorOfIndex:(NSInteger)index
{
    UIColor *colors[] = {
        [UIColor colorWithHexString:@"#FFCC00"],
        [UIColor colorWithHexString:@"#F67700"],
        [UIColor colorWithHexString:@"#FB3731"],
        [UIColor colorWithHexString:@"#7B322B"],
        [UIColor colorWithHexString:@"#27262F"],
        [UIColor colorWithHexString:@"#5B22A5"],
        [UIColor colorWithHexString:@"#A652BB"],
        [UIColor colorWithHexString:@"#FF57B7"],
        [UIColor colorWithHexString:@"#0090FF"],
        [UIColor colorWithHexString:@"#50BFEC"],
        [UIColor colorWithHexString:@"#00CBCB"],
        [UIColor colorWithHexString:@"#00DAAF"],
        [UIColor colorWithHexString:@"#00B256"],
        [UIColor colorWithHexString:@"#00C09A"],
    };
    return colors[index%7];
}

#pragma mark - RTagCloudViewDelegate

- (void)RTagCloudView:(RTagCloudView*)tagCloud didTapOnTagOfIndex:(NSInteger)index
{
//    UILabel* resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 30.f)];
//    resultLabel.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.8f];
//    resultLabel.textAlignment = NSTextAlignmentCenter;
//    resultLabel.textColor = [UIColor whiteColor];
//    resultLabel.center = CGPointMake(self.view.bounds.size.width /2, 50.f);
//    [self.view addSubview:resultLabel];
//
//    resultLabel.text = (NSString *)self.dataAry[index];
//    [resultLabel performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.0f];
}


@end
