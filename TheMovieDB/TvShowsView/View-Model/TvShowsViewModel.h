//
//  TvShowsViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "TvShowsModel.h"
#import "TvShowsPopularModel.h"
#import "OptionToSearch.h"
#import "UIKit/UIKit.h"
#import "ImagesEndpoint.h"
#import "PostersObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *popularTvShows;

-(instancetype)initTvShowsViewModel;
-(void)starFetchOption:(OptionToSearch)option;
-(void) loadImageForTvShows:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion ;
@end

NS_ASSUME_NONNULL_END
