//
//  CastURLGenerator.m
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import "CastURLGenerator.h"

@implementation CastURLGenerator
@synthesize entertainmentStorage;

- (nonnull instancetype)initCastGenerator {
    
    self = [super init];
    
    if(self) {
        self.entertainmentStorage = [NSMutableDictionary dictionary];
        [self constructDictionary];
    }
    return self;
}

- (void)constructDictionary { 
    [self.entertainmentStorage setObject: tvShowsEndPoint forKey: @(searchTvShows)];
    [self.entertainmentStorage setObject: movieEndpoint forKey: @(searchMovies)];
}

- (NSString * _Nonnull)generateURLFor:(NSInteger)movieOrShow withIdentifier:(NSInteger)identifier {
    
    NSString *getEndpoint = [self getEndpointForOption:movieOrShow];
    return [NSString stringWithFormat:@"%@%@/%ld/%@?api_key=%@", baseURL,getEndpoint,(long)identifier, creditsEndPoint,apiKey];
}

- (nonnull NSString *)getEndpointForOption:(NSInteger)option { 
    return [self.entertainmentStorage objectForKey:@(option)];
}



@end
