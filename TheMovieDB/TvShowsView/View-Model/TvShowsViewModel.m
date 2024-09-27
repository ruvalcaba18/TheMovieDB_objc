//
//  TvShowsViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewModel.h"

#pragma mark: - Private methods and variables
@interface TvShowsViewModel()

@property (nonatomic,strong) NSCache *imageCache;

-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;
- (NSMutableArray *)parseTvShowData:(NSData *)data;
- (PostersObject *)parsePosterData:(NSData *)data;
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
    
    [self performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error %@",error);
        } else {
            self.popularTvShows = [self parseTvShowData:data];
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
   
    [self performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            
        } else {
            [self.popularTvShows removeAllObjects];
            self.popularTvShows = [self parseTvShowData:data];
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
    
    
    [self performRequestWithURL: imageMetaDataUrl completion:^(NSData *data, NSError *error) {
        
        if(error) {
            NSLog(@"Error to consult endpoint metadata : %@",error);
            completion(nil,error);
            return ;
        }
        
        PostersObject *posterInfo = [self parsePosterData:data];
        
        if (posterInfo.file_path) {
            
            NSString *imageFullURL = [NSString stringWithFormat:@"%@%@",baseImagesURL,posterInfo.file_path];
            
            [self performRequestWithURL: imageFullURL completion:^(NSData *data, NSError *error) {

                
                if(error) {
                    
                    NSLog(@"Error to download image: %@",error);
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

-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
   
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                                                   NSURLResponse * _Nullable response,
                                                                                                                   NSError * _Nullable error) {
        if (error) {
            completion(nil,error);
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            
            switch (httpResponse.statusCode) {
                case 200:
                    completion(data,nil);
                    break;
                    
                default:
                    break;
            }
           
        }
    }];
    [dataTask resume];
}


#pragma mark: - Decoders
-(NSMutableArray *)parseTvShowData:(NSData *)data {
    
    NSError *jsonError;
    NSDictionary *jsonInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"JSON Error: %@",jsonError);
        return nil;
    }
    
    TvShowsModel *tvShowModel = [[TvShowsModel alloc] initModelWithPageNumber: jsonInformation[@"page"]
                                                                   totalPages: jsonInformation[@"total_pages"]
                                                                 totalResults: jsonInformation[@"total_Results"]
                                                                    andResult: jsonInformation[@"results"]];
    return [tvShowModel getResults];
}




-(PostersObject *)parsePosterData:(NSData *)posterData {
    
    NSError *jsonError;
    NSDictionary *dataDicc = [NSJSONSerialization JSONObjectWithData:posterData options:0 error:&jsonError];
    
    if (jsonError) {
        NSLog(@"Error to decode the json : %@",jsonError);
        return nil;
    }
    
    NSArray *postersArray = dataDicc[@"posters"];
    
    if(postersArray.count > 0 ) {
        
        NSDictionary *firstPoster = postersArray.firstObject;
        PostersObject *posterInfo = [[PostersObject alloc] init];
        posterInfo.file_path = firstPoster[@"file_path"];
        return posterInfo;
        
    }
    return nil;
}

#pragma mark: - functions that transform variables
-(NSString *)formatDate:(NSString *)dateToGiveFormatt {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyy-MM-dd"];
    
    NSDate *date = [inputFormatter dateFromString:dateToGiveFormatt];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *formattedDate = [outputFormatter stringFromDate:date];
    return formattedDate;
}
@end
