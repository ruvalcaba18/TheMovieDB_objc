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
    
    NSString *url = [URLGenerator generateURLForOption:option];
  
    [NetworkManager.sharedManager performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error %@",error.localizedDescription);
        } else {
            self.popularTvShows = [NSData parseTvShowData:data];
        }
    }];
}


- (void)applyFilter:(TopFilter)filterOption {
    
    NSString *url = [URLGenerator generateURLForFilter:filterOption];
   
    [NetworkManager.sharedManager performRequestWithURL:url completion:^(NSData *data, NSError *error) {
        if (error) {
            
        } else {
            [self.popularTvShows removeAllObjects];
            self.popularTvShows = [NSData parseTvShowData:data];
        }
    }];
    
}

-(void) loadImage:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion {
    
    [NetworkManager.sharedManager  loadImageForShow:tvShow completion:^(UIImage *image, NSError *error) {
        completion(image,error);
    }];
}

@end
