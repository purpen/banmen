//
//  UnitPriceViewController.m
//  banmen
//
//  Created by dong on 2017/6/29.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "UnitPriceViewController.h"
#import "UnitPriceTableViewCell.h"

@interface UnitPriceViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  */
@property (nonatomic, strong) UITableView *contenTableView;
@end

@implementation UnitPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contenTableView];
}

-(UITableView *)contenTableView{
    if (!_contenTableView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _contenTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 1-44-35) style:UITableViewStyleGrouped];
        _contenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contenTableView.showsVerticalScrollIndicator = NO;
        _contenTableView.backgroundColor = [UIColor colorWithHexString:@"#f8f8f8"];
        _contenTableView.delegate = self;
        _contenTableView.dataSource = self;
        _contenTableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        _contenTableView.rowHeight = 245;
        [_contenTableView registerClass:[UnitPriceTableViewCell class] forCellReuseIdentifier:@"UnitPriceTableViewCell"];
    }
    return _contenTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UnitPriceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UnitPriceTableViewCell"];
    return cell;
}

@end
