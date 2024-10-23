//
//  RetrieveURLImages.m
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import "RetrieveURLImages.h"

@implementation RetrieveURLImages
@synthesize entertainmentStorage;

- (nonnull instancetype)initImagesURL {
    
    self = [super init];
    
    if(self) {
        self.entertainmentStorage = [NSMutableDictionary dictionary];
        [self constructDictionary];
    }
    
    return self;
}

- (void)constructDictionary {
    [self.entertainmentStorage setObject: tvShowsEndPoint forKey: @(searchTvShows)];
    [self.entertainmentStorage setObject: baseMovieImagesURL forKey: @(searchMovies)];
}

- (NSString * _Nonnull)generateURLFor:(NSInteger)movieOrShow withIdentifier:(NSInteger)identifier {
    
    NSString *endPoint = [self getEndpointForOption:movieOrShow];
    
    return movieOrShow == searchTvShows ?  [NSString stringWithFormat:@"%@%@/%ld/images?api_key=%@", baseURL, endPoint, identifier, apiKey] : [NSString stringWithFormat:@"%@/%ld/images?api_key=%@",endPoint, identifier,apiKey];
}

- (nonnull NSString *)getEndpointForOption:(NSInteger)option { 
    return [self.entertainmentStorage objectForKey:@(option)];
}


@end
