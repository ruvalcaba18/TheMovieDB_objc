//
//  TvShowsViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewModel.h"

@interface TvShowsViewModel()

@end

@implementation TvShowsViewModel

-(instancetype)initTvShowsViewModel {
    self = [super init];
    
    if(self) {
        
    }
    return self;
}

-(void)starFetchOption:(OptionToSearch)option {
    
    NSMutableURLRequest *request;

    switch (option) {
        case searchTvShows: {
            // Opcion si quieres utilizar berear token , es un grado de seguridad pero con api key se puede hacer el request
            //            NSDictionary *headers = @{ @"accept": @"application/json",
            //                                       @"Authorization": @"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiNjRkN2YzZWFkMzRiZmMyZDlhZGUyZWI0MGQ4MWUzNyIsIm5iZiI6MTcyNzIyMDY2Ni4wNTQ0MzEsInN1YiI6IjVmYmYyZDUyYTNkMDI3MDA0MGJkNjcyNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.QCLsyGNZj2ijzF5cvKXtwbTakPamxW238fPMvPClWuI" };
            //            [request setAllHTTPHeaderFields:headers];

            NSString *halfUrl= [[baseURL stringByAppendingString:discoverEndpoint]
                                stringByAppendingString:tvShowsEndPoint];
            
            NSString *fullURLToDiscoverTvShows = [[[halfUrl stringByAppendingString:@"?language=en-US&page=1&sort_by=popularity.desc"]stringByAppendingString:@"&api_key="] stringByAppendingString:apiKey];
            

            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURLToDiscoverTvShows]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:10.0];
            
            [request setHTTPMethod:@"GET"];

            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if (error) {
                                                                NSLog(@"%@", error);
                                                            } else {
                                                                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                                NSLog(@" response %@", httpResponse);
                                                            }
                                                        }];
            [dataTask resume];
        }
        case searchMovies: {
            
        }
        default:
            return;
    }
}

@end
