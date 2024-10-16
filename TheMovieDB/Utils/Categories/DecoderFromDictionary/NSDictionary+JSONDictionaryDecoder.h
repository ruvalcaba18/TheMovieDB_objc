//
//  NSDictionary+JSONDictionaryDecoder.h
//  TheMovieDB
//
//  Created by The Coding Kid on 15/10/2024.
//

#import <Foundation/Foundation.h>
#import "Episode.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JSONDictionaryDecoder)
+ (Episode *)decodeEpisodeFromJSON:(NSDictionary *)jsonEpisode ;
@end

NS_ASSUME_NONNULL_END
