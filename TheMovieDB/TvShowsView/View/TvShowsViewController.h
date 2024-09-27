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
#import "SelectOptionView.h"
#import "DetailShowViewController.h"
#import "TopFilterOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UISegmentedControl *tvSegmentControl;
@property (strong, nonatomic) IBOutlet UICollectionView *tvShowsCollectionView;
@property (strong, nonatomic) IBOutlet UIView *optionContainer;
@property (strong, nonatomic) IBOutlet UIStackView *stackSegmenContainer;

@end

NS_ASSUME_NONNULL_END
