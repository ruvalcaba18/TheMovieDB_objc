//
//  DetailViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>
#import "OptiontoSearch.h"
#import "Constants.h"
#import "TvSerie.h"
#import "Genre.h"
#import "MovieDetails.h"
#import "Creator.h"
#import "NetworkModel.h"
#import "Season.h"
#import "Episode.h"
#import "ProductionCompany.h"
#import "ProductionCountry.h"
#import "SpokenLanguage.h"
#import "ShowDetail.h"
#import "Actor.h"
#import "UIKit/UIKit.h"
#import "PostersObject.h"
#import "TvShowsPopularModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

@property (nonatomic,strong) TvSerie * serieDetails;
@property (nonatomic,strong) MovieDetails * movieDetails;

-(instancetype)initDetailViewModel;
- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier ;
- (NSNumber *)roundToSingleDecimal:(NSNumber *_Nullable )number;
-(NSString *)formatDate:(NSString *)dateToGiveFormatt;
- (void)fetchCastForTvShowWithId:(NSInteger)showId completion:(void (^)(NSArray *cast,NSError *error))completion ;
- (NSString *)formattedCreators:(NSArray<Creator *> *)creators;
- (void)loadImageForShow:(TvShowsPopularModel *)show completion:(void (^)(UIImage *image, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
