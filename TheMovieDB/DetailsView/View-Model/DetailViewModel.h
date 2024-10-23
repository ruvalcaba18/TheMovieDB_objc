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
#import "MovieDetails.h"
#import "ShowDetail.h"
#import "NetworkManager.h"
#import "NSNumber+RoundFigures.h"
#import "NSData+ParseDataToObject.h"
#import "NSDictionary+JSONDictionaryDecoder.h"
#import  "GenerateURLDetails.h"
#import "NSArray+JSONArrayDecoder.h"
#import  "CastURLGenerator.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

@property (nonatomic,strong) TvSerie * serieDetails;
@property (nonatomic,strong) MovieDetails * movieDetails;

-(instancetype)initDetailViewModel;
- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSInteger)identifier ;
- (void)fetchCastForTvShowWithId:(NSInteger)showId completion:(void (^)(NSArray *cast,NSError *error))completion ;
- (NSString *)formattedCreators:(NSArray<Creator *> *)creators;

@end

NS_ASSUME_NONNULL_END
