//
//  DetailViewModel.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailViewModel.h"

@interface DetailViewModel()

@property (nonatomic,assign) OptionToSearch optionSelected;

@end

@implementation DetailViewModel
@synthesize serieDetails,movieDetails,optionSelected;

- (nonnull instancetype)initDetailViewModel {
    
    self = [super init];
    
    if (self) {
    }
    
    return self;
}

- (void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSInteger )identifier {
    
    GenerateURLDetails *urlDetails = [[GenerateURLDetails alloc] initGenerateURLDetails];
    
    self.optionSelected = option;

    [ NetworkManager.sharedManager performRequestWithURL: [urlDetails generateURLFor:option withIdentifier: identifier] completion:^(NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@",error);
        } else {
            [self decodeResponseData:data forOption:option];
        }
        
    }];
    
}


- (void)fetchCastForTvShowWithId:(NSInteger)showId completion:(void (^)(NSArray *cast,NSError *error))completion {
    
    CastURLGenerator *castURL = [[CastURLGenerator alloc] initCastGenerator];
    
    [NetworkManager.sharedManager performRequestWithURL: [castURL generateURLFor: self.optionSelected withIdentifier: showId] completion:^(NSData *data, NSError *error) {
        
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
        
        completion( [NSArray decodeCastFromJSON: jsonResponse[@"cast"] ],nil);
    }];
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
        tvShow.createdBy = [NSArray decodeCreatorsFromJSON: jsonResponse[@"created_by"] ?: @[] ] ;
        tvShow.episodeRunTime = jsonResponse[@"episode_run_time"] != [NSNull null] ? jsonResponse[@"episode_run_time"] : @[];
        tvShow.firstAirDate = jsonResponse[@"first_air_date"] != [NSNull null] ? jsonResponse[@"first_air_date"] : @"";
        tvShow.genres = [NSArray decodeGenresFromJSON: jsonResponse[@"genres"] ?: @[] ] ;
        tvShow.homepage = jsonResponse[@"homepage"] != [NSNull null] ? jsonResponse[@"homepage"] : @"";
        tvShow.seriesId = jsonResponse[@"id"] != [NSNull null] ? [jsonResponse[@"id"] integerValue] : 0;
        tvShow.inProduction = jsonResponse[@"in_production"] != [NSNull null] ? [jsonResponse[@"in_production"] boolValue] : NO;
        tvShow.languages = jsonResponse[@"languages"] != [NSNull null] ? jsonResponse[@"languages"] : @[];
        tvShow.lastAirDate = jsonResponse[@"last_air_date"] != [NSNull null] ? jsonResponse[@"last_air_date"] : @"";
        tvShow.lastEpisodeToAir = [NSDictionary decodeEpisodeFromJSON: jsonResponse[@"last_episode_to_air"]  ?: @{}] ;
        tvShow.name = jsonResponse[@"name"] != [NSNull null] ? jsonResponse[@"name"] : @"";
        tvShow.nextEpisodeToAir = [NSDictionary decodeEpisodeFromJSON:jsonResponse[@"next_episode_to_air"] ?: @{} ] ;
        tvShow.networks = [NSArray decodeNetworksFromJSON: jsonResponse[@"networks"] ?: @[]] ;
        tvShow.numberOfEpisodes = jsonResponse[@"number_of_episodes"] != [NSNull null] ? [jsonResponse[@"number_of_episodes"] integerValue] : 0;
        tvShow.numberOfSeasons = jsonResponse[@"number_of_seasons"] != [NSNull null] ? [jsonResponse[@"number_of_seasons"] integerValue] : 0;
        tvShow.originCountry = jsonResponse[@"origin_country"] != [NSNull null] ? jsonResponse[@"origin_country"] : @[];
        tvShow.originalLanguage = jsonResponse[@"original_language"] != [NSNull null] ? jsonResponse[@"original_language"] : @"";
        tvShow.originalName = jsonResponse[@"original_name"] != [NSNull null] ? jsonResponse[@"original_name"] : @"";
        tvShow.overview = jsonResponse[@"overview"] != [NSNull null] ? jsonResponse[@"overview"] : @"";
        tvShow.popularity = jsonResponse[@"popularity"] != [NSNull null] ? jsonResponse[@"popularity"] : @0;
        tvShow.posterPath = jsonResponse[@"poster_path"] != [NSNull null] ? jsonResponse[@"poster_path"] : @"";
        tvShow.seasons = [NSArray decodeSeasonsFromJSON:jsonResponse[@"seasons"] ?: @[]] ;
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
        movie.genres = [NSArray decodeGenresFromJSON:jsonResponse[@"genres"] ?: @[] ] ;
        movie.homepage = jsonResponse[@"homepage"] != [NSNull null] ? jsonResponse[@"homepage"] : @"";
        movie.movieId = jsonResponse[@"id"] != [NSNull null] ? [jsonResponse[@"id"] integerValue] : 0;
        movie.imdbId = jsonResponse[@"imdb_id"] != [NSNull null] ? jsonResponse[@"imdb_id"] : @"";
        movie.originalLanguage = jsonResponse[@"original_language"] != [NSNull null] ? jsonResponse[@"original_language"] : @"";
        movie.originalTitle = jsonResponse[@"original_title"] != [NSNull null] ? jsonResponse[@"original_title"] : @"";
        movie.overview = jsonResponse[@"overview"] != [NSNull null] ? jsonResponse[@"overview"] : @"";
        movie.popularity = jsonResponse[@"popularity"] != [NSNull null] ? [jsonResponse[@"popularity"] floatValue] : 0;
        movie.posterPath = jsonResponse[@"poster_path"] != [NSNull null] ? jsonResponse[@"poster_path"] : @"";
        movie.productionCompanies = [NSArray decodeProductionCompaniesFromJSON: jsonResponse[@"production_companies"] ?: @[] ] ;
        movie.productionCountries = [NSArray decodeProductionCountriesFromJSON: jsonResponse[@"production_countries"]  ?: @[] ] ;
        movie.releaseDate = jsonResponse[@"release_date"] != [NSNull null] ? jsonResponse[@"release_date"] : @"";
        movie.revenue = jsonResponse[@"revenue"] != [NSNull null] ? [jsonResponse[@"revenue"] integerValue] : 0;
        movie.runtime = jsonResponse[@"runtime"] != [NSNull null] ? [jsonResponse[@"runtime"] integerValue] : 0;
        movie.spokenLanguages = [NSArray decodeSpokenLanguagesFromJSON: jsonResponse[@"spoken_languages"] ?: @[] ] ;
        movie.status = jsonResponse[@"status"] != [NSNull null] ? jsonResponse[@"status"] : @"";
        movie.tagline = jsonResponse[@"tagline"] != [NSNull null] ? jsonResponse[@"tagline"] : @"";
        movie.title = jsonResponse[@"title"] != [NSNull null] ? jsonResponse[@"title"] : @"";
        movie.video = jsonResponse[@"video"] != [NSNull null] ? [jsonResponse[@"video"] boolValue] : NO;
        movie.voteAverage = jsonResponse[@"vote_average"] != [NSNull null] ? jsonResponse[@"vote_average"]  : 0;
        movie.voteCount = jsonResponse[@"vote_count"] != [NSNull null] ? [jsonResponse[@"vote_count"] integerValue] : 0;
        
        self.movieDetails = movie;
        
    }
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
