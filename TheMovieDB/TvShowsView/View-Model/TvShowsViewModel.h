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
#import "TopFilterOption.h"

NS_ASSUME_NONNULL_BEGIN

@interface TvShowsViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *popularTvShows;

-(instancetype)initViewModel;
-(void)fetchShowsWithSearchOption:(OptionToSearch)option;
-(void)applyFilter:(TopFilter)filterOption;
-(void) loadImageForShow:(TvShowsPopularModel *)tvShow completion:(void (^)(UIImage *image, NSError *error)) completion ;
-(NSString *)formatDate:(NSString *)dateToGiveFormat;
- (NSNumber *)roundToSingleDecimal:(NSNumber *)number;
@end

NS_ASSUME_NONNULL_END
