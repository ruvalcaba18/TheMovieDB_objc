//
//  DetailViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailViewModel.h"

@interface DetailViewModel()

@property (nonatomic,strong) NSCache *imageCache;
@property (nonatomic,strong) TvSerie *serieDetails;
@property (nonatomic,strong) MovieDetails *movieDetails;


-(void)performRequestWithURL:(NSString *)urlString completion:(void (^)(NSData *data,NSError *error))completion;

@end

@implementation DetailViewModel
@synthesize serieDetails,movieDetails,imageCache;

- (nonnull instancetype)initDetailViewModel {
    
    self = [super init];
    
    if (self) {
        self.imageCache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier {
    
    NSString *url;
    
    switch (option) {
            
        case searchTvShows:
            
            url = [NSString stringWithFormat:@"%@%@/%@",baseURL,tvShowsEndPoint,identifier];
            break;
            
        case searchMovies:
            
            url = [NSString stringWithFormat:@"%@%@/%@",baseURL,movieEndpoint,identifier];
            break;
            
    }
    
   [ self performRequestWithURL:url completion:^(NSData *data, NSError *error) {
       
        if (error) {
            NSLog(@"Error %@",error);
        } else {
            [self decodeResponseData:data forOption:option];
        }
       
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
        
        tvShow.adult = [jsonResponse[@"adult"] boolValue];
        tvShow.backdropPath = jsonResponse[@"backdrop_path"];
        tvShow.createdBy = [self decodeCreatorsFromJSON:jsonResponse[@"created_by"]];
        tvShow.episodeRunTime = jsonResponse[@"episode_run_time"];
        tvShow.firstAirDate = jsonResponse[@"first_air_date"];
        tvShow.genres = [self decodeGenresFromJSON:jsonResponse[@"genres"]];
        tvShow.homepage = jsonResponse[@"homepage"];
        tvShow.seriesId = [jsonResponse[@"id"] integerValue];
        tvShow.inProduction = [jsonResponse[@"in_production"] boolValue];
        tvShow.languages = jsonResponse[@"languages"];
        tvShow.lastAirDate = jsonResponse[@"last_air_date"];
        tvShow.lastEpisodeToAir = [self decodeEpisodeFromJSON:jsonResponse[@"last_episode_to_air"]];
        tvShow.name = jsonResponse[@"name"];
        tvShow.nextEpisodeToAir = [self decodeEpisodeFromJSON:jsonResponse[@"next_episode_to_air"]];
        tvShow.networks = [self decodeNetworksFromJSON:jsonResponse[@"networks"]];
        tvShow.numberOfEpisodes = [jsonResponse[@"number_of_episodes"] integerValue];
        tvShow.numberOfSeasons = [jsonResponse[@"number_of_seasons"] integerValue];
        tvShow.originCountry = jsonResponse[@"origin_country"];
        tvShow.originalLanguage = jsonResponse[@"original_language"];
        tvShow.originalName = jsonResponse[@"original_name"];
        tvShow.overview = jsonResponse[@"overview"];
        tvShow.popularity = jsonResponse[@"popularity"];
        tvShow.posterPath = jsonResponse[@"poster_path"];
        tvShow.seasons = [self decodeSeasonsFromJSON:jsonResponse[@"seasons"]];
        tvShow.status = jsonResponse[@"status"];
        tvShow.tagline = jsonResponse[@"tagline"];
        tvShow.type = jsonResponse[@"type"];
        tvShow.voteAverage = jsonResponse[@"vote_average"];
        tvShow.voteCount = [jsonResponse[@"vote_count"] integerValue];

        self.serieDetails = tvShow;
        self.movieDetails = nil;
        
    } else if (option == searchMovies) {
        
        MovieDetails *movie = [[MovieDetails alloc] init];
        
        movie.adult = [jsonResponse[@"adult"] boolValue];
        movie.backdropPath = jsonResponse[@"backdrop_path"];
        movie.belongsToCollection = jsonResponse[@"belongs_to_collection"];
        movie.budget = [jsonResponse[@"budget"] integerValue];
        movie.genres = [self decodeGenresFromJSON:jsonResponse[@"genres"]];
        movie.homepage = jsonResponse[@"homepage"];
        movie.movieId = [jsonResponse[@"id"] integerValue];
        movie.imdbId = jsonResponse[@"imdb_id"];
        movie.originalLanguage = jsonResponse[@"original_language"];
        movie.originalTitle = jsonResponse[@"original_title"];
        movie.overview = jsonResponse[@"overview"];
        movie.popularity = [jsonResponse[@"popularity"] floatValue];
        movie.posterPath = jsonResponse[@"poster_path"];
        movie.productionCompanies = [self decodeProductionCompaniesFromJSON:jsonResponse[@"production_companies"]];
        movie.productionCountries = [self decodeProductionCountriesFromJSON:jsonResponse[@"production_countries"]];
        movie.releaseDate = jsonResponse[@"release_date"];
        movie.revenue = [jsonResponse[@"revenue"] integerValue];
        movie.runtime = [jsonResponse[@"runtime"] integerValue];
        movie.spokenLanguages = [self decodeSpokenLanguagesFromJSON:jsonResponse[@"spoken_languages"]];
        movie.status = jsonResponse[@"status"];
        movie.tagline = jsonResponse[@"tagline"];
        movie.title = jsonResponse[@"title"];
        movie.video = [jsonResponse[@"video"] boolValue];
        movie.voteAverage = [jsonResponse[@"vote_average"] floatValue];
        movie.voteCount = [jsonResponse[@"vote_count"] integerValue];
        
        self.movieDetails = movie;
        self.serieDetails = nil;
    }
}


- (NSArray<Genre *> *)decodeGenresFromJSON:(NSArray *)jsonArray {
    
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
    
    double roundedValue = round([number doubleValue] * 10) / 10.0;
    return [NSNumber numberWithDouble:roundedValue];
    
}

@end
