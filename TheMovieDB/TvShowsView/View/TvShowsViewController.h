//
//  TvShowsViewController.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "TvShowCollectionViewCell.h"
#import "OptionToSearch.h"
#import "TvShowsViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UISegmentedControl *tvSegmentControl;
@property (strong, nonatomic) IBOutlet UICollectionView *tvShowsCollectionView;

@end

NS_ASSUME_NONNULL_END
