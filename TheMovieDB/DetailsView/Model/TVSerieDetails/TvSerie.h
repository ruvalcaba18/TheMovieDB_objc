//
//  TvSerie.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>
#import "Creator.h"
#import "Genre.h"
#import "NetworkModel.h"
#import "Season.h"
#import "Episode.h"

NS_ASSUME_NONNULL_BEGIN


@interface TvSerie : NSObject

@property (nonatomic, assign) BOOL adult;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic, strong) NSArray<Creator *> *createdBy;
@property (nonatomic, strong) NSArray<NSNumber *> *episodeRunTime;
@property (nonatomic, strong) NSString *firstAirDate;
@property (nonatomic, strong) NSArray<Genre *> *genres;
@property (nonatomic, strong) NSString *homepage;
@property (nonatomic, assign) NSInteger seriesId;
@property (nonatomic, assign) BOOL inProduction;
@property (nonatomic, strong) NSArray<NSString *> *languages;
@property (nonatomic, strong) NSString *lastAirDate;
@property (nonatomic, strong) Episode *lastEpisodeToAir;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) Episode *nextEpisodeToAir;
@property (nonatomic, strong) NSArray<NetworkModel *> *networks;
@property (nonatomic, assign) NSInteger numberOfEpisodes;
@property (nonatomic, assign) NSInteger numberOfSeasons;
@property (nonatomic, strong) NSArray<NSString *> *originCountry;
@property (nonatomic, strong) NSString *originalLanguage;
@property (nonatomic, strong) NSString *originalName;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, assign) NSNumber* popularity;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSArray<Season *> *seasons;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *tagline;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSNumber* voteAverage;
@property (nonatomic, assign) NSInteger voteCount;

@end

NS_ASSUME_NONNULL_END
