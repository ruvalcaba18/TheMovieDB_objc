//
//  TvShowsViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewController.h"

@interface TvShowsViewController ()
@property (atomic , strong) TvShowsViewModel *viewModel;
@end

@implementation TvShowsViewController
@synthesize tvSegmentControl,tvShowsCollectionView,viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tvShowsCollectionView.delegate = self;
    self.tvShowsCollectionView.dataSource = self;
    [self.tvShowsCollectionView registerNib:[UINib nibWithNibName: @"TvShowCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:tvShowCellIdentifier];
    
    self.viewModel = [[TvShowsViewModel alloc] initTvShowsViewModel];
    [self.viewModel starFetchOption:searchTvShows];
    
}

#pragma mark: - Collection view Delegate and Data source

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: tvShowCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(175, 350);
}


@end
