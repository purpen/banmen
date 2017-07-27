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

@end

@implementation THNPosterListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"海报模版";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self thn_setControllerViewUI];
}

- (void)thn_setControllerViewUI {
    [self.view addSubview:self.segmentedPager];
}

#pragma mark - 加载海报模版视图
- (UICollectionView *)posterCollectionView {
    if (!_posterCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 3) / 2, ((SCREEN_WIDTH - 3) / 2) * 1.77);
        flowLayout.minimumLineSpacing = 3;
        flowLayout.minimumInteritemSpacing = 3;
        
        _posterCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _posterCollectionView.delegate = self;
        _posterCollectionView.dataSource = self;
        _posterCollectionView.backgroundColor = [UIColor colorWithHexString:kColorWhite];
        _posterCollectionView.showsVerticalScrollIndicator = NO;
        [_posterCollectionView registerClass:[THNPosterListCollectionViewCell class] forCellWithReuseIdentifier:PosterListCollectionViewCellId];
    }
    return _posterCollectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THNPosterListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PosterListCollectionViewCellId
                                                                                      forIndexPath:indexPath];
    cell.posterImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"poster_style_%zi", indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self thn_openEditPosterImageController:[UIImage imageNamed:[NSString stringWithFormat:@"poster_style_%zi", indexPath.row]] index:indexPath.row];
}

#pragma mark - 跳转编辑海报
- (void)thn_openEditPosterImageController:(UIImage *)image index:(NSInteger)index {
    THNEditPosterViewController *editPosterVC = [[THNEditPosterViewController alloc] init];
    [editPosterVC thn_setPreviewPosterImage:image styleTag:index];
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
    return [@[@"活动", @"邀请函"] objectAtIndex:index];
}

- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.posterCollectionView;
    }
    return [UIView new];
}

- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@", title);
}



@end
