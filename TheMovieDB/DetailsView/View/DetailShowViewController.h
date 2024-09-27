//
//  DetailShowViewController.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <UIKit/UIKit.h>
#import "TvShowsPopularModel.h"
#import "OptionToSearch.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailShowViewController : UIViewController
@property (atomic, strong, nullable) TvShowsPopularModel *selectedShow;
@property (atomic, assign) OptionToSearch optionSelected;
@end

NS_ASSUME_NONNULL_END
