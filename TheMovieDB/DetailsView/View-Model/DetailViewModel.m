//
//  DetailViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailViewModel.h"

@interface DetailViewModel()

@property (nonatomic,strong) NSCache *imageCache;

-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;
@end

@implementation DetailViewModel
@synthesize showDetails,imageCache;

- (nonnull instancetype)initDetailViewModel {
    
    self = [super init];
    if (self) {
        self.showDetails = [NSMutableArray array];
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier {
    
    NSString *url;
    
    switch (option) {
        case searchTvShows:
            url = [NSString stringWithFormat:@"%@%@/%@",baseURL,tvShowsEndPoint,identifier];
            break;
        case searchMovies:
            url = [NSString stringWithFormat:@"%@%@/%@",baseURL,movieEndpoint,identifier];
            break;
    }
    
   [ self performRequestWithURL:url completion:^(NSData *data, NSError *error) {
       
        if (error) {
            NSLog(@"Error %@",error);
        } else {
             
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


//- (nonnull NSString *)formatDate:(nonnull NSString *)dateToGiveFormat {
//    
//}

@end
