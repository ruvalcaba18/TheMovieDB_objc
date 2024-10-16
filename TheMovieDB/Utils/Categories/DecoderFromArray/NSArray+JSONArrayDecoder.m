//
//  NSArray+JSONArrayDecoder.m
//  TheMovieDB
//
//  Created by The Coding Kid on 15/10/2024.
//

#import "NSArray+JSONArrayDecoder.h"

@implementation NSArray (JSONArrayDecoder)

+(NSArray<Genre *> *)decodeGenresFromJSON:(NSArray *)jsonArray {
    
    if ( ![jsonArray isKindOfClass:[NSArray class]] || jsonArray.count <= 0 ){
        return nil;
    }
    
    NSMutableArray<Genre *> *genres = [NSMutableArray array];
    
    for (NSDictionary *genreDict in jsonArray) {
        
        Genre *genre = [[Genre alloc] init];
        genre.genreId = [genreDict[@"id"] integerValue];
        genre.name = genreDict[@"name"];
        [genres addObject:genre];
        
    }
    
    return genres;
}

+ (NSArray<ProductionCompany *> *)decodeProductionCompaniesFromJSON:(NSArray *)jsonCompanies {
    
    NSMutableArray *companiesArray = [NSMutableArray array];
    
    if (![jsonCompanies isKindOfClass:[NSArray class]] || jsonCompanies.count <= 0 ){
        return nil;
    }
    
    for (NSDictionary *jsonCompany in jsonCompanies) {
        
        ProductionCompany *company = [[ProductionCompany alloc] init];
        
        company.companyId = [jsonCompany[@"id"] integerValue];
        company.logoPath = jsonCompany[@"logo_path"];
        company.name = jsonCompany[@"name"];
        company.originCountry = jsonCompany[@"origin_country"];
        
        [companiesArray addObject:company];
    }
    
    return [companiesArray copy];
}

 + (NSArray<ProductionCountry *> *)decodeProductionCountriesFromJSON:(NSArray *)jsonCountries {
    
    if ( ![jsonCountries isKindOfClass:[NSArray class]] || jsonCountries.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *countriesArray = [NSMutableArray array];
    
    for (NSDictionary *jsonCountry in jsonCountries) {
        
        ProductionCountry *country = [[ProductionCountry alloc] init];
        
        country.iso3166_1 = jsonCountry[@"iso_3166_1"];
        country.name = jsonCountry[@"name"];
        
        [countriesArray addObject:country];
    }
    return [countriesArray copy];
}

+  (NSArray<SpokenLanguage *> *)decodeSpokenLanguagesFromJSON:(NSArray *)jsonLanguages {
    
    if (  ![jsonLanguages isKindOfClass:[NSArray class]] || jsonLanguages.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *languagesArray = [NSMutableArray array];
    
    for (NSDictionary *jsonLanguage in jsonLanguages) {
        
        SpokenLanguage *language = [[SpokenLanguage alloc] init];
        
        language.iso639_1 = jsonLanguage[@"iso_639_1"];
        language.name = jsonLanguage[@"name"];
        
        [languagesArray addObject:language];
        
    }
    
    return [languagesArray copy];
}

+ (NSArray<Creator *> *)decodeCreatorsFromJSON:(NSArray *)jsonCreators {
    
    if (![jsonCreators isKindOfClass:[NSArray class]] || jsonCreators.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *creatorsArray = [NSMutableArray array];
    
    for (NSDictionary *jsonCreator in jsonCreators) {
        
        Creator *creator = [[Creator alloc] init];
        creator.creatorId = [jsonCreator[@"id"] integerValue];
        creator.name = jsonCreator[@"name"];
        creator.profilePath = jsonCreator[@"profile_path"];
        
        [creatorsArray addObject:creator];
    }
    
    return [creatorsArray copy];
}

+ (NSArray<NetworkModel *> *)decodeNetworksFromJSON:(NSArray *)jsonNetworks {
    
    if ( ![jsonNetworks isKindOfClass:[NSArray class]] || jsonNetworks.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *networksArray = [NSMutableArray array];
    
    for (NSDictionary *jsonNetwork in jsonNetworks) {
        
        NetworkModel *network = [[NetworkModel alloc] init];
        
        network.networkId = [jsonNetwork[@"id"] integerValue];
        network.name = jsonNetwork[@"name"];
        network.logoPath = jsonNetwork[@"logo_path"];
        network.originCountry = jsonNetwork[@"origin_country"];
        
        [networksArray addObject:network];
    }
    
    return [networksArray copy];
}

+ (NSArray<Season *> *)decodeSeasonsFromJSON:(NSArray *)jsonSeasons {
    
    if ( ![jsonSeasons isKindOfClass:[NSArray class]] || jsonSeasons.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *seasonsArray = [NSMutableArray array];
    
    for (NSDictionary *jsonSeason in jsonSeasons) {
        
        Season *season = [[Season alloc] init];
        
        season.seasonId = [jsonSeason[@"id"] integerValue];
        season.name = jsonSeason[@"name"];
        season.airDate = jsonSeason[@"air_date"];
        season.episodeCount = [jsonSeason[@"episode_count"] integerValue];
        season.posterPath = jsonSeason[@"poster_path"];
        
        [seasonsArray addObject:season];
    }
    
    return [seasonsArray copy];
}


+ (NSArray<Actor *> *)decodeCastFromJSON:(NSArray *)jsonCast {
    
    if ( ![jsonCast isKindOfClass:[NSArray class]] || jsonCast.count <= 0 ){
        NSLog(@"is not a NSArray");
        return nil;
    }
    
    NSMutableArray *castList = [NSMutableArray array];
    for (NSDictionary *castMemberDict in jsonCast) {
        
        Actor *castMember = [[Actor alloc] initWithDictionary:castMemberDict];
        [castList addObject:castMember];
    }
    return castList;
}



@end
