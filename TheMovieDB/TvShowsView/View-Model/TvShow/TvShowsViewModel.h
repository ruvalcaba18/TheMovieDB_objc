//
//  TvShowsViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <Foundation/Foundation.h>

#import "TvShowsPopularModel.h"
#import "UIKit/UIKit.h"
#import "ImagesEndpoint.h"
#import "PostersObject.h"
#import "URLGenerator.h"
#import "NetworkManager.h"
#import "NSNumber+RoundFigures.h"
#import "NSData+ParseDataToObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *popularTvShows;

-(instancetype)initViewModel;
-(void)fetchShowsWithSearchOption:(OptionToSearch)option;
-(void)applyFilter:(TopFilter)filterOption;
-(void) loadImage:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion ;

@end

NS_ASSUME_NONNULL_END
