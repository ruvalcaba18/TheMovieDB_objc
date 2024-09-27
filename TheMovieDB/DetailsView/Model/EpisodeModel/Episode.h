//
//  Episode.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Episode : NSObject
@property (nonatomic, assign) NSInteger episodeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, assign) NSNumber* voteAverage;
@property (nonatomic, assign) NSInteger voteCount;
@property (nonatomic, strong) NSString *airDate;
@property (nonatomic, assign) NSInteger episodeNumber;
@property (nonatomic, strong) NSString *episodeType;
@property (nonatomic, strong) NSString *productionCode;
@property (nonatomic, strong) NSNumber *runtime;
@property (nonatomic, assign) NSInteger seasonNumber;
@property (nonatomic, assign) NSInteger showId;
@property (nonatomic, strong) NSString *stillPath;

@end

NS_ASSUME_NONNULL_END
