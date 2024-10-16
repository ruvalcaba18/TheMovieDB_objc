//
//  NSDictionary+JSONDictionaryDecoder.m
//  TheMovieDB
//
//  Created by The Coding Kid on 15/10/2024.
//

#import "NSDictionary+JSONDictionaryDecoder.h"

@implementation NSDictionary (JSONDictionaryDecoder)

+ (Episode *)decodeEpisodeFromJSON:(NSDictionary *)jsonEpisode {
    
    if ( ![jsonEpisode isKindOfClass:[NSDictionary class]] || jsonEpisode.count <= 0 ){
        return nil;
    }
    
    Episode *episode = [[Episode alloc] init];
    
    episode.episodeId = [jsonEpisode[@"id"] integerValue];
    episode.name = jsonEpisode[@"name"];
    episode.airDate = jsonEpisode[@"air_date"];
    episode.episodeNumber = [jsonEpisode[@"episode_number"] integerValue];
    episode.seasonNumber = [jsonEpisode[@"season_number"] integerValue];
    episode.overview = jsonEpisode[@"overview"];
    
    return episode;
}
@end
