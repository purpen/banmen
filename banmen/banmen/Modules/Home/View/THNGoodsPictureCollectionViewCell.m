//
//  THNGoodsPictureCollectionViewCell.m
//  banmen
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 banmen. All rights reserved.
//

#import "THNGoodsPictureCollectionViewCell.h"
#import "Masonry.h"
#import "UIColor+Extension.h"
#import "OtherMacro.h"
#import "UIImageView+WebCache.h"
#import "THNwordCollectionViewCell.h"
#import "UIView+FSExtension.h"
#import "THNGoodsPictureModel.h"
#import "THNPictureCollectionViewCell.h"
#import "EZImageBrowser.h"
#import "EZImageBrowserCell.h"
#import "EZImageBrowserLoading.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "SVProgressHUD.h"

@interface THNGoodsPictureCollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, EZImageBrowserDelegate>
@property (nonatomic, strong) EZImageBrowser *browser;

@end

@implementation THNGoodsPictureCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self.contentView).mas_offset(0);
        }];
    }
    return self;
}

-(void)setModelAry:(NSArray *)modelAry{
    _modelAry = modelAry;
    [self.collectionView reloadData];
}

-(void)setSender_selected:(BOOL)sender_selected{
    _sender_selected = sender_selected;
    [self.collectionView reloadData];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if (self.sender_selected) {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.minimumInteritemSpacing = 2;
//            layout.minimumLineSpacing = 1;
        } else {
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
            layout.minimumInteritemSpacing = 1;
        }
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [_collectionView registerClass:[THNPictureCollectionViewCell class] forCellWithReuseIdentifier:@"THNPictureCollectionViewCell"];
    }
    return _collectionView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    THNGoodsPictureModel *model = self.modelAry[indexPath.row];
    if (self.sender_selected) {
        THNPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"THNPictureCollectionViewCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(cell.contentView).mas_offset(0);
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"goodsImagDefault"]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sender_selected) {
        return CGSizeMake(SCREEN_WIDTH, 51);
    } else {
        return CGSizeMake((SCREEN_WIDTH-3)/4, (SCREEN_WIDTH-3)/4);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.browser = [[EZImageBrowser alloc] init];
    [_browser setDelegate:self];
    [_browser showWithCurrentIndex:indexPath.row  completion:nil];
    [_browser.downBtn addTarget:self action:@selector(down:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelAry.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - EZImageBrowserDelegate
- (NSInteger)numberOfCellsInImageBrowser:(EZImageBrowser *)imageBrowser{
    return self.modelAry.count;
}

- (EZImageBrowserCell *)imageBrowser:(EZImageBrowser *)imageBrowser cellForRowAtIndex:(NSInteger )index{
    EZImageBrowserCell *cell = [imageBrowser dequeueReusableCell];
    if (!cell) {
        cell = [[EZImageBrowserCell alloc] init];
    }
    THNGoodsPictureModel *model = self.modelAry[index];
    cell.loadingView.hidden = YES ;
    [cell.imageView sd_setImageWithURL:[[NSURL alloc] initWithString:model.image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = (CGFloat)receivedSize / expectedSize ;
        [cell.loadingView showAnimateByPropress:progress];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.loadingView.hidden = YES ;
        //        cell.imageViewSize = image.size;//可以显示图片大小
    }];
    
    return cell;
}

-(void)down:(UIButton *)sender{
    NSRange range = [_browser.pageTextLabel.text rangeOfString:@" /"];
    NSString *subStr = [_browser.pageTextLabel.text substringToIndex:range.location];
    NSInteger num = [subStr integerValue]-1;
    THNGoodsPictureModel *model = self.modelAry[num];
    NSString* strUrl = model.image;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    UIImage *image = [cache imageFromDiskCacheForKey:key];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        [SVProgressHUD showSuccessWithStatus:@"图片保存至相册"];
    } else {
        [SVProgressHUD showInfoWithStatus:@"图片保存失败"];
    }
}

- (CGSize)imageBrowser:(EZImageBrowser *)imageBrowser  imageViewSizeForItemAtIndex:(NSInteger)index{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    return size;
}

- (void)imageBrowser:(EZImageBrowser *)imageBrowser didDisplayingCell:(EZImageBrowserCell *)cell atIndex:(NSInteger)index{
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [[self collectionView] scrollToRowAtIndexPath:scrollIndexPath
//                            atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    NSLog(@"didDisplayingCell index = %ld", (long)index);
}

//- (UIView *)imageBrowser:(EZImageBrowser *)imageBrowser fromViewForItemAtIndex:(NSInteger)index{
////    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
////    UITableViewCell *cell =   [self.collectionView cellForRowAtIndexPath:scrollIndexPath];
////    return cell;
//    re
//}


@end
