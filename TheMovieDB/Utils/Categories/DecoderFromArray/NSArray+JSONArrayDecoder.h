//
//  NSArray+JSONArrayDecoder.h
//  TheMovieDB
//
//  Created by The Coding Kid on 15/10/2024.
//

#import <Foundation/Foundation.h>
#import "Genre.h"
#import "ProductionCompany.h"
#import "ProductionCountry.h"
#import "SpokenLanguage.h"
#import "Creator.h"
#import "NetworkModel.h"
#import "Season.h"
#import "Actor.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JSONArrayDecoder)

+ (NSArray<Genre *> *)decodeGenresFromJSON:(NSArray *)jsonArray ;
+ (NSArray<ProductionCompany *> *)decodeProductionCompaniesFromJSON:(NSArray *)jsonCompanies;
+ (NSArray<ProductionCountry *> *)decodeProductionCountriesFromJSON:(NSArray *)jsonCountries;
+ (NSArray<SpokenLanguage *> *)decodeSpokenLanguagesFromJSON:(NSArray *)jsonLanguages;
+ (NSArray<Creator *> *)decodeCreatorsFromJSON:(NSArray *)jsonCreators;
+ (NSArray<NetworkModel *> *)decodeNetworksFromJSON:(NSArray *)jsonNetworks;
+ (NSArray<Season *> *)decodeSeasonsFromJSON:(NSArray *)jsonSeasons;
+ (NSArray<Actor *> *)decodeCastFromJSON:(NSArray *)jsonCast ;

@end

NS_ASSUME_NONNULL_END
