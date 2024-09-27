//
//  TvShowsModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "TVShowsPopularModel.h"
#import "DatesModel/DatesModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TvShowsModel : NSObject

-(instancetype)initModelWithPageNumber:(NSNumber *) pageNumber
                            totalPages:(NSNumber *)pages
                          totalResults:(NSNumber *)totalResults
                             andResult:(NSArray *)results;

- (NSMutableArray *)getResults;

@end

NS_ASSUME_NONNULL_END
