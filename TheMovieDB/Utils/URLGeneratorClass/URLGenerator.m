//
//  URLGenerator.m
//  TheMovieDB
//
//  Created by The Coding Kid on 14/10/2024.
//

#import "URLGenerator.h"

@implementation URLGenerator

+(NSString *)generateURLForFilter:(TopFilter)topFilter {
    
    switch (topFilter ) {
            
        case SearchPopularTvShows: {
         return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointPopular,apiKey];
            break;
        }
        case SearchTopRatedTvShows: {
            return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointTopRated,apiKey];
            break;
        }
        case SearchOnTvShows: {
          return  [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointOnTheAir,apiKey];
            break;
        }
        case SearchAiringTodayShows: {
            return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointAiringToday,apiKey];
            break;
        }
        case SearchNowPlayingMovies: {
           return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieNowPlayingEndpoint,apiKey];
            break;
        }
        case SearchPopularMovies: {
            return  [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostPopularEndpoint,apiKey];
            break;
        }
        case SearchTopRatedMovies: {
            return  [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostTopRatedEndpoint,apiKey];
            break;
        }
        case SearchUpcomingMovies: {
            return  [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieUpcomingEndpoint,apiKey];
            break;
        }
    }
}

+(NSString *)generateURLForOption:(OptionToSearch)option {
    
    switch (option) {
        case searchTvShows: {
            return [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointPopular,apiKey];
            break;
        }
        case searchMovies: {
            return  [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostPopularEndpoint,apiKey];
            break;
        }
        default:
            return @"";
    }
}

+(NSString *) generateURLForDetailOption:(OptionToSearch)option  withIdentifier :(NSString *)identifier {
    
    switch (option) {
        case searchTvShows:
            return [NSString stringWithFormat:@"%@%@/%@?api_key=%@",baseURL,tvShowsEndPoint,identifier,apiKey];
            break;
        case searchMovies:
            return  [NSString stringWithFormat:@"%@%@/%@?api_key=%@",baseURL,movieEndpoint,identifier,apiKey];
            break;
            
    }
}

+(NSString *) generateURLForCastOption:(OptionToSearch)option forIDShow:(NSInteger)showID {
    
    switch ( option ) {
            
        case searchTvShows:
            return [NSString stringWithFormat:@"%@%@/%ld/%@?api_key=%@", baseURL,tvShowsEndPoint,(long)showID, creditsEndPoint,apiKey];;
            break;
            
        case searchMovies:
            return  [NSString stringWithFormat:@"%@%@/%ld/%@?api_key=%@", baseURL,movieEndpoint,(long)showID, creditsEndPoint,apiKey];
            break;
            
    }

    
}

+(NSString *) generateURLToRetrieveImagesForTvShowsWithIdentifier:(NSInteger)identifier{
    return [NSString stringWithFormat:@"%@%@/%ld/images?api_key=%@", baseURL, tvShowsEndPoint, identifier, apiKey];
}

+(NSString *) generateURLToRetrieveImagesForMoviesWithIdentifier:(NSInteger)identifier {
    return [NSString stringWithFormat:@"%@/%ld/images?api_key=%@",baseMovieImagesURL, identifier,apiKey];
}
@end
