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
#import "CastMember.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

-(instancetype)initDetailViewModel;
- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier ;
- (NSNumber *)roundToSingleDecimal:(NSNumber *)number;
-(NSString *)formatDate:(NSString *)dateToGiveFormatt;

@end

NS_ASSUME_NONNULL_END
