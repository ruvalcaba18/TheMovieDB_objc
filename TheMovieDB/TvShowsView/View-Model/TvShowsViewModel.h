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
#import "TopFilerOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *popularTvShows;

-(instancetype)initTvShowsViewModel;
-(void)starFetchFirstOption:(OptionToSearch)option;
-(void)retrieveFilterSelected:(TopFilter)filterOption;
-(void) loadImageForTvShows:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion ;
-(NSString *)getDateCorrectFormat:(NSString *)dateToGiveFormat;
@end

NS_ASSUME_NONNULL_END
