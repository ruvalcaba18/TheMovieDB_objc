//
//  SelectedEntertainmentURLGenerator.m
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import "SelectedEntertainmentURLGenerator.h"

@implementation SelectedEntertainmentURLGenerator
@synthesize entertainmentStorage;

- (nonnull instancetype)initSelectedEntertainment {
    
    self = [super init];
    
    if(self) {
        self.entertainmentStorage = [NSMutableDictionary dictionary];
        [self constructDictionary];
    }
    
    return self;
}

-(void)constructDictionary {
    
    [self.entertainmentStorage setObject: tvShowsEndPoint forKey: @(searchTvShows)];
    [self.entertainmentStorage setObject: movieEndpoint forKey: @(searchMovies)];
   
}

- (NSString * _Nonnull)generateURLFor:(NSInteger)movieOrShow withIdentifier:(NSInteger)identifier {
    
    NSString *endPoint = [self getEndpointForOption:movieOrShow];
    NSString *popularEntertainment = movieOrShow == searchTvShows ?  tvShowsEndPointPopular : movieMostPopularEndpoint ;
    return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,endPoint,popularEntertainment,apiKey];
}

- (nonnull NSString *)getEndpointForOption:(NSInteger)option { 
   return  [self.entertainmentStorage objectForKey:@(option)];
}

@end
