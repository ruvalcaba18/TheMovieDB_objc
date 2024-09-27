//
//  DetailShowViewController.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <UIKit/UIKit.h>
#import "TvShowsPopularModel.h"
#import "OptionToSearch.h"
#import "DetailViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailShowViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *showContainerDescriptionView;
@property (strong, nonatomic) IBOutlet UIView *castContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *showPosterImage;
@property (atomic, strong, nullable) TvShowsPopularModel *selectedShow;
@property (strong, nonatomic) IBOutlet UICollectionView *castCollectionView;
@property (atomic, assign) OptionToSearch optionSelected;
@property (strong, nonatomic) IBOutlet UIView *circlePopularityView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


@end

NS_ASSUME_NONNULL_END
