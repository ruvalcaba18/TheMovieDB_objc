//
//  TvShowsViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "TvShowsModel.h"
#import "TvShowsPopularModel.h"
#import "OptionToSearch.h"
NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewModel : NSObject
-(instancetype)initTvShowsViewModel;
-(void)starFetchOption:(OptionToSearch)option;
@end

NS_ASSUME_NONNULL_END
