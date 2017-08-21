//
//  THNPosterListViewController.m
//  banmen
//
//  Created by FLYang on 2017/7/24.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNPosterListViewController.h"
#import "MXSegmentedPager.h"
#import "UIColor+Extension.h"
#import "MainMacro.h"

#import "THNPosterListCollectionViewCell.h"
#import "THNEditPosterViewController.h"
#import "THNImageToolNavigationController.h"

static NSString *const PosterListCollectionViewCellId = @"THNPosterListCollectionViewCell";

@interface THNPosterListViewController () <MXSegmentedPagerDelegate, MXSegmentedPagerDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) MXSegmentedPager *segmentedPager;
@property (nonatomic, strong) UICollectionView *posterCollectionView;
@property (nonatomic, strong) NSMutableArray *collectionArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation THNPosterListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"海报模版";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageArray = [NSMutableArray arrayWithArray:@[@[@"poster_style_1",
                                                         @"poster_style_2",
                                                         @"poster_style_3",
                                                         @"poster_style_4",
                                                         @"poster_style_5",
                                                         @"poster_style_6",
                                                         @"poster_style_7",
                                                         @"poster_style_8",
                                                         @"poster_style_9"]
                                                       ,
                                                       @[@"invitation_style_0",
                                                         @"invitation_style_1",
                                                         @"invitation_style_2",
                                                         @"invitation_style_3",
                                                         @"invitation_style_4"]]];
    self.titleArray = [NSMutableArray arrayWithArray:@[@"活动", @"邀请函"]];
    
    [self thn_setControllerViewUI];
}

- (void)thn_setControllerViewUI {
    if (self.titleArray.count == 0 ) {
        return;
    }
    
    [self thn_creatPosterCollectionViewWithTitle:self.titleArray];
    
    [self.view addSubview:self.segmentedPager];
}

#pragma mark - 加载海报模版视图
- (void)thn_creatPosterCollectionViewWithTitle:(NSArray *)titleArray {
    for (NSInteger index = 0; index < titleArray.count; ++ index) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 3) / 2, ((SCREEN_WIDTH - 3) / 2) * 1.77);
        flowLayout.minimumLineSpacing = 3;
        flowLayout.minimumInteritemSpacing = 3;
        
        UICollectionView *posterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        posterCollectionView.delegate = self;
        posterCollectionView.dataSource = self;
        posterCollectionView.backgroundColor = [UIColor colorWithHexString:kColorWhite];
        posterCollectionView.showsVerticalScrollIndicator = NO;
        [posterCollectionView registerClass:[THNPosterListCollectionViewCell class] forCellWithReuseIdentifier:PosterListCollectionViewCellId];
        
        [self.collectionArray addObject:posterCollectionView];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger index = [self.collectionArray indexOfObject:collectionView];
    return [(NSArray *)self.imageArray[index] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.collectionArray indexOfObject:collectionView];
    
    THNPosterListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PosterListCollectionViewCellId
                                                                                      forIndexPath:indexPath];
    cell.posterImageView.image = [UIImage imageNamed:self.imageArray[index][indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self.collectionArray indexOfObject:collectionView];
    [self thn_openEditPosterImageController:self.imageArray[index][indexPath.row]];
}

#pragma mark - 跳转编辑海报
- (void)thn_openEditPosterImageController:(NSString *)image {
    THNEditPosterViewController *editPosterVC = [[THNEditPosterViewController alloc] init];
    [editPosterVC thn_setPreviewPosterImage:[UIImage imageNamed:image] style:image];
    THNImageToolNavigationController *imageToolNavController = [[THNImageToolNavigationController alloc] initWithRootViewController:editPosterVC];
    [self presentViewController:imageToolNavController animated:YES completion:nil];
    
}

#pragma mark - 分页控制视图
- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        _segmentedPager = [[MXSegmentedPager alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _segmentedPager.delegate = self;
        _segmentedPager.dataSource = self;
        _segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
        _segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:kColorMenuText],\
                                                                 NSFontAttributeName: [UIFont systemFontOfSize:14]};
        _segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithHexString:kColorYellow],\
                                                                         NSFontAttributeName: [UIFont systemFontOfSize:14]};
    }
    return _segmentedPager;
}

- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 2;
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return self.titleArray[index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return self.collectionArray[index];
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@", title);
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithIndex:(NSInteger)index {
    
}

#pragma mark - Array
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)collectionArray {
    if (!_collectionArray) {
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}

@end
