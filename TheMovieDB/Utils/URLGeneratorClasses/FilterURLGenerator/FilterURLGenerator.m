//
//  URLGenerator.m
//  TheMovieDB
//
//  Created by The Coding Kid on 14/10/2024.
//

#import "FilterURLGenerator.h"

@implementation FilterURLGenerator
@synthesize entertainmentStorage;

-(instancetype)initFilterURL {
    
    self = [super init];
    
    if(self) {
        self.entertainmentStorage = [NSMutableDictionary dictionary];
        [self constructDictionary];
    }
    return self;
}

-(void)constructDictionary {
    
    [self.entertainmentStorage setObject: tvShowsEndPointPopular forKey: @(SearchPopularTvShows)];
    [self.entertainmentStorage setObject: tvShowsEndPointTopRated forKey: @(SearchTopRatedTvShows)];
    [self.entertainmentStorage setObject: tvShowsEndPointOnTheAir forKey: @(SearchOnTvShows)];
    [self.entertainmentStorage setObject: tvShowsEndPointAiringToday forKey: @(SearchAiringTodayShows)];
    [self.entertainmentStorage setObject: movieNowPlayingEndpoint forKey: @(SearchNowPlayingMovies)];
    [self.entertainmentStorage setObject: movieMostPopularEndpoint  forKey: @(SearchPopularMovies)];
    [self.entertainmentStorage setObject: movieUpcomingEndpoint  forKey: @(SearchUpcomingMovies)];
    [self.entertainmentStorage setObject: movieMostTopRatedEndpoint  forKey: @(SearchTopRatedMovies)];
}

-(NSString* _Nonnull)generateURLFor:(NSInteger)movieOrShow withIdentifier:(NSInteger )identifier {
    
    NSString *endPoint = [self getEndpointForOption:movieOrShow];
    NSString *selectedEntertainment = movieOrShow < 5 ? tvShowsEndPoint : movieEndpoint;
    return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,selectedEntertainment,endPoint,apiKey];

}

-(NSString *)getEndpointForOption:(NSInteger)option {
    
    return [self.entertainmentStorage objectForKey:@(option)];
}


@end
