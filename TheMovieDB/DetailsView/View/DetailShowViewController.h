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
#import "RoundedCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailShowViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) IBOutlet UIView *descriptionContainerView;
@property (strong, nonatomic) IBOutlet UIView *castContainerView;
@property (strong, nonatomic) IBOutlet UIImageView *posterImageView;
@property (atomic, strong, nullable) TvShowsPopularModel *selectedShow;
@property (strong, nonatomic) IBOutlet UICollectionView *castCollectionView;
@property (atomic, assign) OptionToSearch selectedOption;
@property (strong, nonatomic) IBOutlet UIView *popularityCircleView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *creatorLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *popularityLabel;


@end

NS_ASSUME_NONNULL_END
