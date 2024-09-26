//
//  TvShowsViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewController.h"

@interface TvShowsViewController ()
@property (atomic , strong) TvShowsViewModel *viewModel;
-(void)displayError;
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


#pragma mark: - Private functions 
- (void)displayError {
    
}

#pragma mark: - Collection view Delegate and Data source

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.popularTvShows count];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TvShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: tvShowCellIdentifier forIndexPath:indexPath];
    
    TvShowsPopularModel *tvShow = self.viewModel.popularTvShows[indexPath.row];
    
    [self.viewModel loadImageForTvShows:tvShow completion:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        if (error) {
            
        }
        
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.moviePoster.image = image;
            });
        }
    }];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(175, 350);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 7;
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(16, 4, 0, 4);
}


@end
