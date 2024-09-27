//
//  Season.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Season : NSObject
@property (nonatomic, strong) NSString *airDate;
@property (nonatomic, assign) NSInteger episodeCount;
@property (nonatomic, assign) NSInteger seasonId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, assign) NSInteger seasonNumber;
@property (nonatomic, assign) NSNumber* voteAverage;
@end

NS_ASSUME_NONNULL_END
