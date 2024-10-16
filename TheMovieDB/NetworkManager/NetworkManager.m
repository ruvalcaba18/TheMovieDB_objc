//
//  NetworkManager.m
//  TheMovieDB
//
//  Created by The Coding Kid on 09/10/2024.
//

#import "NetworkManager.h"
@interface NetworkManager()
@property (nonatomic,strong) NSCache *imageCache;
@end


@implementation NetworkManager
@synthesize imageCache;

+ (instancetype)sharedManager {
    static NetworkManager *sharedInstance = nil;
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    return self;
}


- (void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion {
    
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

- (void)loadImageForShow:(TvShowsPopularModel *)show completion:(void (^)(UIImage *image, NSError *error))completion {
    
    NSString *originalName;
    NSString *imageMetaDataUrl;
    
    if (show.name) {
        originalName = show.original_name;
        imageMetaDataUrl = [URLGenerator generateURLToRetrieveImagesForTvShowsWithIdentifier: (long)[show.identifier integerValue] ];
    } else if (show.title) {        originalName = show.original_title;
        imageMetaDataUrl =  [URLGenerator generateURLToRetrieveImagesForMoviesWithIdentifier: (long)[show.identifier integerValue] ];
    }
    
    UIImage *imageCache = [self.imageCache objectForKey: show.poster_path];
    
    if (imageCache) {
        completion(imageCache, nil);
        return;
    }
    
    
    
    [NetworkManager.sharedManager performRequestWithURL:imageMetaDataUrl completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error to consult endpoint metadata: %@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        PostersObject *posterInfo = [NSData parsePosterData: data];
        
        if (posterInfo.file_path) {
            NSString *imageFullURL = [NSString stringWithFormat:@"%@%@", baseImagesURL, posterInfo.file_path];
            
            [NetworkManager.sharedManager performRequestWithURL:imageFullURL completion:^(NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Error to download image: %@", error.localizedDescription);
                    completion(nil, error);
                    return;
                }
                
                UIImage *downloadedImage = [UIImage imageWithData:data];
                
                if (downloadedImage) {
                    [self.imageCache setObject:downloadedImage forKey: show.poster_path];
                    completion(downloadedImage, nil);
                } else {
                    NSError *imageError = [NSError errorWithDomain:@"ImageDownloadError"
                                                              code:500
                                                          userInfo:@{@"Error description": @"we cannot download the image"}];
                    completion(nil, imageError);
                }
            }];
        } else {
            NSError *noImageError = [NSError errorWithDomain:@"NoImageError"
                                                        code:404
                                                    userInfo:@{@"Error description": @"No image found"}];
            completion(nil, noImageError);
        }
    }];
}

- (void)loadImageForActor:(Actor * )actor completion:(void (^)(UIImage *image, NSError *error))completion {
    
    NSString *profilePath;
    NSInteger identifier;
    
    profilePath = actor.profilePath;
    identifier = actor.actorId;
    
    UIImage *cachedImage = [self.imageCache objectForKey:profilePath];
    
    if (cachedImage) {
        completion(cachedImage, nil);
        return;
    }
    
    NSString *imageMetaDataUrl = [NSString stringWithFormat:@"%@%@", baseImagesURL, profilePath];
    
    [NetworkManager.sharedManager performRequestWithURL:imageMetaDataUrl completion:^(NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"Error descargando la imagen: %@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        UIImage *downloadedImage = [UIImage imageWithData:data];
        if (downloadedImage) {
            [self.imageCache setObject:downloadedImage forKey:profilePath];
            completion(downloadedImage, nil);
        } else {
            NSError *imageError = [NSError errorWithDomain:@"ImageDownloadError"
                                                      code:500
                                                  userInfo:@{@"Descripción del error": @"No se pudo descargar la imagen"}];
            completion(nil, imageError);
        }
    }];
    

}


@end
