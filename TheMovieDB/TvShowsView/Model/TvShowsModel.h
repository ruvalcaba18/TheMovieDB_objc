//
//  TvShowsModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "TVShowsPopularModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TvShowsModel : NSObject
@property (atomic, strong) NSNumber *pageNumber;
@property (atomic, strong) NSArray<TvShowsPopularModel *> *result;
@property (atomic, strong) NSNumber *total_pages;
@property (atomic, strong) NSNumber *total_results;
@end

NS_ASSUME_NONNULL_END
