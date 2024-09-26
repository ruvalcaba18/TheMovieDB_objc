//
//  TvShowsPopularModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsPopularModel : NSObject
@property (atomic, assign) BOOL adult;
@property (atomic, strong) NSString *backdrop_path;
@property (atomic, strong) NSArray* genre_ids;
@property (atomic, strong) NSNumber *identifier;
@property (atomic, strong) NSString *origin_contry;
@property (atomic, strong) NSString *original_language;
@property (atomic, strong) NSString *original_name;
@property (atomic, strong) NSString *overview;
@property (atomic, assign) NSNumber *popularity;
@property (atomic, strong) NSString *poster_path;
@property (atomic, strong) NSString *first_air_date;
@property (atomic, strong) NSString *name;
@property (atomic, strong) NSNumber *vote_average;
@property (atomic, strong) NSNumber *vote_count;
@end

NS_ASSUME_NONNULL_END
