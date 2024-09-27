//
//  DetailViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailViewModel.h"

@interface DetailViewModel()

@property (nonatomic,assign) OptionToSearch optionSelected;
@property (nonatomic,strong) NSCache *imageCache;

-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;

@end

@implementation DetailViewModel
@synthesize serieDetails,movieDetails,imageCache,optionSelected;

- (nonnull instancetype)initDetailViewModel {
    
    self = [super init];
    
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier {
    
    NSString *url;
    self.optionSelected = option;
    
    switch (option) {
        case searchTvShows:
            url = [NSString stringWithFormat:@"%@%@/%@?api_key=%@",baseURL,tvShowsEndPoint,identifier,apiKey];
            break;
        case searchMovies:
            url = [NSString stringWithFormat:@"%@%@/%@?api_key=%@",baseURL,movieEndpoint,identifier,apiKey];
            break;
            
    }
    NSLog(@"fulll url %@",url);
   [ self performRequestWithURL:url completion:^(NSData *data, NSError *error) {
       
        if (error) {
            NSLog(@"Error %@",error);
        } else {
            [self decodeResponseData:data forOption:option];
        }
       
    }];
}


- (void)fetchCastForTvShowWithId:(NSInteger)showId completion:(void (^)(NSArray *cast,NSError *error))completion {
  
    NSString *urlString ;
    switch (  self.optionSelected) {
            
        case searchTvShows:
            urlString = [NSString stringWithFormat:@"%@%@/%ld/%@?api_key=%@", baseURL,tvShowsEndPoint,(long)showId, creditsEndPoint,apiKey];;
            break;
            
        case searchMovies:
            urlString = [NSString stringWithFormat:@"%@%@/%ld/%@?api_key=%@", baseURL,movieEndpoint,(long)showId, creditsEndPoint,apiKey];
            break;
            
    }


    [self performRequestWithURL:urlString completion:^(NSData *data, NSError *error) {
        
        if (error) {
            
            NSLog(@"Error fetching cast: %@", error.localizedDescription);
            completion(nil,error);
            
            return;
        }

        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            
            NSLog(@"Error parsing JSON: %@", jsonError.localizedDescription);
            completion(nil,jsonError);
            
            return;
        }

        [self decodeCastFromJSON: jsonResponse[@"cast"] ];
    }];
}

-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10.0];
   
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data,
                                                                                                                   NSURLResponse * _Nullable response,
                                                                                                                   NSError * _Nullable error) {
        if (error) {
            
            completion(nil,error);
            
        } else {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSError *statusError = [NSError errorWithDomain:@"HTTPError" code:httpResponse.statusCode userInfo:nil];
            
            switch (httpResponse.statusCode) {
                    
                case 200:
                    completion(data,nil);
                    break;
                    
                default:
                    break;
            }
           
        }
    }];
    
    [dataTask resume];
}



#pragma mark: - Decoders

- (void)decodeResponseData:(NSData *)data forOption:(OptionToSearch)option {
    
    NSError *jsonError;
    
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    
    if (jsonError) {
        
        NSLog(@"JSON error : %@", jsonError.localizedDescription);
        return;
        
    }
    if (option == searchTvShows) {
        
        TvSerie *tvShow = [[TvSerie alloc] init];
        
        tvShow.adult = jsonResponse[@"adult"] != [NSNull null] ? [jsonResponse[@"adult"] boolValue] : NO;
        tvShow.backdropPath = jsonResponse[@"backdrop_path"] != [NSNull null] ? jsonResponse[@"backdrop_path"] : @"";
        tvShow.createdBy = [self decodeCreatorsFromJSON: jsonResponse[@"created_by"] ?: @[] ] ;
        tvShow.episodeRunTime = jsonResponse[@"episode_run_time"] != [NSNull null] ? jsonResponse[@"episode_run_time"] : @[];
        tvShow.firstAirDate = jsonResponse[@"first_air_date"] != [NSNull null] ? jsonResponse[@"first_air_date"] : @"";
        tvShow.genres = [self decodeGenresFromJSON: jsonResponse[@"genres"] ?: @[] ] ;
        tvShow.homepage = jsonResponse[@"homepage"] != [NSNull null] ? jsonResponse[@"homepage"] : @"";
        tvShow.seriesId = jsonResponse[@"id"] != [NSNull null] ? [jsonResponse[@"id"] integerValue] : 0;
        tvShow.inProduction = jsonResponse[@"in_production"] != [NSNull null] ? [jsonResponse[@"in_production"] boolValue] : NO;
        tvShow.languages = jsonResponse[@"languages"] != [NSNull null] ? jsonResponse[@"languages"] : @[];
        tvShow.lastAirDate = jsonResponse[@"last_air_date"] != [NSNull null] ? jsonResponse[@"last_air_date"] : @"";
        tvShow.lastEpisodeToAir = [self decodeEpisodeFromJSON: jsonResponse[@"last_episode_to_air"]  ?: @{}] ;
        tvShow.name = jsonResponse[@"name"] != [NSNull null] ? jsonResponse[@"name"] : @"";
        tvShow.nextEpisodeToAir = [self decodeEpisodeFromJSON:jsonResponse[@"next_episode_to_air"] ?: @{} ] ;
        tvShow.networks = [self decodeNetworksFromJSON: jsonResponse[@"networks"] ?: @[]] ;
        tvShow.numberOfEpisodes = jsonResponse[@"number_of_episodes"] != [NSNull null] ? [jsonResponse[@"number_of_episodes"] integerValue] : 0;
        tvShow.numberOfSeasons = jsonResponse[@"number_of_seasons"] != [NSNull null] ? [jsonResponse[@"number_of_seasons"] integerValue] : 0;
        tvShow.originCountry = jsonResponse[@"origin_country"] != [NSNull null] ? jsonResponse[@"origin_country"] : @[];
        tvShow.originalLanguage = jsonResponse[@"original_language"] != [NSNull null] ? jsonResponse[@"original_language"] : @"";
        tvShow.originalName = jsonResponse[@"original_name"] != [NSNull null] ? jsonResponse[@"original_name"] : @"";
        tvShow.overview = jsonResponse[@"overview"] != [NSNull null] ? jsonResponse[@"overview"] : @"";
        tvShow.popularity = jsonResponse[@"popularity"] != [NSNull null] ? jsonResponse[@"popularity"] : @0;
        tvShow.posterPath = jsonResponse[@"poster_path"] != [NSNull null] ? jsonResponse[@"poster_path"] : @"";
        tvShow.seasons = [self decodeSeasonsFromJSON:jsonResponse[@"seasons"] ?: @[]] ;
        tvShow.status = jsonResponse[@"status"] != [NSNull null] ? jsonResponse[@"status"] : @"";
        tvShow.tagline = jsonResponse[@"tagline"] != [NSNull null] ? jsonResponse[@"tagline"] : @"";
        tvShow.type = jsonResponse[@"type"] != [NSNull null] ? jsonResponse[@"type"] : @"";
        tvShow.voteAverage = jsonResponse[@"vote_average"] != [NSNull null] ? jsonResponse[@"vote_average"] : @0;
        tvShow.voteCount = jsonResponse[@"vote_count"] != [NSNull null] ? [jsonResponse[@"vote_count"] integerValue] : 0;

        self.serieDetails = tvShow;
        
    } else if (option == searchMovies) {
        
        MovieDetails *movie = [[MovieDetails alloc] init];
        
        movie.adult = jsonResponse[@"adult"] != [NSNull null] ? [jsonResponse[@"adult"] boolValue] : NO;
        movie.backdropPath = jsonResponse[@"backdrop_path"] != [NSNull null] ? jsonResponse[@"backdrop_path"] : @"";
        movie.belongsToCollection = jsonResponse[@"belongs_to_collection"] != [NSNull null] ? jsonResponse[@"belongs_to_collection"] : nil;
        movie.budget = jsonResponse[@"budget"] != [NSNull null] ? [jsonResponse[@"budget"] integerValue] : 0;
        movie.genres = [self decodeGenresFromJSON:jsonResponse[@"genres"] ?: @[] ] ;
        movie.homepage = jsonResponse[@"homepage"] != [NSNull null] ? jsonResponse[@"homepage"] : @"";
        movie.movieId = jsonResponse[@"id"] != [NSNull null] ? [jsonResponse[@"id"] integerValue] : 0;
        movie.imdbId = jsonResponse[@"imdb_id"] != [NSNull null] ? jsonResponse[@"imdb_id"] : @"";
        movie.originalLanguage = jsonResponse[@"original_language"] != [NSNull null] ? jsonResponse[@"original_language"] : @"";
        movie.originalTitle = jsonResponse[@"original_title"] != [NSNull null] ? jsonResponse[@"original_title"] : @"";
        movie.overview = jsonResponse[@"overview"] != [NSNull null] ? jsonResponse[@"overview"] : @"";
        movie.popularity = jsonResponse[@"popularity"] != [NSNull null] ? [jsonResponse[@"popularity"] floatValue] : 0;
        movie.posterPath = jsonResponse[@"poster_path"] != [NSNull null] ? jsonResponse[@"poster_path"] : @"";
        movie.productionCompanies = [self decodeProductionCompaniesFromJSON: jsonResponse[@"production_companies"] ?: @[] ] ;
        movie.productionCountries = [self decodeProductionCountriesFromJSON: jsonResponse[@"production_countries"]  ?: @[] ] ;
        movie.releaseDate = jsonResponse[@"release_date"] != [NSNull null] ? jsonResponse[@"release_date"] : @"";
        movie.revenue = jsonResponse[@"revenue"] != [NSNull null] ? [jsonResponse[@"revenue"] integerValue] : 0;
        movie.runtime = jsonResponse[@"runtime"] != [NSNull null] ? [jsonResponse[@"runtime"] integerValue] : 0;
        movie.spokenLanguages = [self decodeSpokenLanguagesFromJSON: jsonResponse[@"spoken_languages"] ?: @[] ] ;
        movie.status = jsonResponse[@"status"] != [NSNull null] ? jsonResponse[@"status"] : @"";
        movie.tagline = jsonResponse[@"tagline"] != [NSNull null] ? jsonResponse[@"tagline"] : @"";
        movie.title = jsonResponse[@"title"] != [NSNull null] ? jsonResponse[@"title"] : @"";
        movie.video = jsonResponse[@"video"] != [NSNull null] ? [jsonResponse[@"video"] boolValue] : NO;
        movie.voteAverage = jsonResponse[@"vote_average"] != [NSNull null] ? jsonResponse[@"vote_average"]  : 0;
        movie.voteCount = jsonResponse[@"vote_count"] != [NSNull null] ? [jsonResponse[@"vote_count"] integerValue] : 0;

        self.movieDetails = movie;

    }
}


- (NSArray<Genre *> *)decodeGenresFromJSON:(NSArray *)jsonArray {
    
    if ( ![jsonArray isKindOfClass:[NSDictionary class]] || jsonArray.count <= 0 ){
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

- (NSArray<ProductionCompany *> *)decodeProductionCompaniesFromJSON:(NSArray *)jsonCompanies {
    
    NSMutableArray *companiesArray = [NSMutableArray array];
    
    if (![jsonCompanies isKindOfClass:[NSDictionary class]] || jsonCompanies.count <= 0 ){
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

- (NSArray<ProductionCountry *> *)decodeProductionCountriesFromJSON:(NSArray *)jsonCountries {
    
    if ( ![jsonCountries isKindOfClass:[NSDictionary class]] || jsonCountries.count <= 0 ){
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

- (NSArray<SpokenLanguage *> *)decodeSpokenLanguagesFromJSON:(NSArray *)jsonLanguages {
    
    if (  ![jsonLanguages isKindOfClass:[NSDictionary class]] || jsonLanguages.count <= 0 ){
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

- (NSArray<Creator *> *)decodeCreatorsFromJSON:(NSArray *)jsonCreators {
    
    if (![jsonCreators isKindOfClass:[NSDictionary class]] || jsonCreators.count <= 0 ){
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

- (Episode *)decodeEpisodeFromJSON:(NSDictionary *)jsonEpisode {
    
    if ( ![jsonEpisode isKindOfClass:[NSDictionary class]] || jsonEpisode.count <= 0 ){
        return nil;
    }
    
    Episode *episode = [[Episode alloc] init];
    
    episode.episodeId = [jsonEpisode[@"id"] integerValue];
    episode.name = jsonEpisode[@"name"];
    episode.airDate = jsonEpisode[@"air_date"];
    episode.episodeNumber = [jsonEpisode[@"episode_number"] integerValue];
    episode.seasonNumber = [jsonEpisode[@"season_number"] integerValue];
    episode.overview = jsonEpisode[@"overview"];
    
    return episode;
}

- (NSArray<NetworkModel *> *)decodeNetworksFromJSON:(NSArray *)jsonNetworks {
    
    if ( ![jsonNetworks isKindOfClass:[NSDictionary class]] || jsonNetworks.count <= 0 ){
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

- (NSArray<Season *> *)decodeSeasonsFromJSON:(NSArray *)jsonSeasons {
    
    if ( ![jsonSeasons isKindOfClass:[NSDictionary class]] || jsonSeasons.count <= 0 ){
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

-(NSArray<Actor *> *)decodeCastFromJSON:(NSArray *)jsonCast {
    
    if ( ![jsonCast isKindOfClass:[NSDictionary class]] || jsonCast.count <= 0 ){
        return nil;
    }
    
    NSMutableArray *castList = [NSMutableArray array];
    
    for (NSDictionary *castMemberDict in jsonCast) {
        
        Actor *castMember = [[Actor alloc] initWithDictionary:castMemberDict];
        
        [castList addObject:castMember];
    }
    
    return castList;
}

#pragma mark: - functions that transform variables

-(NSString *)formatDate:(NSString *)dateToGiveFormatt {
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:@"yyy-MM-dd"];
    
    NSDate *date = [inputFormatter dateFromString:dateToGiveFormatt];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM dd, yyyy"];
    
    NSString *formattedDate = [outputFormatter stringFromDate:date];
    return formattedDate;
}

- (NSNumber *)roundToSingleDecimal:(NSNumber *)number {
    
    if (![number isKindOfClass:[NSNumber class]]) {
           NSLog(@"El valor proporcionado no es un NSNumber: %@", number);
           return @(0);
       }
    
    float roundedValue = roundf(number.floatValue * 10) / 10;
    return @(roundedValue);
    
}

- (NSString *)formattedCreators:(NSArray<Creator *> *)creators {
    
    NSMutableSet *uniqueCreators = [NSMutableSet set];
    NSMutableArray *creatorNames = [NSMutableArray array];
    
    for (Creator *creator in creators) {
        
        if (![uniqueCreators containsObject:creator.name]) {
            
            [uniqueCreators addObject:creator.name];
            [creatorNames addObject:creator.name];
        }
    }
    
    return [NSString stringWithFormat:@"Created by: %@", [creatorNames componentsJoinedByString:@", "]];
}

@end
