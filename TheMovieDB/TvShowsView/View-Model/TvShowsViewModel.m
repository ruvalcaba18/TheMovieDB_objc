//
//  TvShowsViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "TvShowsViewModel.h"


@interface TvShowsViewModel()
@property (nonatomic,strong) NSCache *imageCache;
-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;
@end

@implementation TvShowsViewModel
@synthesize popularTvShows,imageCache;

-(instancetype)initTvShowsViewModel {
    self = [super init];
    
    if(self) {
        self.popularTvShows = [NSMutableArray array];
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

-(void)starFetchOption:(OptionToSearch)option {
    
    NSMutableURLRequest *request;
    
    switch (option) {
        case searchTvShows: {
            
            NSString *halfUrl= [[baseURL stringByAppendingString:discoverEndpoint]
                                stringByAppendingString:tvShowsEndPoint];
            
            NSString *fullURLToDiscoverTvShows = [[[halfUrl stringByAppendingString:@"?language=en-US&page=1&sort_by=popularity.desc"]stringByAppendingString:@"&api_key="] stringByAppendingString:apiKey];
            
            
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURLToDiscoverTvShows]
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:10.0];
            
            [request setHTTPMethod:@"GET"];
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error) {
                
                if (error) {
                    NSLog(@"%@", error);
                } else {
                    
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    
                    switch (httpResponse.statusCode) {
                        case 200:
                            self.popularTvShows = [self decodeInformationFromData:data];
                        default:
                            return;
                    }
                    
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

-(NSMutableArray *)decodeInformationFromData:(NSData *)dataFromAPI {
    
    NSError *jsonError;
    NSDictionary *jsonInformation = [NSJSONSerialization JSONObjectWithData:dataFromAPI options:0 error:&jsonError];
    
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


-(void) loadImageForTvShows:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion {
    
    UIImage *imageCache = [self.imageCache objectForKey:tvShow.poster_path];
    
    if (imageCache) {
        completion(imageCache,nil);
        return;
    }
    
    NSString *imageMetaDataUrl = [NSString stringWithFormat:@"%@%@/%@/images?api_key=%@",baseURL, tvShowsEndPoint, [tvShow.identifier stringValue],apiKey];
    
    [self performRequestWithURL: imageMetaDataUrl completion:^(NSData *data, NSError *error) {
        
        if(error) {
            NSLog(@"Error to consult endpoint metadata : %@",error);
            completion(nil,error);
            return ;
        }
        PostersObject *posterInfo = [self decodePosterInformationFromData:data];
        
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

-(PostersObject *)decodePosterInformationFromData:(NSData *)posterData {
    
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


-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                                                   NSURLResponse * _Nullable response,
                                                                                                                   NSError * _Nullable error) {
        if (error) {
            completion(nil,error);
        } else {
            completion(data,nil);
        }
    }];
    [dataTask resume];
}
@end
