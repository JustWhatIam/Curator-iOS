//
//  CHTGirlOfTheDayBaseViewController.m
//  Curator
//
//  Created by Nelson Tai on 2014/2/8.
//  Copyright (c) 2014年 Nelson. All rights reserved.
//

#import "CHTGirlOfTheDayBaseViewController.h"
#import "CHTLoadMoreView.h"
#import <NHBalancedFlowLayout/NHBalancedFlowLayout.h>

static NSString *footerIdentifier = @"footerIdentifier";

@interface CHTGirlOfTheDayBaseViewController () <NHBalancedFlowLayoutDelegate>
@end

@implementation CHTGirlOfTheDayBaseViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NHBalancedFlowLayout *layout = (NHBalancedFlowLayout *)self.collectionViewLayout;
  CGFloat spacing;
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    spacing = 15;
  } else {
    spacing = 5;
  }
  layout.minimumLineSpacing = spacing;
  layout.minimumInteritemSpacing = spacing;
  layout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
  layout.headerReferenceSize = CGSizeZero;
  layout.footerReferenceSize = CGSizeMake(40, 40);

  [self.collectionView registerClass:[CHTLoadMoreView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:footerIdentifier];
  [self.collectionView registerClass:[CHTLoadMoreView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
}

#pragma mark - NHBalancedFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(NHBalancedFlowLayout *)collectionViewLayout preferredSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.item < 0 || indexPath.item >= self.beauties.count) {
    return CGSizeZero;
  }

  CHTBeauty *beauty = self.beauties[indexPath.item];
  return CGSizeMake(beauty.thumbnailWidth, beauty.thumbnailHeight);
}

#pragma mark - UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  CHTLoadMoreView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerIdentifier forIndexPath:indexPath];

  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    view.hidden = YES;
  } else {
    view.state = (self.canLoadMore) ? CHTLoadMoreStateLoading : CHTLoadMoreStateEnded;
  }

  return view;
}

@end
