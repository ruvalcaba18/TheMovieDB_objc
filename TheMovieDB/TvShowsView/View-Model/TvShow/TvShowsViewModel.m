//  TvShowsViewModel.m
//  TheMovieDB
//  Created by The Coding Kid on 25/09/2024.

#import "TvShowsViewModel.h"

#pragma mark: - Private methods and variables
@interface TvShowsViewModel()

@property (nonatomic,strong) NSCache *imageCache;
@end

#pragma mark: - Implementation of the class
@implementation TvShowsViewModel
@synthesize popularTvShows,imageCache;

-(instancetype)initViewModel {
    
    self = [super init];
    
    if(self) {
        
        self.popularTvShows = [NSMutableArray array];
        self.imageCache = [[NSCache alloc] init];
        
    }
    return self;
}

-(void)fetchShowsWithSearchOption:(OptionToSearch)option {
    
    NSString *url;
    
    switch (option) {
        case searchTvShows: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointPopular,apiKey];
            break;
        }
        case searchMovies: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostPopularEndpoint,apiKey];
            break;
        }
        default:
            return;
    }
    
    [NetworkManager performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error %@",error.localizedDescription);
        } else {
            self.popularTvShows = [NSData parseTvShowData:data];
        }
    }];
}


- (void)applyFilter:(TopFilter)filterOption {
    
    NSString *url;
    
    switch (filterOption ) {
            
        case SearchPopularTvShows: {
         url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointPopular,apiKey];
            break;
        }
        case SearchTopRatedTvShows: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointTopRated,apiKey];
            break;
        }
        case SearchOnTvShows: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointOnTheAir,apiKey];
            break;
        }
        case SearchAiringTodayShows: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,tvShowsEndPoint,tvShowsEndPointAiringToday,apiKey];
            break;
        }
        case SearchNowPlayingMovies: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieNowPlayingEndpoint,apiKey];
            break;
        }
        case SearchPopularMovies: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostPopularEndpoint,apiKey];
            break;
        }
        case SearchTopRatedMovies: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieMostTopRatedEndpoint,apiKey];
            break;
        }
        case SearchUpcomingMovies: {
            url = [NSString stringWithFormat:@"%@%@%@?%@&api_key=%@",baseURL,discoverEndpoint,movieEndpoint,movieUpcomingEndpoint,apiKey];
            break;
        }
    }
   
    [NetworkManager performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            
        } else {
            [self.popularTvShows removeAllObjects];
            self.popularTvShows = [NSData parseTvShowData:data];
        }
    }];
    
}

-(void) loadImageForShow:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion {
    

    UIImage *imageCache = [self.imageCache objectForKey:tvShow.poster_path];
    
    if (imageCache) {
        completion(imageCache,nil);
        return;
    }
    
    NSString *imageMetaDataUrl;
    
    if (tvShow.original_name) {
        imageMetaDataUrl = [NSString stringWithFormat:@"%@%@/%@/images?api_key=%@",baseURL, tvShowsEndPoint, [tvShow.identifier stringValue],apiKey];
    } else {
        imageMetaDataUrl = [NSString stringWithFormat:@"%@/%@/images?api_key=%@",baseMovieImagesURL, [tvShow.identifier stringValue],apiKey];
    }
    
    
    [NetworkManager performRequestWithURL: imageMetaDataUrl completion:^(NSData *data, NSError *error) {
        
        if(error) {
            NSLog(@"Error to consult endpoint metadata : %@",error.localizedDescription);
            completion(nil,error);
            return ;
        }
        
        PostersObject *posterInfo = [NSData parsePosterData:data];
        
        if (posterInfo.file_path) {
            
            NSString *imageFullURL = [NSString stringWithFormat:@"%@%@",baseImagesURL,posterInfo.file_path];
            
            [NetworkManager performRequestWithURL: imageFullURL completion:^(NSData *data, NSError *error) {

                
                if(error) {
                    
                    NSLog(@"Error to download image: %@",error.localizedDescription);
                    completion(nil,error);
                    return;
                }
                
                UIImage *downloadedImage = [UIImage imageWithData:data];
                
                if(downloadedImage) {
                    [self.imageCache setObject:downloadedImage forKey:tvShow.poster_path];
                    completion(downloadedImage,nil);
                    
                } else {
                    NSError *imageError = [NSError errorWithDomain:@"ImageDownloadError"
                                                              code:500
                                                          userInfo:@{@"Error description" :@"we can not download the image"}];
                    completion(nil,imageError);
                }
                
            }];
        }
    }];
}


@end
